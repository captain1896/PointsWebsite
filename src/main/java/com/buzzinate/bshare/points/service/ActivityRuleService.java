package com.buzzinate.bshare.points.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ActivityLimitRule;
import com.buzzinate.bshare.points.bean.PointDetailParam;
import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.common.util.string.UrlUtil;


/**
 * @author james.chen
 * @since 2012-8-24
 */
@Service
public class ActivityRuleService {
    
    private static Log log = LogFactory.getLog(ActivityService.class);

    
    @Autowired
    private ActivityStatService statService;
    @Autowired
    private UserPointsPoolService userPointsPoolService;
    
    public boolean passLimitRule(Activity activity , PointDetailParam pp) {
        // check publisher is not the current user
        if (activity.getPublisherId() == pp.getShareId()) {
            return false;
        }
        // if there is no Points return
        if (activity.getLeftPoints() <= 0) {
            return false;
        }
        // check is Illegal domain
        if (!UrlUtil.isIllegalDoamin(pp.getUrl(), activity.getDomain())) {
            return false;
        }
        ActivityLimitRule limitRule = activity.getActivityLimitRule();
        // check user LimitNo
        int limitNo = limitRule.getLimitNo(pp.getType() == null ? 0 : pp.getType().getCode());
        if (limitNo > 0) {
            long currentUserNo = statService.getTypeTotalNo(activity.getId(), pp.getShareId(), pp.getType());
            if (currentUserNo >= limitNo) {
                log.info("userId=" + pp.getShareId() + ",process activity" + activity.getId() + "currentUserNo=" +
                        currentUserNo + "limitNo=" + limitNo);
                return false;
            }
        }
        return true;
    }
    
    /**get Points under Activity.
     * @param activity
     * @param pp
     * @return
     */
    public int getPoints(PointDetailParam pp , Activity activity) {
        PointRule pointRule = activity.getPointRule(PointsRuleType.valueOf(pp.getType()));
        int points = 0;
        if (pointRule == null) {
            return 0;
        }
        //if current no points will arrange to this rule, return 0.
        if (pointRule.getPoints() > activity.getLeftPoints()) {
            return 0;
        }
        if (pointRule.getNum() == 1) {
            points = pointRule.getPoints();
        } else {
            int userId = pp.getShareId();
            PointsRuleType pointType = pointRule.getPointsRuleType();
            userPointsPoolService.incrCounter(userId, activity.getId(), pointType.getCode());
            int count =
                    userPointsPoolService.getCount(userId, activity.getId(), pointRule.getPointsRuleType().getCode());
            if (count >= pointRule.getNum()) {
                boolean isGetPoints =
                        userPointsPoolService.reIncrCounter(userId, activity.getId(), pointType.getCode(),
                                pointRule.getNum());
                if (isGetPoints) {
                    points = pointRule.getPoints();
                }
            }
        }
        return points;
    }
}
