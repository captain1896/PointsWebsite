package com.buzzinate.bshare.points.bean.enums;

import java.util.ArrayList;
import java.util.List;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * the enum for Product Status
 * currently, there are three status
 * ACTIVE 1, INACTIVE 2, PERFERED(3)
 * @author james.chen
 * @since 2012-6-11
 */
public enum ProductStatus implements IntegerValuedEnum {
    UNAUDIT(-1), PERFERED(0), ACTIVE(1), INACTIVE(2), DELETED(3);

    private static List<ProductStatus> queryStatus;
    
    private final int code;

    private ProductStatus(int code) {
        this.code = code;
    }

    @Override
    public int getCode() {
        return this.code;
    }
    
    public static ProductStatus valueOf(int type) {
        switch (type) {
        case -1:
            return UNAUDIT;
        case 0:
            return PERFERED;
        case 1:
            return ACTIVE;
        case 2:
            return INACTIVE;
        case 3 :
            return DELETED;
        default:
            return DELETED;
        }
    }
    
    public static List<ProductStatus> getStatus() {
        if (queryStatus == null) {
            queryStatus = new ArrayList<ProductStatus>();
            queryStatus.add(PERFERED);
            queryStatus.add(ACTIVE);
            queryStatus.add(UNAUDIT);
            queryStatus.add(INACTIVE);
            queryStatus.add(DELETED);
        }
        return queryStatus;
    }

}
