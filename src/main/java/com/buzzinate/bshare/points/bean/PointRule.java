package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

import com.buzzinate.bshare.points.bean.enums.PointsRuleType;

/**
 * Activity point rule info
 * 
 * @author martin
 *
 */
public class PointRule implements Serializable {

    private static final long serialVersionUID = 6283250886391075477L;

    private int id;
    private int activityId;
    private PointsRuleType pointsRuleType;
    // 定义多少次分享或回流，获取的积分或商品
    private int num = 1;
    private int points;
    
    // 兑换的商品ID和数量
    private int productId;
    private int productNum = 1;
    
    // 临时用来界面用
    private int limitPoints;
    
    
    public PointRule() { }
    
    public PointRule(PointsRuleType pointsRuleType, int points) {
        super();
        this.pointsRuleType = pointsRuleType;
        this.points = points;
    }

    public PointRule(PointsRuleType pointsRuleType, int num, int points) {
        super();
        this.pointsRuleType = pointsRuleType;
        this.num = num;
        this.points = points;
    }

    public PointRule(int activityId, PointsRuleType pointsRuleType, int num, int points) {
        super();
        this.activityId = activityId;
        this.pointsRuleType = pointsRuleType;
        this.num = num;
        this.points = points;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public PointsRuleType getPointsRuleType() {
        return pointsRuleType;
    }

    public void setPointsRuleType(PointsRuleType pointsRuleType) {
        this.pointsRuleType = pointsRuleType;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getLimitPoints() {
        return limitPoints;
    }

    public void setLimitPoints(int limitPoints) {
        this.limitPoints = limitPoints;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    /**
     * 是否为商品兑换规则
     * @return
     */
    public boolean isProductRule() {
        return productId > 0;
    }
    
    public boolean isShareRule() {
        return this.pointsRuleType == PointsRuleType.SHARE;
    }
    
    public boolean isClickBackRule() {
        return this.pointsRuleType == PointsRuleType.CLICKBACK;
    }

    public int getProductNum() {
        return productNum;
    }

    public void setProductNum(int productNum) {
        this.productNum = productNum;
    }

    @Override
    public String toString() {
        return "PointRule [id=" + id + ", activityId=" + activityId + ", pointsRuleType=" + pointsRuleType + ", num="
                + num + ", points=" + points + ", productId=" + productId + ", productNum=" + productNum + "]";
    }
    
}
