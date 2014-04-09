package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * Points Type enum
 * code connect with product id in points_product table
 * @author james.chen
 * @since 2012-7-3
 */
public enum PointsCategory implements IntegerValuedEnum, Serializable {
    BSHARE(1), TAOBAO(100);

    private final int code;

    private PointsCategory(int code) {
        this.code = code;
    }

    @Override
    public int getCode() {
        return this.code;
    }
    
    /**
     * judge PointsCategory exists by code
     * @param cCode
     * @return
     */
    public static boolean isPointsCategory(int cCode) {
        switch (cCode) {
        case 100:
            return true;
        default:
            return false;
        }
    }
    
    /**
     * get PointsCategory by code
     * @param cCode
     * @return
     */
    public static PointsCategory valueOf(int cCode) {
        switch (cCode) {
        case 100:
            return TAOBAO;
        default:
            throw new RuntimeException("PointsCategory not support this Category=" + cCode);
        }
    }
}
