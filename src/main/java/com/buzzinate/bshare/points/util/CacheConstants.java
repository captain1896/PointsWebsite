package com.buzzinate.bshare.points.util;

import com.buzzinate.common.util.DateTimeUtil;

/**
 * Cache常量定义类
 * 
 * @author magic
 *
 */
public final class CacheConstants {

    public static final String TOAOL_POINTS_PREFIX = "PL:";
    public static final int EXPIRE_TOAOL_POINTS_PREFIX = 3600 * 24;
    
    public static final String SHARE_NUM_OF_CALC_POINTS_PREFIX = "PN:";
    public static final int EXPIRE_CURRENT_SHARE_NUM_PREFIX = 3600 * 24;
    
    public static final String ACCOUNT = "ACC:";
    public static final int EXPIRE_ACCOUNT = 3600 * 24;
    
    public static final String ACTIVITY = "ACT:";
    public static final int EXPIRE_ACTIVITY = 3600 * 24;
    
    public static final String POINT_NAME = "PON:";
    public static final int EXPIRE_POINT_NAME = 3600 * 24;
    
    public static final String POINTSPRODUCT_NAME = "PRD:";
    public static final int EXPIRE_PRODUCT_NAME = 3600 * 24;
    
    public static final String PRODUCT_CATEGORY = "PC:";
    public static final int EXPIRE_PRODUCT_CATEGORY = 3600 * 24;
    
    public static final String MERCHANT = "ME:";
    public static final int EXPIRE_MERCHANT = 3600 * 24;
    
    public static final String USER_NAME = "USR:";
    public static final int EXPIRE_USER_NAME = 3600 * 24;
    
    public static final int EXPIRE_IDS = 3600 * 2;
    
    public static final String PRODUCT_WITH_CATEGORY = "PWC:";
    public static final int EXPIRE_PRDUCT_WITH_CATEGORY = 3600 * 4;
    
    public static final String UUID_ACTIVITY = "UUA:";
    
    public static final int EXPIRE_ONE_DAY = 3600 * 24;
    
    public static final String ACTIVITY_LIMIT = "AL:";
    
    private CacheConstants() { }
    
    public static int getTillTomorrowExpireTime() {
        return CacheConstants.EXPIRE_ONE_DAY - 
                (int) (DateTimeUtil.getCurrentDate().getTime() - DateTimeUtil.getCurrentDateDay().getTime()) / 1000;
    }
}
