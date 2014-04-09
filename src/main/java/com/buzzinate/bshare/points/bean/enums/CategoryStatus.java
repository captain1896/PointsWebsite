package com.buzzinate.bshare.points.bean.enums;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * category Status
 * @author james.chen
 * @since 2012-7-3
 */
public enum CategoryStatus implements IntegerValuedEnum {
    ACTIVE(1), INACTIVE(2);

    private final int code;

    private CategoryStatus(int code) {
        this.code = code;
    }

    @Override
    public int getCode() {
        return this.code;
    }
}
