package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.Date;

import com.buzzinate.common.util.DateTimeUtil;
import com.buzzinate.common.util.string.UrlUtil;

/**
 * the cooperator object
 * who supply the good to bshare for user to exchange
 * @author james.chen
 * @since 2012-6-4
 */
public class Merchant implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 3834474319865191543L;
    
    //Cooperator id
    private int id;
    //Cooperator name
    private String name;
    //Cooperator home site
    private String homeURL;
    //cooperator join time
    private Date joinTime;
    //related user id
    private int userId;
    //related email
    private String email;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHomeURLPrefix() {
        return UrlUtil.getFullUrlWithPrefix(homeURL);
    }

    public String getHomeURL() {
        return homeURL;
    }

    public void setHomeURL(String homeURL) {
        this.homeURL = homeURL;
    }

    public Date getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(Date joinTime) {
        this.joinTime = joinTime;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getJoinTimeString() {
        return DateTimeUtil.formatDate(joinTime, DateTimeUtil.FMT_DATE_YYYY_MM_DD_HH_MM);
    }
    
}
