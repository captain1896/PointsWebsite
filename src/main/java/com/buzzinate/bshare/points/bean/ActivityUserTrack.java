package com.buzzinate.bshare.points.bean;

import java.util.Date;

import com.buzzinate.bshare.core.bean.enums.PointsType;

/**
 * Activity User Track Info.
 * @author james.chen
 * @since 2012-8-23
 */
public class ActivityUserTrack {
    
    private int id;
    
    private int activityId;
    
    private int userId;
    
    private PointsType pointsType;
    
    private int userIP;
    
    private String url;
    
    private String vId;
    
    private long burlId;
    
    private int platformId;
    
    private Date insertTime;
    
    private int shareId;
    
    
    public ActivityUserTrack() {
    }

    public ActivityUserTrack(PointDetailParam pp) {
        this.userId = pp.getUserId();
        this.pointsType = pp.getType();
        this.userIP = pp.getUserIp();
        this.url = pp.getUrl();
        this.vId = pp.getvId();
        this.burlId = pp.getBurlId();
        this.platformId = pp.getPlatformId();
        this.shareId = pp.getShareId();
        this.insertTime = new Date();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public PointsType getPointsType() {
        return pointsType;
    }

    public void setPointsType(PointsType pointsType) {
        this.pointsType = pointsType;
    }

    public int getUserIP() {
        return userIP;
    }

    public void setUserIP(int userIP) {
        this.userIP = userIP;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getvId() {
        return vId;
    }

    public void setvId(String vId) {
        this.vId = vId;
    }

    public long getBurlId() {
        return burlId;
    }

    public void setBurlId(long burlId) {
        this.burlId = burlId;
    }

    public int getPlatformId() {
        return platformId;
    }

    public void setPlatformId(int platformId) {
        this.platformId = platformId;
    }

    public Date getInsertTime() {
        return insertTime;
    }

    public void setInsertTime(Date insertTime) {
        this.insertTime = insertTime;
    }

    public int getShareId() {
        return shareId;
    }

    public void setShareId(int shareId) {
        this.shareId = shareId;
    }
}
