package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.Date;

import com.buzzinate.bshare.points.bean.enums.TradeStatus;

/**
 * Alipay trade record info
 * 
 * @author martin
 *
 */
public class AlipayRecord implements Serializable {

    private static final long serialVersionUID = 6848368641726613868L;
    
    private static DecimalFormat format = new DecimalFormat("###,###,##0.00");
    
    private int id;
    private int recordId;
    private int points;
    private int amount;
    private int poundage;
    private String tradeNo;
    private TradeStatus tradeStatus;
    private Date createTime;
    private Date paymentTime;
    
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getRecordId() {
        return recordId;
    }
    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }
    public String getTradeNo() {
        return tradeNo;
    }
    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo;
    }
    public TradeStatus getTradeStatus() {
        return tradeStatus;
    }
    public void setTradeStatus(TradeStatus tradeStatus) {
        this.tradeStatus = tradeStatus;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Date getPaymentTime() {
        return paymentTime;
    }
    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }
    public int getAmount() {
        return amount;
    }
    public void setAmount(int amount) {
        this.amount = amount;
    }
    public int getPoints() {
        return points;
    }
    public void setPoints(int points) {
        this.points = points;
    }
    public String getAmountValue() {
        return format.format(amount / 100.0);
    }
    public int getPoundage() {
        return poundage;
    }
    public void setPoundage(int poundage) {
        this.poundage = poundage;
    }
    public String getPoundageValue() {
        return format.format(poundage / 100.0);
    }
}
