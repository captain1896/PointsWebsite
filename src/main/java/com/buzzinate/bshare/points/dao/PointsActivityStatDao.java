package com.buzzinate.bshare.points.dao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.PointsActivityStat;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * @author james.chen
 * @since 2012-7-23
 */
@Repository
@Transactional(value = "points", readOnly = true)
public class PointsActivityStatDao extends PointsDaoBase<PointsActivityStat, Integer> {
    
    private static Log log = LogFactory.getLog(PointsActivityStatDao.class);

    public PointsActivityStatDao() {
        super(PointsActivityStat.class , "activityId");
    }
    @Transactional(value = "points", readOnly = false)
    public boolean statActivity(PointsActivityStat activityStat) {
        if (activityStat.getActivityId() == 0) {
            return false;
        }
        Query query = getSession().getNamedQuery("PointsActivityStat.statNum");
        query.setInteger("activityId", activityStat.getActivityId());
        query.setInteger("accept", activityStat.getAccept());
        query.setInteger("reject", activityStat.getReject());
        query.setInteger("finish", activityStat.getFinish());
        int count = 0;
        try {
            count = query.executeUpdate();
        } catch (Exception e) {
            log.error("stat activity error,activityId=" + activityStat.getActivityId(), e);
        }
        return count > 0;
    }
}
