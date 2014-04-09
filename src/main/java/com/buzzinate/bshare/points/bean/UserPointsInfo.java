package com.buzzinate.bshare.points.bean;

import com.buzzinate.bshare.core.bean.enums.PointsType;

/**
 * 用户在某活动获取积分情况
 * 
 * @author magic
 *
 */
public class UserPointsInfo {

    private int userId;
    private int activityId;
    // 积分类型
    private PointsType pointsType;
    // 目前获得的总积分
    private int totalPoints;
    // 分享或回流规则定义的次数（每..次可获积分）
    private int pointRuleCount;
    // 分享或回流的次数
    private int count;
    
    public UserPointsInfo(int userId, int activityId, PointsType pointsType) {
        this.userId = userId;
        this.activityId = activityId;
        this.pointsType = pointsType;
    }
    
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public int getActivityId() {
        return activityId;
    }
    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }
    public PointsType getPointsType() {
        return pointsType;
    }

    public void setPointsType(PointsType pointsType) {
        this.pointsType = pointsType;
    }

    public int getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(int totalPoints) {
        this.totalPoints = totalPoints;
    }

    public int getPointRuleCount() {
        return pointRuleCount;
    }

    public void setPointRuleCount(int pointRuleCount) {
        this.pointRuleCount = pointRuleCount;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
    
    /**
     * 是否参与活动
     * @return
     */
    public boolean hasParticipateAcitivty() {
        return totalPoints > 0 || count > 0;
    }
    
}
