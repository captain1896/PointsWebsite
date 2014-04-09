package com.buzzinate.bshare.points.api;

import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.user.bean.User;
import com.buzzinate.bshare.user.service.LoginHelper;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.string.UrlUtil;

/**
 * 
 * Format:
 *         http://<HOST/CXT_PATH>/api/getActivity.json?&uuid=<uuid>
 * 
 * 
 * Returns:
 *         success or fail.
 * 
 * @author Martin
 *
 */
// PATH!!! remember to use an extension, or struts will filter it!
@Path("getActivity.json")
@Component
@XmlRootElement
@Scope("request")
public class ActivityResource {
    
    private static final String URL_BASE = ConfigurationReader.getString("bshare.points.server") + "/shop/activity/";
    
    @Autowired
    private ActivityService activityService;
    @Autowired
    private LoginHelper loginHelper;
    
    @DefaultValue("")
    @QueryParam("uuid")
    private String uuid;
    @DefaultValue("")
    @QueryParam("callback") 
    private String callback = "";
    @DefaultValue("")
    @QueryParam("url") 
    private String currentUrl = "";
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getMethod() {
        if (StringUtils.isNotEmpty(uuid)) {
            Activity currentActivity = activityService.getCurrentActivity(uuid);
            if (currentActivity != null && currentActivity.getId() > 0) {
                Activity activity = activityService.getActivityById(currentActivity.getId());
                if (activity != null && activity.getId() > 0 && activity.getLeftPoints() > 0 &&
                        UrlUtil.isIllegalDoamin(currentUrl, activity.getDomain())) {
                    User user = loginHelper.getUser();
                    boolean isConUser =
                            user != null && StringUtils.isEmpty(user.getEmail()) && user.getUserAccount() != null &&
                                    user.getUserAccount().size() > 0;
                    return getReturnJson(currentActivity, isConUser);
                }
            }

        }
        return callback + "({'result' : 'success'})";
    }

    private String getReturnJson(Activity activity, boolean isConUser) {
        String result = callback + "({'result' : 'success', 'activityId' : " + activity.getId() + 
                ", 'activityName' : '" + activity.getName() + "', 'activityLink' : '" + 
                URL_BASE + activity.getId() + "'";
                
        if (isConUser) {
            result += ", 'isConnectUser' : 'true'";
        }
        result += "})";
        return result;
    }

}