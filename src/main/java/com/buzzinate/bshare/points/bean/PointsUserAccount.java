package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.Date;

import com.buzzinate.bshare.points.bean.enums.PointsCategory;
import com.buzzinate.common.bean.Entity;

/**
 * pointsUser Account Table,Store the user's account under kind of points
 * @author james.chen
 * @since 2012-7-3
 */
public class PointsUserAccount implements Entity<Integer>, Serializable {

    private static final long serialVersionUID = -5575496389909566349L;
    //primary key
    private int id;
    //user id
    private int userId;
    //pointsType
    private PointsCategory pointsCate;
    //related account name
    private String accountName;
    // 帐号更新时间
    private Date updateTime = new Date();
    
    public PointsUserAccount() {
    }
    
    public PointsUserAccount(int userId, PointsCategory cate, String accountName) {
        this.userId = userId;
        this.pointsCate = cate;
        this.accountName = accountName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public PointsCategory getPointsCate() {
        return pointsCate;
    }

    public void setPointsCate(PointsCategory pointsCate) {
        this.pointsCate = pointsCate;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }
    
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "PointsUserAccount [id=" + id + ", userId=" + userId + ", pointsCate=" + pointsCate + ", accountName=" +
                accountName + ", updateTime=" + updateTime + "]";
    }

}
