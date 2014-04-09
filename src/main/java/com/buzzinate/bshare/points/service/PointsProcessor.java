package com.buzzinate.bshare.points.service;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.PointDetailParam;
import com.buzzinate.bshare.points.bean.PointRecord;
import com.buzzinate.bshare.points.bean.enums.ActivityStatType;

/**
 * 
 * @author martin
 *
 */
@Service
public class PointsProcessor implements Serializable {
    
    private static final long serialVersionUID = 2904708649420293794L;
    
    //private static Log log = LogFactory.getLog(PointsProcessor.class);
    
    @Autowired
    private ActivityService activityService;
    @Autowired
    private PointsUserService pointsUserService;
    @Autowired
    private PointRecordService pointRecordService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private ActivityStatService statService;
    
    /**
     * 向用户账户充积分
     * @param PointDetailParam 
     * @param Activity
     * @param points
     * 
     * @return recordId
     */
    @Transactional(value = "points", readOnly = false)
    public int doAddPointsForUser(PointDetailParam pointDetailParam , Activity activity , int points) {
        // 扣除积分
        boolean successFlag = activityService.decrActivityPoints(activity.getId(), points);
        if (successFlag) {
            int userId = pointDetailParam.getShareId();
            // update stat total no
            statService.updateStatActivity(userId, ActivityStatType.get(pointDetailParam.getType().getCode()),
                    activity.getActivityLimitRule());
            // update points
            if (pointsUserService.addPoints(userId, points)) {
                PointRecord pointRecord =
                        new PointRecord(userId , activity.getId() , points , pointDetailParam.getType());
                pointRecordService.create(pointRecord);
                // update the total used in the account.
                accountService.usePoints(activity.getPublisherId(), points);
                return points;
            }
        }
        return 0;
    }

}
