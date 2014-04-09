package com.buzzinate.bshare.points.service;

import java.io.Serializable;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.PointsUser;
import com.buzzinate.bshare.points.dao.PointsUserDao;
import com.buzzinate.bshare.points.util.CacheConstants;
import com.buzzinate.common.memcached.MemcachedClientAdapter;

/**
 * pointsUser service get some record for Points User
 * @author james.chen
 * @since 2012-6-12
 */
@Service
public class PointsUserService implements Serializable {
    
    
    private static final long serialVersionUID = -5158646007611881834L;
    
    private static Log log = LogFactory.getLog(PointsUserService.class);
    
    @Autowired
    private PointsUserDao pointsUserDao;
    @Autowired
    private MemcachedClientAdapter memcachedClient;
    
    /**
     * 此方法永远不会返回null，小心被坑
     * 
     * @param userId
     * @return
     */
    public PointsUser getPointsByUserId(int userId) {
        String key = CacheConstants.USER_NAME + userId;
        PointsUser pu = (PointsUser) memcachedClient.get(key);
        if (pu == null) {
            pu = pointsUserDao.getPointsByUserId(userId);
            memcachedClient.set(key, CacheConstants.EXPIRE_USER_NAME, pu);
        }
        return pu;
    }
    
    public PointsUser getUserPointsFromDb(int userId) {
        return pointsUserDao.getUserPoints(userId);
    }
    
    //update Points User Order
    public void updatePointUser(PointsUser pointsUser , int points) {
        boolean result = pointsUserDao.updatePointUserOrder(pointsUser, points);
        // update the information
        if (result) {
            memcachedClient.delete(CacheConstants.USER_NAME + pointsUser.getUserId());
        } else {
            log.error(new StringBuilder("update PointUser issue,userId=").
                    append(pointsUser.getUserId()).append(",points").append(points).toString());
            throw new RuntimeException();
        }
    }
    
    //update Points User contact
    public void updatePointUserContact(PointsUser pointsUser) {
        //if contact invalid no need to update
        if (pointsUser == null || pointsUser.invalidContact()) {
            return;
        }
        boolean result = pointsUserDao.updatePointUserContact(pointsUser);
        // update the information
        if (result) {
            memcachedClient.delete(CacheConstants.USER_NAME + pointsUser.getUserId());
        } else {
            log.error("Update points user contact error. " + pointsUser.toString());
            throw new RuntimeException();
        }
    }
    //add points
    public boolean addPoints(int particpantId , int points) {
        boolean success = pointsUserDao.addPoints(particpantId, points);
        if (success) {
            memcachedClient.delete(CacheConstants.USER_NAME + particpantId);
        } else {
            log.error("Add points to user error. User id=" + particpantId);
            throw new RuntimeException();
        }
        return success;
    }
    
    public int getUserPointsByActivity(int userId, int activityId) {
        return pointsUserDao.getUserPointsByActivity(userId, activityId);
    }
    public void updatePointUser(int sourceId, int targetId) {
        pointsUserDao.updatePointUser(sourceId, targetId);
    }
    public void mergePoints(int sourceId, int targetId) {
        PointsUser pu = pointsUserDao.getPointsByUserId(sourceId);
        if (pu != null) {
            pointsUserDao.mergePoints(targetId, pu.getPoints());
            pointsUserDao.delete(sourceId);
        }
        memcachedClient.delete(CacheConstants.USER_NAME + sourceId);
        memcachedClient.delete(CacheConstants.USER_NAME + targetId);
    }
}
