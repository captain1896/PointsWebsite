package com.buzzinate.bshare.points.service.exchange;

/**
 * the Points
 * @author james.chen
 * @since 2012-7-3
 */
public interface PointsExchange {

    /**
     * the method to get related PointsNum by Account Name
     * 
     * @return
     */
    long getPointsNumByAccountName(String accountName);

    /**
     * the method addPoints to Related AccountName
     * @return bill no
     */
    String addPointsByAccountName(String accountName , int pointsNum , String outbizNo);
}
