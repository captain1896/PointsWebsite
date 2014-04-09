package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.Date;

import com.buzzinate.bshare.points.bean.enums.AccountRecordType;
import com.buzzinate.common.util.DateTimeUtil;

/**
 * Account record info
 * 
 * @author martin
 *
 */
public class AccountRecord implements Serializable {

    private static final long serialVersionUID = -7792680715706018186L;

    private int id;
    private int publisherId;
    private int activityId;
    private int points;
    private Date time;
    private String dateTime;
    private AccountRecordType type;
    private String description;

    public AccountRecord() {
        super();
    }

    public AccountRecord(int publisherId, int points, AccountRecordType type, String description) {
        super();
        this.publisherId = publisherId;
        this.points = points;
        this.time = new Date();
        this.type = type;
        this.description = description;
    }
    
    public AccountRecord(int publisherId, int activityId, int points, AccountRecordType type) {
        super();
        this.publisherId = publisherId;
        this.activityId = activityId;
        this.points = points;
        this.time = new Date();
        this.type = type;
    }

    public AccountRecord(int publisherId, int activityId, int points, AccountRecordType type,
            String description) {
        super();
        this.publisherId = publisherId;
        this.activityId = activityId;
        this.points = points;
        this.time = new Date();
        this.type = type;
        this.description = description;
    }
    
    public AccountRecord(int id, int publisherId, int activityId, int points, Date time, AccountRecordType type,
            String description) {
        super();
        this.id = id;
        this.publisherId = publisherId;
        this.activityId = activityId;
        this.points = points;
        this.time = time;
        this.type = type;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public AccountRecordType getType() {
        return type;
    }

    public void setType(AccountRecordType type) {
        this.type = type;
    }

    public int getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(int publisherId) {
        this.publisherId = publisherId;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDateTime() {
        return DateTimeUtil.formatDate(time, DateTimeUtil.FMT_DATE_YYYY_MM_DD_HH_MM);
    }
    
}
