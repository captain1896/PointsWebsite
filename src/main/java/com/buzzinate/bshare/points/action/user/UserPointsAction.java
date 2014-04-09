package com.buzzinate.bshare.points.action.user;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.PointsUserService;
import com.buzzinate.bshare.user.service.LoginHelper;
import com.buzzinate.common.util.JsonResults;

/**
 * this get user points at a activity
 * @author martin
 */
@Controller
@Scope("request")
public class UserPointsAction extends BaseAction {

    private static final long serialVersionUID = 3425215739951286496L;
    @Autowired
    private LoginHelper loginHelper;
    @Autowired
    private ActivityService activityService;
    @Autowired
    private PointsUserService pointsUserService;
    
    private String uuid;
    
    private JsonResults jsonResults;
    
    @Override
    public String execute() throws Exception {
        jsonResults = new JsonResults();
        if (loginHelper.getUserID() > 0 && StringUtils.isNotEmpty(uuid)) {
            Activity currentActivity = activityService.getCurrentActivity(uuid);
            if (currentActivity != null) {
                int points = pointsUserService.getUserPointsByActivity(loginHelper.getUserID(), 
                        currentActivity.getId());
                jsonResults.addContent("activityId", currentActivity.getId());
                jsonResults.addContent("points", points);
                return jsonResults.success();
            }
        }
        return jsonResults.fail();
    }

    public String getUuid() {
        return uuid;
    }
    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
    public JsonResults getJsonResults() {
        return jsonResults;
    }
    public void setJsonResults(JsonResults jsonResults) {
        this.jsonResults = jsonResults;
    }
}
