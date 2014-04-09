package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**Activity Category
 * @author james.chen
 * @since 2012-7-12
 */
public enum ActivityCategory implements IntegerValuedEnum, Serializable {
    NORMAL(1), OLYMPIC(2);

    private int code;

    private ActivityCategory(int code) {
        this.code = code;
    }

    @Override
    public int getCode() {
        return this.code;
    }
}
