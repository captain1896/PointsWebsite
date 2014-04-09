package com.buzzinate.bshare.points.bean.enums;

import com.buzzinate.common.hibernate.IntegerValuedEnum;

/**
 * points statistic module
 * which will store the log record for some import table 
 * @author james.chen
 * @since 2012-6-25
 */
public enum PointsStatModule implements IntegerValuedEnum {
    PUBLISHER(1, "points_account"), MERCHANT(2, "points_merchant"), ALIPAY(3, "points_alipay_record"), ACCOUNTRECORD(
            4, "points_account_record"), ORDER(5, "points_order"), POINTAS_PRODUCT(6, "points_product");
    
    private final int code;
    private final String tableName;
    
    private PointsStatModule(int code, String tableName) {
        this.code = code;
        this.tableName = tableName;
    }

    @Override
    public int getCode() {
        return this.code;
    }
    
    public String getTableName() {
        return this.tableName;
    }
}
