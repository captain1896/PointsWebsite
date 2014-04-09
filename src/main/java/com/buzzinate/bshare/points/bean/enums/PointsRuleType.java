package com.buzzinate.bshare.points.bean.enums;

import java.io.Serializable;

import com.buzzinate.analytics.bean.aggregate.BasicStatistic.StatisticType;
import com.buzzinate.bshare.core.bean.enums.PointsType;
import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * Point type enum
 * 
 * @author martin
 *
 */
public enum PointsRuleType implements IntegerValuedEnum, Serializable {

    SHARE(1), CLICKBACK(2), SHARELIMIT(3), CLICKBACKLIMIT(4), TOTALLIMIT(5);

    private final int code;

    private PointsRuleType(int code) {
        this.code = code;
    }

    @Override
    public int getCode() {
        return code;
    }
    
    public static PointsRuleType valueOf(int type) {
        PointsRuleType[] st = PointsRuleType.values();
        for (PointsRuleType s : st) {
            if (s.getCode() == type) {
                return s;
            }
        }
        return SHARE;
    }

    public StatisticType convertToStatisticType() {
        if (PointsRuleType.SHARE == this) {
            return StatisticType.SHARE;
        } else {
            return StatisticType.BURL_CLICK;
        } 
    }
    
    public String getValue() {
        switch (this) {
        case SHARE:
            return "share";
        case CLICKBACK:
            return "clickback";
        default:
            return "share";
        }
    }

    public static PointsRuleType valueOf(PointsType pointsType) {
        if (pointsType == PointsType.CLICKBACK) {
            return CLICKBACK;
        } else {
            return SHARE;
        }
    }
}
