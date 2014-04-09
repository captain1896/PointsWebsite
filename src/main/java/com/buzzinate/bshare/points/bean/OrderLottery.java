package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

/**
 * generate order Relate Lottery No
 * @author james.chen
 * @since 2012-7-20
 */
public class OrderLottery implements Serializable {

    private static final long serialVersionUID = 350360998706869571L;
    // order id
    private int id;
    //orderId
    private int orderId;
    //productId
    private int productId;
    // lotterNo
    private String lotteryNo;
    //relate order info
    private Order order;
    
    public OrderLottery() {

    }

    public OrderLottery(Order order) {
        this.orderId = order.getId();
        this.productId = order.getProductId();
        this.lotteryNo = order.getOtherInfo();
    }
    
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getLotteryNo() {
        return lotteryNo;
    }
    public void setLotteryNo(String lotteryNo) {
        this.lotteryNo = lotteryNo;
    }
    public Order getOrder() {
        return order;
    }
    public void setOrder(Order order) {
        this.order = order;
    }
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }
}
