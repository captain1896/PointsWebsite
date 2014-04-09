package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * 账户使用记录类型
 * 
 * 充值/消费/返还
 * 
 * @author Magic
 * 
 */
public enum AccountRecordType implements IntegerValuedEnum, Serializable {
    CHARGE(1), DEDUCT(2), RETURN(3); 

    private final int code;
    
    private AccountRecordType(int code) {
        this.code = code;
    }
    
    @Override
    public int getCode() {
        return code;
    }
    
    public String getDesc() {
        switch (this) {
        case CHARGE:
            return "充值";
        case DEDUCT:
            return "消费";
        case RETURN:
            return "返还";
        default:
            return "";
        }
    }
    
    public String toString() {
        return getDesc();
    }
}