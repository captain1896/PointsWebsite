package com.buzzinate.bshare.points.action.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.PointRecord;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.PointRecordService;
import com.buzzinate.bshare.points.service.UserPointsPoolService;

/**
 * 
 * 获取活动积分详情列表
 * 
 * @author Martin
 *
 */
@Controller
@Scope("request")
public class ActivityRecordAction extends BaseAction {

    private static final long serialVersionUID = -4483886063764225745L;

    @Autowired
    private PointRecordService pointRecordService;
    @Autowired
    private ActivityService activityService;
    @Autowired
    private UserPointsPoolService userPointsPoolService;
    
    private List<PointRecord> activityRecords;
    
    private List<Activity> activities;
    
    public String execute() throws Exception {
        int userId = loginHelper.getUserId();
        
        List<Integer> ids = userPointsPoolService.getUserActivity(userId);
        Map<Integer, PointRecord> map = new HashMap<Integer, PointRecord>();
        activityRecords = pointRecordService.getActivityRecords(userId);
        for (PointRecord pr : activityRecords) {
            map.put(pr.getActivityId(), pr);
        }
        
        for (int activityId : ids) {
            if (map.get(activityId) == null) {

                Activity a = activityService.getActivityById(activityId);
                if (a != null) {
                    PointRecord pr = new PointRecord();
                    pr.setActivityId(activityId);
                    pr.setActivityName(a.getName());
                    activityRecords.add(pr);
                }

            }
        }
        
        activities = activityService.getFirstThreeActivitys();
        return SUCCESS;
    }

    public List<PointRecord> getActivityRecords() {
        return activityRecords;
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public void setActivities(List<Activity> activities) {
        this.activities = activities;
    }
    
}
