package com.buzzinate.bshare.points.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.dao.UserPointsPoolDao;

/**
 * User points pool Service
 * 
 * @author Martin
 * 
 */
@Service
public class UserPointsPoolService {

    private static Log log = LogFactory.getLog(UserPointsPoolService.class);

    @Autowired
    private UserPointsPoolDao userPointsPoolDao;
    
    public int getCount(int userId, int activityId, int pointType) {
        return userPointsPoolDao.getCount(userId, activityId, pointType);
    }
    
    public boolean isExistsCount(int activityId) {
        return userPointsPoolDao.isExistsCount(activityId);
    }
    
    public int getCountByDateDay(int userId, int activityId, int pointType) {
        return userPointsPoolDao.getCountByDate(userId, activityId, pointType);
    }

    public boolean incrCounter(int userId, int activityId, int pointType) {
        return userPointsPoolDao.incrCounter(userId, activityId, pointType);
    }

    public boolean incrCounter(int userId, int activityId, int pointType, int count) {
        return userPointsPoolDao.incrCounter(userId, activityId, pointType, count);
    }
    
    public boolean createIncrCounterByDate(int userId, int activityId, int pointType) {
        return userPointsPoolDao.createIncrCounterByDate(userId, activityId, pointType);
    }

    public boolean reIncrCounter(int userId, int activityId, int pointType, int num) {
        return userPointsPoolDao.reIncrCounter(userId, activityId, pointType, num);
    }
    
    public List<Integer> getUserActivity(int userId) {
        return userPointsPoolDao.getUserActivity(userId);
    }

}
