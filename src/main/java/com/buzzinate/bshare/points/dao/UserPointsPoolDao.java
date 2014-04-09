package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.common.dao.SimpleBaseDao;
import com.buzzinate.common.util.DateTimeUtil;

/**
 * User points pool Dao
 * 
 * @author martin
 *
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class UserPointsPoolDao extends SimpleBaseDao implements Serializable {
    
    private static final long serialVersionUID = -2750307033563669546L;
    
    private static Log log = LogFactory.getLog(UserPointsPoolDao.class);
    
    public int getCount(int userId, int activityId, int pointType) {
        Query query = getSession().getNamedQuery("userPointsPool.getCount");
        query.setInteger("userId", userId);
        query.setInteger("activityId", activityId);
        query.setInteger("pointType", pointType);
        List<Integer> list = query.list();
        if (list.size() > 0) {
            return list.get(0);
        }
        return 0;
    }
    
    public boolean isExistsCount(int activityId) {
        Query query = getSession().getNamedQuery("userPointsPool.isExitsByActivity");
        query.setInteger("activityId", activityId);
        return (Long) query.uniqueResult() > 0;
    }
    
    public int getCountByDate(int userId, int activityId, int pointType) {
        Query query = getSession().getNamedQuery("userPointsPool.getCountByDate");
        query.setInteger("userId", userId);
        query.setInteger("activityId", activityId);
        query.setInteger("pointType", pointType);
        query.setDate("dateDay", DateTimeUtil.getCurrentDateDay());
        List<Integer> list = query.list();
        if (list.size() > 0) {
            return list.get(0);
        }
        return 0;
    }

    @Transactional(value = "points", readOnly = false)
    public boolean incrCounter(int userId, int activityId, int pointType) {
        Query query = getSession().getNamedQuery("userPointsPool.incrCounter");
        query.setInteger("userId", userId);
        query.setInteger("activityId", activityId);
        query.setInteger("pointType", pointType);
        return query.executeUpdate() > 0;
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean incrCounter(int userId, int activityId, int pointType, int count) {
        Query query = getSession().getNamedQuery("userPointsPool.incrCounterPlusCount");
        query.setInteger("userId", userId);
        query.setInteger("activityId", activityId);
        query.setInteger("pointType", pointType);
        query.setInteger("count", count);
        return query.executeUpdate() > 0;
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean reIncrCounter(int userId, int activityId, int pointType, int num) {
        Query query = getSession().getNamedQuery("userPointsPool.reIncrCounter");
        query.setInteger("userId", userId);
        query.setInteger("activityId", activityId);
        query.setInteger("pointType", pointType);
        query.setInteger("num", num);
        return query.executeUpdate() > 0;
    }

    @Transactional(value = "points", readOnly = false)
    public boolean createIncrCounterByDate(int userId, int activityId, int pointType) {
        Query query = getSession().getNamedQuery("userPointsPool.createIncrCounterByDate");
        query.setInteger("userId", userId);
        query.setInteger("activityId", activityId);
        query.setInteger("pointType", pointType);
        query.setDate("dateDay", DateTimeUtil.getCurrentDateDay());
        return query.executeUpdate() > 0;
    }
    
    public List<Integer> getUserActivity(int userId) {
        Query query = getSession().getNamedQuery("userPointsPool.getUserActivity");
        query.setInteger("userId", userId);
        return (List<Integer>) query.list();
    }
}
