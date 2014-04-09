package com.buzzinate.bshare.points.action.special;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.service.ActivityService;
import com.opensymphony.xwork2.Action;

/**
 * Special Activity for Special Task  
 * @author james.chen
 * @since 2012-9-17
 */
@Controller
@Scope("request")
public class SpecialTaskAction extends BaseAction {

    private static final long serialVersionUID = -1115833986470871504L; 
    
    @Autowired
    private ActivityService activityService;
    
    private List<Activity> activities;
    
    public String activityRankV5() {
        List<Integer> ids = activityService.getSpecialActivityIds(1);
        if (ids.size() > 0) {
            Map<String, Object> param = new HashMap<String, Object>();
            param.put("ids_list", ids.toArray());
            activities = activityService.nameQuery("Activity.getActivityByIds", param);
        }
        return Action.SUCCESS;
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public void setActivities(List<Activity> activities) {
        this.activities = activities;
    }
    
}
