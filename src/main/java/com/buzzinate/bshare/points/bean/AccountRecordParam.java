package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.Date;

import com.buzzinate.bshare.points.bean.enums.AccountRecordType;

/**
 * 查询账户记录的参数
 * 
 * @author magic
 *
 */
public class AccountRecordParam implements Serializable {
    
    private static final long serialVersionUID = -192673341715500447L;
    
    private Date startDate;
    private Date endDate;
    private int userId;
    private AccountRecordType accountRecordType;
    
    public AccountRecordParam() {
        super();
    }
    
    public AccountRecordParam(Date startDate, Date endDate, int userId, AccountRecordType accountRecordType) {
        super();
        this.startDate = startDate;
        this.endDate = endDate;
        this.userId = userId;
        this.accountRecordType = accountRecordType;
    }
    public Date getStartDate() {
        return startDate;
    }
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    public Date getEndDate() {
        return endDate;
    }
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public AccountRecordType getAccountRecordType() {
        return accountRecordType;
    }
    public void setAccountRecordType(AccountRecordType accountRecordType) {
        this.accountRecordType = accountRecordType;
    }

}
