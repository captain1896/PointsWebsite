package com.buzzinate.bshare.points.action.publisher;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.core.util.OfcUtil;
import com.buzzinate.bshare.points.action.StatisticsBaseAction;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ActivityDailyStatistic;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.JsonResults;
import com.opensymphony.xwork2.Action;

/**
 * Activity statistics action
 * 
 * 
 * @author martin
 *
 */
@Controller
@Scope("request")
public class ActivityStatisticsAction extends StatisticsBaseAction {

    private static final long serialVersionUID = -9025797796185625949L;
    
    private String activityId;
    
    private String activityIds;
    
    private JsonResults results;
    
    private String jsonDataShares = "{}";
    private String jsonDataBurlClicks = "{}";
    private String jsonDataConversion = "{}";
    
    public String stats() {
        if (!loginHelper.isLoginAsPointsPublisher()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        int userId = getCurrentUserId();
        initDateTimePicker();
        List<Activity> activityList = activityService.getActivityByDate(userId, dateStart, dateEnd);
        List<ActivityDailyStatistic> dailyList = null;
        if (StringUtils.isNumeric(activityId) && Integer.valueOf(activityId) > 0) {
            dailyList =
                    activityDailyService.getDailyStatisticByActivityId(userId, Integer.valueOf(activityId), dateStart,
                            dateEnd);
        } else {
            dailyList = activityDailyService.getStatisticByDay(userId, dateStart, dateEnd);
        }
        processDailyChart(dailyList);
        sortBy = SORT_BY_SHARE;
        String jsonDataPlatfrom = getjsonDataPlatfrom(userId);
        request.setAttribute("jsonDataPlatfrom", jsonDataPlatfrom);
        request.setAttribute("activities", activityList);
        return Action.SUCCESS;
    }
    
    private void processDailyChart(List<ActivityDailyStatistic> dailyList) {
        boolean isShowMenu = true;
        long shareCount = 0L;
        long clickbackCount = 0L;
        if (dailyList != null && dailyList.size() > 0) {
            List<Object[]> shares = new ArrayList<Object[]>();
            List<Object[]> clickbacks = new ArrayList<Object[]>();
            
            for (ActivityDailyStatistic ads : dailyList) {
                shareCount += ads.getShareCount();
                clickbackCount += ads.getClickbackCount();
                shares.add(new Object[] {ads.getShareCount(), ads.getDate() });
                clickbacks.add(new Object[] {ads.getClickbackCount(), ads.getDate() });
            }
            
            jsonDataShares = OfcUtil.getOfc2ChartJsonData(shares, dateStart, dateEnd, OfcUtil.ChartType.LINE,
                    isShowMenu, null, null, true);
            jsonDataBurlClicks = OfcUtil.getOfc2ChartJsonData(clickbacks, dateStart, dateEnd,
                    OfcUtil.ChartType.LINE, isShowMenu, null, null, true);
        }
        ActivityDailyStatistic ads = new ActivityDailyStatistic();
        ads.setShareCount(shareCount);
        ads.setClickbackCount(clickbackCount);
        request.setAttribute("stats", ads);
    }
    
    public String contrast() {
        int userId = getCurrentUserId();
        initDateTimePicker();
        List<Activity> activityList = activityService.getActivityByDate(userId, dateStart, dateEnd);
        String[] ids = new String[2];
        if (!StringUtils.isEmpty(activityIds)) {
            ids = StringUtils.split(activityIds, "|");

            Map<String, Map<String, ActivityDailyStatistic>> dailyMaps = null;
            if (ids != null) {
                dailyMaps = activityDailyService.getDailyStatisticByActivityIds(userId, ids, dateStart, dateEnd);
            }
            if (dailyMaps != null && dailyMaps.size() > 0) {
                prepareContrastCharts(dailyMaps, ids);
            }
        }
        request.setAttribute("activities", activityList);
        request.setAttribute("activitieStr", ids);
        return Action.SUCCESS;
    }
    
    private void prepareContrastCharts(Map<String, Map<String, ActivityDailyStatistic>> dailyMaps, String[] ids) {
        int size = ids.length;
        boolean isShowMenu = true;
        String[] keys = new String[size];
        
        for (int i = 0; i < ids.length; i++) {
            keys[i] = activityService.getActivityById(Integer.parseInt(ids[i])).getName();
        }
        
        List<Object[]> shares = new ArrayList<Object[]>();
        List<Object[]> clickbacks = new ArrayList<Object[]>();
        List<Object[]> conversions = new ArrayList<Object[]>();
        Long[] source = new Long[size];
        for (int i = 0; i < size; i++) {
            source[i] = 0L;
        }

        for (String date : dailyMaps.keySet()) {
            
            Map<String, ActivityDailyStatistic> dailyMap = dailyMaps.get(date);
            Long[] shareCounts = source.clone();
            Long[] clickbackCounts = source.clone();
            Long[] conversionCounts = source.clone();
            if (dailyMap.size() > 0) {
                int i = 0;
                for (String id : ids) {
                    ActivityDailyStatistic ads = dailyMap.get(id);
                    long shareCount = 0;
                    long clickbackCount = 0;
                    long conversionCount = 0;
                    if (ads != null) {
                        shareCount = ads.getShareCount();
                        clickbackCount = ads.getClickbackCount();
                        conversionCount = (long) (ads.getShareToClickbackDouble() * 100);
                    }
                    shareCounts[i] = shareCount;
                    clickbackCounts[i] = clickbackCount;
                    conversionCounts[i] = conversionCount;
                    i++;
                }
            } else {
                for (int i = 0; i < size; i++) {
                    shareCounts[i] = 0L;
                    clickbackCounts[i] = 0L;
                    conversionCounts[i] = 0L;
                }
            }
            
            shares.add(new Object[] {shareCounts, date, keys});
            clickbacks.add(new Object[] {clickbackCounts, date, keys});
            conversions.add(new Object[] {conversionCounts, date, keys});
        }
        
        jsonDataShares = OfcUtil.getOfc2ChartJsonData(shares, OfcUtil.ChartType.LINE_MULTIPLE, 
                isShowMenu, null, null, true, keys, shares.size(), (int) (shares.size() / 8));
        jsonDataBurlClicks = OfcUtil.getOfc2ChartJsonData(clickbacks, OfcUtil.ChartType.LINE_MULTIPLE, 
                isShowMenu, null, null, true, keys, clickbacks.size(), (int) (clickbacks.size() / 8));
        jsonDataConversion = OfcUtil.getOfc2ChartJsonData(conversions, OfcUtil.ChartType.LINE_MULTIPLE, 
                isShowMenu, null, null, true, keys, conversions.size(), (int) (conversions.size() / 8));
    }
       
    public String getPlatformChart() {
        int userId = getCurrentUserId();
        
        String jsonDataPlatfrom = getjsonDataPlatfrom(userId);
        results = new JsonResults();

        results.addContent("jsonDataPlatfrom", jsonDataPlatfrom);
        results.set(true);
        return JsonResults.JSON_RESULT_NAME;
    }
    
    public String getjsonDataPlatfrom(int userId) {
        String jsonDataPlatfrom = "{}";
        List<ActivityDailyStatistic> platformList = null;
        if (StringUtils.isNumeric(activityId) && Integer.valueOf(activityId) > 0) {
            platformList = activityDailyService.getPlatformStatisticByActivityId(userId, Integer.valueOf(activityId), 
                    dateStart, dateEnd);
        } else {
            platformList = activityDailyService.getPlatformStatisticByUserId(userId, dateStart, dateEnd);
        }
        
        if (platformList != null && platformList.size() > 0) {
            jsonDataPlatfrom = preparePlatformCharts(platformList);
        }
        return jsonDataPlatfrom;
    }
    
    private String preparePlatformCharts(List<ActivityDailyStatistic> platformList) {
        Comparator<ActivityDailyStatistic> comparator;
        if (sortBy.equals(SORT_BY_CLICKBACK)) {
            comparator = new Comparator<ActivityDailyStatistic>() {
                public int compare(ActivityDailyStatistic a, ActivityDailyStatistic b) {
                    return (int) (b.getClickbackCount() - a.getClickbackCount());
                }
            };
        } else if (sortBy.equals(SORT_BY_SHARE_TO_CLICKBACK)) {
            comparator = new Comparator<ActivityDailyStatistic>() {
                public int compare(ActivityDailyStatistic a, ActivityDailyStatistic b) {
                    if (b.getShareToClickbackDouble() - a.getShareToClickbackDouble() > 0) {
                        return 1;
                    } else if (b.getShareToClickbackDouble() - a.getShareToClickbackDouble() == 0) {
                        return 0;
                    } else {
                        return -1;
                    }
                }
            };
        } else {
            comparator = new Comparator<ActivityDailyStatistic>() {
                public int compare(ActivityDailyStatistic a, ActivityDailyStatistic b) {
                    return (int) (b.getShareCount() - a.getShareCount());
                }
            };
        }
        Collections.sort(platformList, comparator);
        
        List<Object[]> platformSharePie = new ArrayList<Object[]>();
        String detailsLabel = "";
        for (ActivityDailyStatistic ads : platformList) {
            if (sortBy.equals(SORT_BY_SHARE)) {
                if (ads.getShareCount() != 0) {
                    platformSharePie.add(new Object[]{ads.getPlatformName(), ads.getShareCount()});
                    detailsLabel = "shares";
                }
            } else if (sortBy.equals(SORT_BY_CLICKBACK)) {
                if (ads.getClickbackCount() != 0) {
                    platformSharePie.add(new Object[]{ads.getPlatformName(), ads.getClickbackCount()});
                    detailsLabel = "clickbacks";
                }
            } else {
                if ((ads.getShareToClickbackDouble() * 100) != 0) {
                    platformSharePie.add(new Object[]{ads.getPlatformName(), ads.getClickbackCount()});
                    detailsLabel = "conversions";
                }
            }
        }
            
        return OfcUtil.generateJsonDataPieChart(platformSharePie, this, detailsLabel, 
                    ConfigurationReader.getInt("bshare.statistics.platform.pie.max"), 
                    OfcUtil.PieChartType.PLATFORM_PIE);
    }

    public String userStats() {
        
        return Action.SUCCESS;
    }

    public String getJsonDataShares() {
        return jsonDataShares;
    }

    public String getJsonDataBurlClicks() {
        return jsonDataBurlClicks;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }


    public String getActivityIds() {
        return activityIds;
    }

    public void setActivityIds(String activityIds) {
        this.activityIds = activityIds;
    }

    public String getJsonDataConversion() {
        return jsonDataConversion;
    }
    
    public JsonResults getResults() {
        return results;
    }
}
