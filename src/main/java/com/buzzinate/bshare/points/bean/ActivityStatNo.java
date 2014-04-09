package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateUtils;

import com.buzzinate.bshare.points.bean.enums.ActivityStatType;

/**
 * @author james.chen
 * @since 2012-8-24
 */
public class ActivityStatNo implements Serializable {

    private static final long serialVersionUID = 5580731287458950359L;

    private int id;
    
    private int activityId;
    
    private ActivityStatType statType;
    
    private int recordId;
    
    private Date currentDate;
    
    private int totalNo;
    
    public ActivityStatNo() {
    }

    public ActivityStatNo(int activityId, int recordId, ActivityStatType statType, int totalNo) {
        this.activityId = activityId;
        this.statType = statType;
        this.totalNo = totalNo;
        this.recordId = recordId;
        this.currentDate = DateUtils.truncate(new Date(), Calendar.DATE);
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

    public ActivityStatType getStatType() {
        return statType;
    }

    public void setStatType(ActivityStatType statType) {
        this.statType = statType;
    }

    public int getRecordId() {
        return recordId;
    }

    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }

    public Date getCurrentDate() {
        return currentDate;
    }

    public void setCurrentDate(Date currentDate) {
        this.currentDate = currentDate;
    }

    public int getTotalNo() {
        return totalNo;
    }

    public void setTotalNo(int totalNo) {
        this.totalNo = totalNo;
    }

    @Override
    public String toString() {
        return "activityId=" + this.activityId + ",record_id=" + this.recordId + ",statType=" + this.statType +
                ",currentDate=" + this.currentDate + ",totalNo=" + this.totalNo;
    }
   
}
