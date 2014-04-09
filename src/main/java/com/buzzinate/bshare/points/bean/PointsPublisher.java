package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

/**
 * 积分合作站点
 * 
 * @author magic
 * 
 */
public class PointsPublisher implements Serializable {

    private static final long serialVersionUID = 7080091503723705066L;
    
    private String email;
    private String description;

    public PointsPublisher() {
        super();
    }

    public PointsPublisher(String email) {
        super();
        this.email = email;
    }
    
    public PointsPublisher(String email, String description) {
        super();
        this.email = email;
        this.description = description;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
