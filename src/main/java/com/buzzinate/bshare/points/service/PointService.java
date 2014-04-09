package com.buzzinate.bshare.points.service;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.core.bean.Platform;
import com.buzzinate.bshare.core.cache.PlatformCache;
import com.buzzinate.bshare.platform.util.PlatformId;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ActivityDailyStatistic;
import com.buzzinate.bshare.points.bean.ActivityUserTrack;
import com.buzzinate.bshare.points.bean.Order;
import com.buzzinate.bshare.points.bean.PointDetailParam;
import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.PointsUser;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.bshare.points.dao.ActivityUserTrackDao;
import com.buzzinate.bshare.points.processor.PointsStatisticProcessor;
import com.buzzinate.common.util.string.StringUtil;

/**
 * 积分系统Service
 * 
 * @author Martin
 */
@Service
public class PointService {

    private static Log log = LogFactory.getLog(PointService.class);

    @Autowired
    private ActivityService activityService;
    @Autowired
    private PlatformCache platformCache;
    @Autowired
    private PointsStatisticProcessor pointsStatisticProcessor;
    @Autowired
    private PointsProcessor pointsProcessor;
    @Autowired
    private PointsUserService pointsUserService;
    @Autowired
    private PointRecordService pointRecordService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserPointsPoolService userPointsPoolService;
    @Autowired
    private ActivityUserTrackDao userTrackDao;
    @Autowired
    private ActivityRuleService ruleService;

    /**
     * 根据分享或回流情况，计算积分
     * 
     * @param PointDetailParam
     * @return
     */
    public int process(PointDetailParam pointDetailParam) {
        Activity activity = processPrecondition(pointDetailParam);
        if (activity != null && activity.getId() > 0) {
            // 异步处理获取积分逻辑
            return processPoints(pointDetailParam, activity);
        }
        return 0;
    }
    //process Olympic
    public void processOlympic(String uuid , boolean isStart) {
        activityService.processOlympicActivity(uuid, isStart);
    }

    private Activity processPrecondition(PointDetailParam pointDetailParam) {
        Platform platform = platformCache.getPlatformByName(pointDetailParam.getSite());
        if (platform == null) {
            log.error("ProcessPreconditon no site found site=" + pointDetailParam.getSite());
            return null;
        }
        int platformId = platform.getPlatformID();
        // if platform no points
        if (!PlatformId.isSupportPoints(platformId)) {
            return null;
        }
        pointDetailParam.setPlatformId(platformId);
        Activity currentActivity = activityService.getCurrentActivity(pointDetailParam.getUuid());

        // if activity not exists return
        if (currentActivity == null || currentActivity.getId() == 0) {
            return null;
        }
        //record stat Track info
        ActivityUserTrack userTrack = new ActivityUserTrack(pointDetailParam);
        userTrack.setActivityId(currentActivity.getId());
        userTrackDao.saveOrUpdate(userTrack);
        
        // stat Activity data
        ActivityDailyStatistic activityDaily = new ActivityDailyStatistic(currentActivity.getId(),
                pointDetailParam.getPlatformId(), pointDetailParam.getType().convertToStatisticType(), 
                currentActivity.getUuid());
        pointsStatisticProcessor.addStats(activityDaily);
        
        return currentActivity;
    }
    
    
    public int processPoints(PointDetailParam pointDetailParam, Activity activity) {
        try {
            //reload Activity again.
            Activity a = activityService.getActivityById(activity.getId());
            if (a == null || a.getId() <= 0 || !a.isStart()) {
                return 0;
            }
            //no share Id return .
            if (pointDetailParam.getShareId() == 0) {
                log.error("no share Id" + pointDetailParam + ",activityId=" + activity.getId());
                return 0;
            }
            //if didn't pass the check rule return 0 points;
            if (!ruleService.passLimitRule(activity, pointDetailParam)) {
                return 0;
            }
            //generate share count
            userPointsPoolService.incrCounter(pointDetailParam.getShareId(), a.getId(), 
                    PointsRuleType.SHARE.getCode(), 0);
            // calc points
            int points = ruleService.getPoints(pointDetailParam, activity);
            if (points <= 0) {
                return 0;
            }
            //store result.
            points = pointsProcessor.doAddPointsForUser(pointDetailParam, activity, points);
            
            PointRule pointRule = activity.getPointRule(PointsRuleType.valueOf(pointDetailParam.getType()));
            if (pointRule.isProductRule()) {
                Order order = new Order();
                order.setProductId(pointRule.getProductId());
                order.setProdNum(pointRule.getNum());
                order.setUserId(pointDetailParam.getShareId());
                orderService.orderActivityInternal(order);
            }
            //reload activity
            a = activityService.getActivityById(activity.getId());
            if (a != null && a.isNeedFinish()) {
                log.info("actvity id=" + a.getId() + ",current left points=" + a.getLeftPoints());
                activityService.processFinishActivity(a);
            }
            return points;
        } catch (Exception e) {
            log.error("process points fail, PointDetailParam = " + pointDetailParam + ", error message :" + 
                            e.getMessage());
            StringUtil.logStackTrace(e, log);
            return 0;
        }
    }
    
    public void processUuidActivity(byte[] uuid) {
        activityService.getUuidActivity(uuid);
    }
    
    @Transactional(value = "points", readOnly = false)
    public void processMergePoints(int sourceId, int targetId) {
        
        PointsUser targetUser = pointsUserService.getUserPointsFromDb(targetId);
        PointsUser sourceUser = pointsUserService.getUserPointsFromDb(sourceId);
        if (sourceUser != null) {
            if (targetUser != null) {
                pointsUserService.mergePoints(sourceId, targetId);
                if (StringUtils.isNotEmpty(sourceUser.getContactName()) && 
                        StringUtils.isEmpty(targetUser.getContactName())) {
                    targetUser.setCity(sourceUser.getCity());
                    targetUser.setContactAddress(sourceUser.getContactAddress());
                    targetUser.setContactName(sourceUser.getContactName());
                    targetUser.setContactNo(sourceUser.getContactNo());
                    targetUser.setState(sourceUser.getState());
                    targetUser.setZipCode(sourceUser.getZipCode());
                    pointsUserService.updatePointUserContact(targetUser);
                }
            } else {
                pointsUserService.updatePointUser(sourceId, targetId);
            }
            pointRecordService.updateUserId(sourceId, targetId);
            orderService.updateUserId(sourceId, targetId);
        }
    }

}