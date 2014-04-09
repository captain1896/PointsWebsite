package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.util.HtmlUtils;

import com.buzzinate.analytics.bean.aggregate.BasicStatistic.StatisticType;
import com.buzzinate.common.util.DateTimeUtil;

/**
 * Activity daily statistic info
 * 
 * @author martin
 * 
 */
public class ActivityDailyStatistic implements Serializable {

    private static final long serialVersionUID = 4687198684367889993L;

    private static DecimalFormat format = new DecimalFormat("#,###,##0.00%");

    private int activityId;
    private Date date;
    private int platformId;
    private StatisticType type;
    private byte[] uuid;

    private long shareCount;
    private long clickbackCount;

    private String activityName;
    private String platformName;

    public ActivityDailyStatistic() {
    }

    public ActivityDailyStatistic(int activityId, int platformId, StatisticType type, byte[] uuid) {
        this.activityId = activityId;
        this.platformId = platformId;
        this.type = type;
        this.date = DateTimeUtil.getDateDay(new Date());
        this.uuid = uuid;
    }
    
    public String getKey() {
        return DateTimeUtil.formatDate(date) + activityId + platformId;
    }

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getPlatformId() {
        return platformId;
    }

    public void setPlatformId(int platformId) {
        this.platformId = platformId;
    }

    public long getShareCount() {
        return shareCount;
    }

    public void setShareCount(long shareCount) {
        this.shareCount = shareCount;
    }

    public long getClickbackCount() {
        return clickbackCount;
    }

    public void setClickbackCount(long clickbackCount) {
        this.clickbackCount = clickbackCount;
    }

    public String getActivityName() {
        return activityName;
    }

    public String getActivityShortName() {
        return StringUtils.substring(HtmlUtils.htmlUnescape(activityName), 0, 5);
    }
    
    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public String getPlatformName() {
        return platformName;
    }

    public void setPlatformName(String platformName) {
        this.platformName = platformName;
    }
    
    public StatisticType getType() {
        return type;
    }

    public void setType(StatisticType type) {
        this.type = type;
    }
    
    public byte[] getUuid() {
        return uuid;
    }

    public void setUuid(byte[] uuid) {
        this.uuid = uuid;
    }

    public String getShareToClickback() {
        if (shareCount == 0) {
            return "-";
        }
        double spv = (double) clickbackCount / shareCount;
        return format.format(spv);
    }

    public double getShareToClickbackDouble() {
        if (shareCount == 0) {
            return 0;
        }
        return (double) clickbackCount / shareCount;
    }

    public void increaseStatistic(StatisticType t) {
        switch (t) {
        case SHARE:
            shareCount++;
            break;
        case BURL_CLICK:
            clickbackCount++;
            break;
        default:
            break;
        }
    }

    @Override
    public String toString() {
        return "activityId:" + activityId + " platformId:" + platformId + " shareCount:" + shareCount + 
                        " cbCount:" + clickbackCount;
    }

}
