package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

import com.buzzinate.bshare.core.bean.enums.PointsType;

/**
 *Activity Limit Rule
 * @author james.chen
 * @since 2012-8-23
 */
public class ActivityLimitRule implements Serializable {
    
    private static final long serialVersionUID = 8229592800571373061L;
    
    private int activityId;

    private String domain; 
    
    private int shareLimitNo;
    
    private int clickBackLimitNo;
    
    private int ipLimitNo;
    
    private int cookieLimitNo;
    
    private Activity activity;

    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public int getShareLimitNo() {
        return shareLimitNo;
    }

    public void setShareLimitNo(int shareLimitNo) {
        this.shareLimitNo = shareLimitNo;
    }

    public int getClickBackLimitNo() {
        return clickBackLimitNo;
    }

    public void setClickBackLimitNo(int clickBackLimitNo) {
        this.clickBackLimitNo = clickBackLimitNo;
    }

    public int getIpLimitNo() {
        return ipLimitNo;
    }

    public void setIpLimitNo(int ipLimitNo) {
        this.ipLimitNo = ipLimitNo;
    }

    public int getCookieLimitNo() {
        return cookieLimitNo;
    }

    public void setCookieLimitNo(int cookieLimitNo) {
        this.cookieLimitNo = cookieLimitNo;
    }
    
    public int getLimitNo(int code) {
        switch (code) {
        case 1:
            return shareLimitNo;
        case 2:
            return clickBackLimitNo;
        default:
            return 0;
        }
    }
    
    public int getLimitByPointsType(PointsType pointType) {
        if (PointsType.SHARE == pointType) {
            return shareLimitNo;
        } else if (PointsType.CLICKBACK == pointType) {
            return clickBackLimitNo;
        } else {
            return 0;
        }
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    @Override
    public String toString() {
        return "ActivityLimitRule [activityId=" + activityId + ", domain=" + domain + ", shareLimitNo=" + shareLimitNo +
                ", clickBackLimitNo=" + clickBackLimitNo + ", ipLimitNo=" + ipLimitNo + ", cookieLimitNo=" +
                cookieLimitNo + "]";
    }
    
}
