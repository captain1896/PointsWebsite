package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

import com.buzzinate.bshare.core.bean.enums.PointsType;
import com.buzzinate.bshare.points.Points.PointsParams;

/**
 * @author Martin
 */
public class PointDetailParam implements Serializable {

    private static final long serialVersionUID = -6193226349887856550L;

    private int userId;
    private PointsType type;
    private String site;
    private String uuid;
    private String url;
    
    private int platformId;
    private long burlId;
    private int userIp;
    private String vId;
    private int shareId;

    public PointDetailParam() {
        super();
    }

    public PointDetailParam(int userId, PointsType type, String site, String uuid, String url) {
        super();
        this.userId = userId;
        this.type = type;
        this.site = site;
        this.uuid = uuid;
        this.url = url;
    }
    
    public PointDetailParam(PointsParams pointsParam) {
        this.userId = pointsParam.getUserId();
        this.userIp = pointsParam.getUserIp();
        this.burlId = pointsParam.getBurlId();
        this.site = pointsParam.getSite();
        this.type = PointsType.valueOf(pointsParam.getType().getNumber());
        this.uuid = pointsParam.getUuid();
        this.url = pointsParam.getUrl();
        this.vId = pointsParam.getVId();
        this.shareId = pointsParam.getShareUserId();
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public PointsType getType() {
        return type;
    }

    public void setType(PointsType type) {
        this.type = type;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
    
    public String getSite() {
        return site;
    }
    
    public void setSite(String site) {
        this.site = site;
    }

    @Override
    public String toString() {
        return "uuid=" + uuid + ", userId=" + userId + ", platform=" + site + "url=" + url + ", pointType=" + 
                type.getValue() + "";
    }

    public int getPlatformId() {
        return platformId;
    }

    public void setPlatformId(int platformId) {
        this.platformId = platformId;
    }

    public long getBurlId() {
        return burlId;
    }

    public void setBurlId(long burlId) {
        this.burlId = burlId;
    }

    public int getUserIp() {
        return userIp;
    }

    public void setUserIp(int userIp) {
        this.userIp = userIp;
    }

    public String getvId() {
        return vId;
    }

    public void setvId(String vId) {
        this.vId = vId;
    }

    public int getShareId() {
        return shareId;
    }

    public void setShareId(int shareId) {
        this.shareId = shareId;
    }
}
