package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * Trade status enum
 * 
 * @author martin
 *
 */
public enum TradeStatus implements IntegerValuedEnum, Serializable {

    WAITPAY(0), SUCCESS(2), FAIL(-1);

    private final int code;

    private TradeStatus(int code) {
        this.code = code;
    }

    @Override
    public int getCode() {
        return code;
    }

}
