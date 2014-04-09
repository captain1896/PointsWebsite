package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.Date;

import com.buzzinate.bshare.points.bean.enums.OrderStatus;

/**
 * the object java to store user and buy product related info
 * @author james.chen
 * @since 2012-6-4
 */
public class Order implements Serializable {
    
    /**
     * 
     */
    private static final long serialVersionUID = -5139188959632530122L;
    //order sequence id
    private int id;
    //order no
    private String orderNo;
    //related product id
    private int productId;
    //order user id
    private int userId;
    //contact name
    private String contactName;
    //contact address
    private String contactAddress;
    //contact telephone number/cell phone
    private String contactNo;
    //contact zip code
    private String zipCode;
    //order cost points
    private int orderPoints;
    //order product number
    private int prodNum;
    //order time
    private Date orderTime;
    //pointsProduct
    private PointsProduct product;
    //order status
    private OrderStatus orderStatus;
    
    //other info
    //this field store other info,
    //e.g if points Order store points account name
    //dummy order store dummy number.
    private String otherInfo;
    //outPointsTradNo
    //this field use to handle points exchange 
    //store tradno from third party who exchange points with bshare.
    private String outPointsTradNo;
    
    
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }
    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
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
    public int getOrderPoints() {
        return orderPoints;
    }
    public void setOrderPoints(int orderPoints) {
        this.orderPoints = orderPoints;
    }
    public int getProdNum() {
        return prodNum;
    }
    public void setProdNum(int prodNum) {
        this.prodNum = prodNum;
    }
    public Date getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }
    public PointsProduct getProduct() {
        return product;
    }
    public void setProduct(PointsProduct product) {
        this.product = product;
    }
    
    public String getOtherInfo() {
        return otherInfo;
    }
    public void setOtherInfo(String otherInfo) {
        this.otherInfo = otherInfo;
    }
    public OrderStatus getOrderStatus() {
        return orderStatus;
    }
    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }
    public String getOutPointsTradNo() {
        return outPointsTradNo;
    }
    public void setOutPointsTradNo(String outPointsTradNo) {
        this.outPointsTradNo = outPointsTradNo;
    }
    public void setAddress(PointsUser pointUser) {
        setContactName(pointUser.getContactName());
        setContactNo(pointUser.getContactNo());
        setZipCode(pointUser.getZipCode());
        setContactAddress(new StringBuilder(pointUser.getState()).append(pointUser.getCity())
                .append(pointUser.getContactAddress()).toString());
    }
}
