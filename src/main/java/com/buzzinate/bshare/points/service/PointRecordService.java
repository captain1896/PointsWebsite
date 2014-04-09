package com.buzzinate.bshare.points.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.core.bean.enums.PointsType;
import com.buzzinate.bshare.points.bean.PointRecord;
import com.buzzinate.bshare.points.dao.PointRecordDao;
import com.buzzinate.common.util.DateTimeUtil;

/**
 * 
 * 用户获取的积分详情Service
 * 
 * @author magic
 *
 */
@Service
public class PointRecordService {

    @Autowired
    private PointRecordDao pointRecordDao;
    
    
    /**
     * 查看用户的获取积分记录
     * @param userId
     * @return
     */
    public List<PointRecord> getPointRecords(int userId) {
        return pointRecordDao.getPointRecords(userId);
    }

    /**
     * 查看活动分发的积分记录
     * @param activityId
     * @return
     */
    public List<PointRecord> getPointRecordsByActivityId(int activityId) {
        return pointRecordDao.getPointRecordsByActivityId(activityId);
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
        return pointRecordDao.getTotalPointsByPointsType(userId, activityId, pointsType);
    }
    
    public long create(PointRecord pointRecord) {
        return pointRecordDao.create(pointRecord);
    }

    public List<PointRecord> getActivityRecords(int userId) {
        return pointRecordDao.getActivityRecords(userId);
    }

    public PointRecord getPointRecord(int id) {
        return pointRecordDao.read(id);
    }
    
    public void update(PointRecord pr) {
        pointRecordDao.saveOrUpdate(pr);
    }

    public int getTotalPointsFromActivityToday(int userId, int activityId) {
        Date today = DateTimeUtil.getCurrentDateDay();
        return pointRecordDao.getTotalPointsFromActivityToday(userId, activityId, today);
    }

    public boolean updateUserId(int sourceId, int targetId) {
        return pointRecordDao.updateUserId(sourceId, targetId);
    }
    
}
