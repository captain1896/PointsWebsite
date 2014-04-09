package com.buzzinate.bshare.points.processor;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.StatelessSession;
import org.hibernate.Transaction;

import com.buzzinate.bshare.points.bean.ActivityDailyStatistic;
import com.buzzinate.bshare.points.db.MasterSlaveRoutingDataSource;
import com.buzzinate.bshare.points.db.MasterSlaveRoutingDataSource.DataSourceType;
import com.buzzinate.common.task.BasicStatisticProcessor;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.string.StringUtil;

/**
 * This class cache the points statistics to be inserted and insert bunch of
 * them together to improve performance. The thread will wait until the queue
 * has more than <BATCH_SIZE> views or <INTERVAL> of milliseconds has elapsed.
 * Then it starts to insert cached views with Hibernate stateless session.
 * 
 * @author Martin Zhou
 * 
 */

public class PointsStatisticProcessor extends BasicStatisticProcessor implements Serializable {

    private static final int CAPACITY = 
                    ConfigurationReader.getInt("bshare.cache.points.queue.capacity");
    private static final int BATCH_SIZE = 
                    ConfigurationReader.getInt("bshare.cache.points.queue.batch.size");
    private static final int INTERVAL = 
                    ConfigurationReader.getInt("bshare.cache.points.queue.interval");
    
    private static final long serialVersionUID = -4894142256574946556L;

    private static Log log = LogFactory.getLog(PointsStatisticProcessor.class);

    private SessionFactory sessionFactory;

    
    public PointsStatisticProcessor(SessionFactory sessionFactory) {
        super(CAPACITY, BATCH_SIZE, INTERVAL);
        this.sessionFactory = sessionFactory;
    }


    /**
     * This is the main worker function for the StatisticProcessor. Call this
     * function directly to process a task immediately.
     * 
     * @param stats
     */
    @Override
    protected void workerFunction(List<Object> stats) {
        /*
         * The processor create a map for each kind of daily statistics and
         * process each individual object to increase or update statistics in
         * each map. At the end, it save everything into database.
         */

        Map<String, ActivityDailyStatistic> activityDailyMap = new HashMap<String, ActivityDailyStatistic>();
        // Process each statistic object
        for (Object o : stats) {
            try {
                if (o instanceof ActivityDailyStatistic) {
                    ActivityDailyStatistic s = (ActivityDailyStatistic) o;
                    insertOrUpdateActivityDailyInMap(activityDailyMap, s);
                } 
            } catch (Exception e) {
                // catch in case exception cause processor to stop
                log.error("Points statistic processor exception: ", e);
            }
        }

        // update in main db
        try {
            MasterSlaveRoutingDataSource.setDataSourceType(DataSourceType.MASTER_POINTS);
            if (activityDailyMap.size() > 0) {
                saveActivityDailyIntoDatabase(activityDailyMap);
            }
            log.info("Points statistic processor: activity daily stats saved.");
        } catch (Exception e) {
            log.error("Points statistic processor exception when updating main db: ", e);
        }
    }

    private void saveActivityDailyIntoDatabase(final Map<String, ActivityDailyStatistic> activityDailyMap) {
        this.executeQuery(new Command() {
            @Override
            public void execute(StatelessSession session) {
                Query query = session.getNamedQuery("ActivityDaily.insertOrUpdate");
                for (ActivityDailyStatistic ad : activityDailyMap.values()) {
                    query.setInteger("activityId", ad.getActivityId());
                    query.setInteger("platformId", ad.getPlatformId());
                    query.setDate("date", ad.getDate());
                    query.setBinary("uuid", ad.getUuid());
                    query.setLong("shareCount", ad.getShareCount());
                    query.setLong("clickbackCount", ad.getClickbackCount());
                    query.executeUpdate();
                }
            }
        });
    }

    private void insertOrUpdateActivityDailyInMap(Map<String, ActivityDailyStatistic> activityDailyMap,
            ActivityDailyStatistic newActivityDaily) {

        String key = newActivityDaily.getKey();
        ActivityDailyStatistic activityDaily = activityDailyMap.get(key);
        if (activityDaily == null) {
            activityDaily = newActivityDaily;
            activityDailyMap.put(key, activityDaily);
        }
        activityDaily.increaseStatistic(newActivityDaily.getType());
    }

    private void executeQuery(Command command) {
        StatelessSession session = sessionFactory.openStatelessSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            command.execute(session);
            transaction.commit();
        } catch (Exception e) {
            log.error("Exception while update statistics: " + e.getMessage());
            StringUtil.logStackTrace(e, log);
            if (transaction != null) {
                transaction.rollback();
            }
        } finally {
            session.close();
        }
    }

    /**
     * Interface to wrap the transaction code.
     * 
     * @author zyeming
     */
    private interface Command {
        void execute(StatelessSession session);
    }

}
