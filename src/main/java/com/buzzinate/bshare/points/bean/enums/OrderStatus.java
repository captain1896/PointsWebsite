package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * Order status 
 * @author james.chen
 * @since 2012-6-27
 */
public enum OrderStatus implements IntegerValuedEnum, Serializable {
    ALL(0), WAITING(1), DELIVERING(2), DELIVERD(3), COMPLETED(4), DELETED(5);

    private int code;
    
    private OrderStatus(int code) {
        this.code = code;
    }
    @Override
    public int getCode() {
        return this.code;
    }
    //get next OrderStatus
    public OrderStatus getNext() {
        if (DELETED.equals(this)) {
            return DELETED;
        }
        return OrderStatus.values()[this.ordinal() + 1];
    }
    //get OrderStatus by code
    public static OrderStatus getCurrent(int cCode) {
        switch (cCode) {
        case 1:
            return WAITING;
        case 2:
            return DELIVERING;
        case 3:
            return DELIVERD;
        case 4:
            return COMPLETED;
        case 5:
            return DELETED;
        case 0:
            return ALL;
        default:
            throw new RuntimeException("not support this code=" + cCode);
        }
    }
}
