package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * Status type enum
 * 
 * @author martin
 *
 */
public enum StatusType implements IntegerValuedEnum, Serializable {
    
    INVALID(0), VALID(1); 

    private final int code;

    private StatusType(int code) {
        this.code = code;
    }

    @Override
    public int getCode() {
        return code;
    }

}
