package com.buzzinate.bshare.points.cache;

import static com.buzzinate.common.util.DateTimeUtil.formatDate;
import static com.buzzinate.common.util.DateTimeUtil.getCurrentDateDay;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.bshare.points.service.PointRecordService;
import com.buzzinate.bshare.points.util.CacheConstants;
import com.buzzinate.common.memcached.MemcachedClientAdapter;
import com.buzzinate.common.util.DateTimeUtil;

/**
 * 积分系统的Cache
 * 
 * @author magic
 * 
 */
@Component
public class PointCache {

    @Autowired
    private MemcachedClientAdapter memcachedClient;
    @Autowired
    private PointRecordService pointRecordService;

    /**
     * 获取目前当天的总得分
     * 
     * @param userId
     * @param activity
     * @param limitPointRule
     * @return
     */
    public long getTodayTotalPoints(int userId, Activity activity, PointsRuleType pointsRuleType) {
        String key = getTodayTotalPointsKey(userId, activity, pointsRuleType);
        long totalPoints = memcachedClient.getCounter(key);
        if (totalPoints < 0) {
            totalPoints = pointRecordService.getTotalPointsFromActivityToday(userId, activity.getId());
            memcachedClient.setCounter(key, CacheConstants.getTillTomorrowExpireTime(), totalPoints);
        }
        return totalPoints;
    }
    
    /**
     * 增加当天的总得分
     * @param userId
     * @param activity
     * @param pointsRuleType
     * @param points
     * @return
     */
    public long incrTodayTotalPoints(int userId, Activity activity, PointsRuleType pointsRuleType, int points) {
        String key = getTodayTotalPointsKey(userId, activity, pointsRuleType);
        
        long counter = memcachedClient.getCounter(key);
        if (counter > 0) {
            return memcachedClient.incrCounter(key, points);
        } else {
            memcachedClient.setCounter(key, CacheConstants.getTillTomorrowExpireTime(), points);
            return points;
        }
    }

    /**
     * 获取未计分的分享次数
     * @param userId
     * @param activity
     * @param pointsRuleType
     * @param num
     * @return
     */
    public long getCounterOfNotCalcPoints(int userId, Activity activity, PointsRuleType pointsRuleType) {
        String key = getCounterOfNotCalcPointsKey(userId, activity, pointsRuleType);
        return memcachedClient.getCounter(key);
    }
    
    /**
     * 增加并获取未计分的分享次数
     * @param userId
     * @param activity
     * @param pointsRuleType
     * @param num
     * @return
     */
    public long incrCounterOfNotCalcPoints(int userId, Activity activity, PointsRuleType pointsRuleType, int num) {
        String key = getCounterOfNotCalcPointsKey(userId, activity, pointsRuleType);
        
        long counter = memcachedClient.getCounter(key);
        if (counter > 0) {
            return memcachedClient.incrCounter(key, num);
        } else {
            memcachedClient.setCounter(key, CacheConstants.getTillTomorrowExpireTime(), num);
            return num;
        }
    }
    
    /**
     * 减少未计分的分享次数
     * @param userId
     * @param activity
     * @param pointsRuleType
     * @param num
     * @return
     */
    public long decrCounterOfNotCalcPoints(int userId, Activity activity, PointsRuleType pointsRuleType, int num) {
        String key = getCounterOfNotCalcPointsKey(userId, activity, pointsRuleType);
        return memcachedClient.decrCounter(key, num);
    }

    /**
     * 目前当天的总得分 cache key
     * @param userId
     * @param activity
     * @param pointsRuleType
     * @return
     */
    private String getTodayTotalPointsKey(int userId, Activity activity, PointsRuleType pointsRuleType) {
        // key: activityId + userId + pointsRuleType + today
        return CacheConstants.TOAOL_POINTS_PREFIX + activity.getId() + ":" + userId + ":" + pointsRuleType + 
                formatDate(getCurrentDateDay());
    }

    /**
     * 未计分的分享次数 key
     * @param userId
     * @param activity
     * @param pointsRuleType
     * @return
     */
    private String getCounterOfNotCalcPointsKey(int userId, Activity activity, PointsRuleType pointsRuleType) {
        // key: activityId + userId + pointsRuleType + today
        return CacheConstants.SHARE_NUM_OF_CALC_POINTS_PREFIX + activity.getId() + ":" + userId + ":" + 
                pointsRuleType + formatDate(getCurrentDateDay());
    }
    
    /**
     * just for test
     */
    public boolean deleteTodayTotalPointsCache(int userId, Activity activity, PointsRuleType pointsRuleType) {
        String key = getTodayTotalPointsKey(userId, activity, pointsRuleType);
        return memcachedClient.delete(key);
    }
    
    /**
     * just for test
     */
    public boolean deleteCounterOfNotCalcPointsCache(int userId, Activity activity, PointsRuleType pointsRuleType) {
        String key = getCounterOfNotCalcPointsKey(userId, activity, pointsRuleType);
        return memcachedClient.delete(key);
    }

}
