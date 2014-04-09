package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

/**
 * Account info
 * 
 * @author martin
 *
 */
public class Account implements Serializable {

    private static final long serialVersionUID = -1218576363459660990L;

    private int publisherId;
    private int currentPoints;
    private int totalCharge;
    private int totalUsed;
    private int availablePoints;

    public Account() {
        super();
    }

    public Account(int publisherId) {
        super();
        this.publisherId = publisherId;
        this.currentPoints = 0;
        this.totalCharge = 0;
        this.totalUsed = 0;
        this.availablePoints = 0;
    }

    public Account(int publisherId, int currentPoints, int totalCharge, int totalUsed, int availablePoints) {
        super();
        this.publisherId = publisherId;
        this.currentPoints = currentPoints;
        this.totalCharge = totalCharge;
        this.totalUsed = totalUsed;
        this.availablePoints = availablePoints;
    }

    public int getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(int publisherId) {
        this.publisherId = publisherId;
    }

    public int getCurrentPoints() {
        return currentPoints;
    }

    public void setCurrentPoints(int currentPoints) {
        this.currentPoints = currentPoints;
    }

    public int getTotalCharge() {
        return totalCharge;
    }

    public void setTotalCharge(int totalCharge) {
        this.totalCharge = totalCharge;
    }

    public int getTotalUsed() {
        return totalUsed;
    }

    public void setTotalUsed(int totalUsed) {
        this.totalUsed = totalUsed;
    }

    public int getAvailablePoints() {
        return availablePoints;
    }

    public void setAvailablePoints(int availablePoints) {
        this.availablePoints = availablePoints;
    }

}
