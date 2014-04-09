package com.buzzinate.bshare.points.action.publisher;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.core.util.OfcUtil;
import com.buzzinate.bshare.points.action.StatisticsBaseAction;
import com.buzzinate.bshare.points.bean.Account;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ActivityDailyStatistic;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.JsonResults;
import com.opensymphony.xwork2.Action;

/**
 * 站长总览
 * 
 * @author magic
 *
 */
@Controller
@Scope("request")
public class UserDashboard extends StatisticsBaseAction {

    private static final long serialVersionUID = 7800822649054384565L;
    
    private static final int POUNDAGE_RATE = ConfigurationReader.getInt("bshare.points.poundage.rate", 12);

    private String jsonDataShares = "{}";
    private String jsonDataBurlClicks = "{}";
    private String jsonDataConversion = "{}";
    private JsonResults results;

    private Account account;
    private List<Activity> activitys;  

    public String execute() {
        if (!loginHelper.isLoginAsPointsPublisher()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        
        Integer userId = loginHelper.getUserId();
        
        initDateTimePicker(3);
        // 账户基本信息
        account = accountService.findAccount(userId);

        activitys = activityService.getNormalActivityByUserId(userId);
        int size = activitys.size();
        if (size > 5) {
            activitys = activitys.subList(0, 5);
        }
        request.setAttribute("activityCount", size);
        List<ActivityDailyStatistic> dailyList = activityDailyService.getStatisticByDay(userId, dateStart, dateEnd);
        processDailyChart(dailyList);
        
        List<ActivityDailyStatistic> platformList = activityDailyService.getStatisticByPlatform(userId, 
                dateStart, dateEnd);
        prepareStats(platformList, "platform");
        
        List<ActivityDailyStatistic> activityList = activityDailyService.getStatisticByActivityId(userId, 
                dateStart, dateEnd);
        prepareStats(activityList, "activity");
        
        request.setAttribute("poundage", (POUNDAGE_RATE + 100) / 100.0);
        request.setAttribute("poundageValue", POUNDAGE_RATE);

        return Action.SUCCESS;
    }
    
    private void processDailyChart(List<ActivityDailyStatistic> dailyList) {
        boolean isShowMenu = true;
        long shareCount = 0L;
        long clickbackCount = 0L;
        if (dailyList != null) {
            List<Object[]> shares = new ArrayList<Object[]>();
            List<Object[]> clickbacks = new ArrayList<Object[]>();
            List<Object[]> conversions = new ArrayList<Object[]>();
            
            for (ActivityDailyStatistic ads : dailyList) {
                shareCount += ads.getShareCount();
                clickbackCount += ads.getClickbackCount();
                shares.add(new Object[] {ads.getShareCount(), ads.getDate() });
                clickbacks.add(new Object[] {ads.getClickbackCount(), ads.getDate() });
                conversions.add(new Object[] {ads.getShareToClickbackDouble() * 100, ads.getDate() });
            }
            
            jsonDataShares = OfcUtil.getOfc2ChartJsonData(shares, dateStart, dateEnd, OfcUtil.ChartType.LINE,
                    isShowMenu, null, null, true);
            jsonDataBurlClicks = OfcUtil.getOfc2ChartJsonData(clickbacks, dateStart, dateEnd,
                    OfcUtil.ChartType.LINE, isShowMenu, null, null, true);
            jsonDataConversion = OfcUtil.getOfc2ChartJsonData(conversions, dateStart, dateEnd,
                    OfcUtil.ChartType.LINE, isShowMenu, null, null, true);
            ActivityDailyStatistic ads = new ActivityDailyStatistic();
            ads.setShareCount(shareCount);
            ads.setClickbackCount(clickbackCount);
            request.setAttribute("stats", ads);
        }
    }
    
    private void prepareStats(List<ActivityDailyStatistic> statisticList, String type) {
        List<ActivityDailyStatistic> datas = statisticList;
        // get share stats
        double maxCount = 0;
        double shareMultiplier = 1;
        double clickbackMultiplier = 1;
        double conversionMultiplier = 1;
        if (datas != null && datas.size() > 0) {
            // find the largest number in the data:
            maxCount = datas.get(0).getShareCount();
        }
        // take only top 5
        List<ActivityDailyStatistic> shareResult = subList(datas, 5);
        // find the largest number in the data:
        maxCount = getMaxCount(shareResult, maxCount, "clickback");
        if (maxCount > 200) {
            shareMultiplier = 200 / maxCount;
        }
        
        // get clickback stats
        datas = activityDailyService.sortActivityStatistic(datas, "clickback");
        maxCount = 0;
        if (datas != null && datas.size() > 0) {
            maxCount = datas.get(0).getClickbackCount();
        }
        List<ActivityDailyStatistic> clickbackResult = subList(datas, 5);
        maxCount = getMaxCount(clickbackResult, maxCount, "share");
        if (maxCount > 200) {
            clickbackMultiplier = 200 / maxCount;
        }
        
        // get conversion stats
        datas = activityDailyService.sortActivityStatistic(datas, "sTocb");
        maxCount = 0;
        if (datas != null && datas.size() > 0) {
            maxCount = datas.get(0).getShareToClickbackDouble() * 100;
        }
        List<ActivityDailyStatistic> conversionResult = subList(datas, 5);
        if (maxCount > 200) {
            conversionMultiplier = 200 / maxCount;
        }
        
        request.setAttribute(type + "ShareStatsList", shareResult);
        request.setAttribute(type + "ShareMultiplier", shareMultiplier);
        
        request.setAttribute(type + "ClickbackStatsList", clickbackResult);
        request.setAttribute(type + "ClickbackMultiplier", clickbackMultiplier);
        
        request.setAttribute(type + "ConversionStatsList", conversionResult);
        request.setAttribute(type + "ConversionMultiplier", conversionMultiplier);
        
    }
    
    private double getMaxCount(List<ActivityDailyStatistic> statisticList, double maxCount, String type) {
        double max = maxCount;
        for (Iterator<ActivityDailyStatistic> li = statisticList.iterator(); li.hasNext();) {
            ActivityDailyStatistic ads = (ActivityDailyStatistic) li.next();
            if (type.equals("share")) {
                if (ads.getShareCount() > max) {
                    max = ads.getShareCount();
                }
            } else {
                if (ads.getClickbackCount() > max) {
                    max = ads.getClickbackCount();
                }
            }
        }
        return max;
    }
    private List<ActivityDailyStatistic> subList(List<ActivityDailyStatistic> statisticList, int size) {
        int max;
        if (statisticList.size() < size) {
            max = statisticList.size();
        } else {
            max = size;
        }
        List<ActivityDailyStatistic> result = new ArrayList<ActivityDailyStatistic>();
        for (int i = 0; i < max; i++) {
            result.add(statisticList.get(i));
        }
        return result;
    }

    public Account getAccount() {
        return account;
    }
    public String getJsonDataShares() {
        return jsonDataShares;
    }
    public String getJsonDataBurlClicks() {
        return jsonDataBurlClicks;
    }
    public String getJsonDataConversion() {
        return jsonDataConversion;
    }
    public JsonResults getResults() {
        return results;
    }
    public List<Activity> getActivitys() {
        return activitys;
    }
}
