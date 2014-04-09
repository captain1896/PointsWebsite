package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

/**for template Activity Stat
 * stat Accept number,reject number,normal finish
 * @author james.chen
 * @since 2012-7-23
 */
public class PointsActivityStat implements Serializable {
    
    private static final long serialVersionUID = 5409597881914049054L;

    private int activityId;
    
    private int accept;
    
    private int reject;
    
    private int finish;
    
    public PointsActivityStat() {
    }
    
    public PointsActivityStat(int activityId, int accept, int reject, int finish) {
        this.activityId = activityId;
        this.accept = accept;
        this.reject = reject;
        this.finish = finish;
    }

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public int getAccept() {
        return accept;
    }

    public void setAccept(int accept) {
        this.accept = accept;
    }

    public int getReject() {
        return reject;
    }

    public void setReject(int reject) {
        this.reject = reject;
    }

    public int getFinish() {
        return finish;
    }

    public void setFinish(int finish) {
        this.finish = finish;
    }
    
    

}
