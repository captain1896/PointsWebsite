package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.Date;

import com.buzzinate.bshare.core.bean.enums.PointsType;
import com.buzzinate.bshare.points.bean.enums.StatusType;
import com.buzzinate.common.util.DateTimeUtil;

/**
 * Acitvity point use record info
 * 
 * @author martin
 *
 */
public class PointRecord implements Serializable {

    private static final long serialVersionUID = 5038736881487578458L;

    private int id;
    private int participantId;
    private int activityId;
    private int points;
    private Date time;
    private PointsType pointsType;
    private StatusType statusType;
    private String activityName;

    public PointRecord() {
        super();
    }
    
    public PointRecord(int participantId, int activityId, long points) {
        super();
        this.participantId = participantId;
        this.activityId = activityId;
        this.points = (int) points;
        this.time = new Date();
        this.statusType = StatusType.VALID;
    }
    
    public PointRecord(int participantId, int activityId, long points, String activityName) {
        super();
        this.participantId = participantId;
        this.activityId = activityId;
        this.points = (int) points;
        this.time = new Date();
        this.activityName = activityName;
        this.statusType = StatusType.VALID;
    }

    public PointRecord(int participantId, int activityId, int points, PointsType pointsType) {
        super();
        this.participantId = participantId;
        this.activityId = activityId;
        this.points = points;
        this.time = new Date();
        this.pointsType = pointsType;
        this.statusType = StatusType.VALID;
    }

    public PointRecord(int participantId, int activityId, int points, Date time,
            PointsType pointsType, StatusType statusType) {
        super();
        this.participantId = participantId;
        this.activityId = activityId;
        this.points = points;
        this.time = time;
        this.pointsType = pointsType;
        this.statusType = statusType;
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

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public PointsType getPointsType() {
        return pointsType;
    }

    public void setPointsType(PointsType pointsType) {
        this.pointsType = pointsType;
    }

    public StatusType getStatusType() {
        return statusType;
    }

    public void setStatusType(StatusType statusType) {
        this.statusType = statusType;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public int getParticipantId() {
        return participantId;
    }

    public void setParticipantId(int participantId) {
        this.participantId = participantId;
    }

    public String getDateTime() {
        return DateTimeUtil.formatDate(time, DateTimeUtil.FMT_DATE_YYYY_MM_DD_HH_MM);
    }
    
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + activityId;
        result = prime * result + id;
        result = prime * result + participantId;
        result = prime * result + ((pointsType == null) ? 0 : pointsType.hashCode());
        result = prime * result + points;
        result = prime * result + ((statusType == null) ? 0 : statusType.hashCode());
        result = prime * result + ((time == null) ? 0 : time.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        PointRecord other = (PointRecord) obj;
        if (activityId != other.activityId)
            return false;
        if (id != other.id)
            return false;
        if (participantId != other.participantId)
            return false;
        if (pointsType != other.pointsType)
            return false;
        if (points != other.points)
            return false;
        if (statusType != other.statusType)
            return false;
        if (time == null) {
            if (other.time != null)
                return false;
        } else if (time.getTime() / 1000 != other.time.getTime() / 1000)
            return false;
        return true;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

}
