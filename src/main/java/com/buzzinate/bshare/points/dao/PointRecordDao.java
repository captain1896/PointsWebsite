package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.core.bean.enums.PointsType;
import com.buzzinate.bshare.points.bean.PointRecord;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * Point use record Dao
 * 
 * @author martin
 *
 */
@Repository
@SuppressWarnings("unchecked")
@Transactional(value = "points", readOnly = true)
public class PointRecordDao extends PointsDaoBase<PointRecord, Integer> implements Serializable {
    
    private static final long serialVersionUID = 4036149181655255109L;
    public PointRecordDao() {
        super(PointRecord.class, "id");
    }
    
    public List<PointRecord> getPointRecords(int userId) {
        Query query = getSession().getNamedQuery("pointRecord.getRecords");
        query.setInteger("userId", userId);
        return (List<PointRecord>) query.list();
    }

    public List<PointRecord> getPointRecordsByActivityId(int activityId) {
        Query query = getSession().getNamedQuery("pointRecord.getPointRecordsByActivityId");
        query.setInteger("activityId", activityId);
        return (List<PointRecord>) query.list();
    }

    public List<PointRecord> getActivityRecords(int userId) {
        Query query = getSession().getNamedQuery("pointRecord.getActivityRecords");
        query.setInteger("userId", userId);
        return (List<PointRecord>) query.list();
    }

    /**
     * 获取用户在某一活动某类型（分享或回流）获得的总积分
     * 
     * @param userId
     * @param activityId
     * @param pointsType
     * @return
     */
    public int getTotalPointsByPointsType(int userId, int activityId, PointsType pointsType) {
        Query query = getSession().getNamedQuery("pointRecord.getTotalPointsFromActivity");
        query.setInteger("userId", userId);
        query.setInteger("activityId", activityId);
        query.setInteger("pointsType", pointsType.getCode());
        return (Integer) query.uniqueResult();
    }

    public int getTotalPointsFromActivityToday(int userId, int activityId, Date today) {
        Query query = getSession().getNamedQuery("pointRecord.getTotalPointsFromActivityToday");
        query.setInteger("userId", userId);
        query.setInteger("activityId", activityId);
        query.setDate("today", today);
        return (Integer) query.uniqueResult();
    }

    public boolean updateUserId(int sourceId, int targetId) {
        Query query = getSession().getNamedQuery("pointRecord.updateUserId");
        query.setInteger("sourceId", sourceId);
        query.setInteger("targetId", targetId);
        return query.executeUpdate() > 0;
    }
}
