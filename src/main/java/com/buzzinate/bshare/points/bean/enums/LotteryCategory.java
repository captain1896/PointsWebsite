package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * @author james.chen
 * @since 2012-7-20
 *
 */
public enum LotteryCategory implements IntegerValuedEnum, Serializable {
    OlympicLottery(500);

    private static final long serialVersionUID = 2549714622312525921L;
    private final int code;

    private LotteryCategory(int code) {
        this.code = code;
    }
    @Override
    public int getCode() {
        return code;
    }

    // isLottery
    public static boolean isLottery(int oCode) {
        switch (oCode) {
        case 500:
            return true;
        default:
            return false;
        }
    }
    //get Lottery Category by relate code
    public static LotteryCategory valueof(int cCode) {
        switch (cCode) {
        case 500:
            return OlympicLottery;
        default:
            throw new RuntimeException("PointsCategory not support this Category=" + cCode);
        }
    }
}
