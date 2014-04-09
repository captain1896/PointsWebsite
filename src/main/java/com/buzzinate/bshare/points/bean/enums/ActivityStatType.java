package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * stat Activity info.
 * @author james.chen
 * @since 2012-8-24
 */
public enum ActivityStatType implements IntegerValuedEnum, Serializable {
    SHARE_D(1), CLICKBACK_D(2), USERTOTAL(3), IP_D(4);
    private int code;

    private ActivityStatType(int code) {
        this.code = code;
    }

    @Override
    public int getCode() {
        return code;
    }
    
    public static ActivityStatType get(int code) {
        switch (code) {
        case 1:
            return SHARE_D;
        case 2:
            return CLICKBACK_D;
        case 3:
            return USERTOTAL;
        case 4:
            return IP_D;
        default:
            throw new RuntimeException("ActivityStatType not support this code=" + code);
        }
    }
}
