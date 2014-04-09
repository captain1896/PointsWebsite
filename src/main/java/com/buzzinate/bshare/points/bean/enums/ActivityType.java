package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * Activity type enum
 * 
 * @author martin
 *
 */
public enum ActivityType implements IntegerValuedEnum, Serializable {
    NOSTART(1), START(2), STOP(3), EXPIRED(4), DELETE(5);

    private final int code;
    
    private ActivityType(int code) {
        this.code = code;
    }
    
    @Override
    public int getCode() {
        return code;
    }
    
    public static ActivityType valueOf(int type) {
        switch (type) {
        case 1:
            return NOSTART;
        case 2:
            return START;
        case 3:
            return STOP;
        case 4:
            return EXPIRED;
        case 5:
            return DELETE;
        default:
            return NOSTART;
        }
    }
    
    public String getDesc() {
        switch (this) {
        case NOSTART:
            return "正常";
        case START:
            return "进行";
        case STOP:
            return "停止";
        case EXPIRED:
            return "结束";
        case DELETE:
            return "删除";
        default:
            return "正常";
        }
    }
}
