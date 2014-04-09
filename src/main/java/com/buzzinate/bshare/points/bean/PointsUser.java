package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;

import com.buzzinate.bshare.points.util.ValidateUtil;


/**
 * points user, which store user information and points information
 * @author james.chen
 * @since 2012-6-12
 */
public class PointsUser implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = -6491813298087311983L;

    private int userId;
    
    private int points;
    
    private int status;
    
    private String contactName;
    
    private String contactAddress;
    
    private String contactNo;
    
    private String zipCode;
    
    private String state;
    
    private String city;
    
    private String userName;
    
    //default constructor 
    public PointsUser() {

    }
    //PointsUser
    public PointsUser(int userId) {
        this.userId = userId;
        this.points = 0;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactAddress() {
        return contactAddress;
    }

    public void setContactAddress(String contactAddress) {
        this.contactAddress = contactAddress;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }
    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public boolean isInValid(String content) {
        return StringUtils.isBlank(content) || !ValidateUtil.isValidContent(content);
    }
    
    /**if any of below field is blank ,we think it is invalid contact
     * @return
     */
    public boolean invalidContact() {
        return isInValid(state) || isInValid(contactName) || isInValid(contactAddress) || isInValid(contactNo) ||
                isInValid(zipCode);
    }
    
    public String toString() {
        try {
            return BeanUtils.describe(this).toString();
        } catch (Exception e) {
            return "UserId=" + userId;
        }
    }
}
