package com.buzzinate.bshare.points.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;

/**
 * some utility function for RandomValue
 * @author james.chen
 * @since 2012-6-6
 */
public final class RandomUtils {
    // DateFormat for OrderNO
    private static DateFormat df = new SimpleDateFormat("yyyyMMdd");
    
    private RandomUtils() {
    }
    //get int value between min and max
    public static int genRandom(int min , int max) {
        return min + (int) (Math.random() * (max - min));
    }

    public static String genOrderNo() {
        return new StringBuilder(df.format(new Date())).append(RandomStringUtils.randomAlphanumeric(12).toLowerCase())
                .toString();
    }
    
    /**olympic coupon no
     * first character upper case
     * second and third are date value.
     * the other five are random character or number;
     * @return
     */
    public static String genOlympicLottery() {
        return new StringBuilder(RandomStringUtils.randomAlphabetic(1))
                .append(StringUtils.leftPad(String.valueOf(Calendar.getInstance().get(Calendar.DATE)), 2, '0'))
                .append(RandomStringUtils.randomAlphanumeric(5)).toString().toUpperCase();
    }
    ///bshare RandomValue
    public static String getBshareRandom(int num) {
        String[] bshare = new String[] {"b", "s", "h", "a", "r", "e" };
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < 12; i++) {
            if (i % 2 == 1) {
                result.append(RandomStringUtils.randomAlphanumeric(1));
            } else {
                result.append(bshare[i / 2]);
            }
        }
        if (num > 12) {
            result.append(RandomStringUtils.randomAlphanumeric(num - 12));
        }
        return result.toString().toUpperCase();
    }
    
    public static void main(String[] args){
        for(int i=0;i<20;i++){
            System.out.println(getBshareRandom(15));
        }
    }
}
