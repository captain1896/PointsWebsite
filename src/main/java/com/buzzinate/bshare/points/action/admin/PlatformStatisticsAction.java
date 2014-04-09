package com.buzzinate.bshare.points.action.admin;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.StopWatch;

import com.buzzinate.bshare.core.util.OfcUtil;
import com.buzzinate.bshare.points.action.StatisticsBaseAction;
import com.buzzinate.bshare.points.bean.ActivityDailyStatistic;
import com.buzzinate.common.exceptions.ServicesException;
import com.buzzinate.common.util.ConfigurationReader;
import com.opensymphony.xwork2.Action;

/**
 * 
 * @author Martin
 *
 */
@Controller
@Scope("request")
public class PlatformStatisticsAction extends StatisticsBaseAction {
    
    private static final long serialVersionUID = 7405829040706179205L;
    
    private String jsonDataPlatformsPie = "{}";
    
    @Override
    public String execute() throws ServicesException {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        
        StopWatch sw = new StopWatch();
        sw.start();
        
        if (sortBy.isEmpty()) {
            sortBy = SORT_BY_SHARE;
        }
        initDateTimePicker();
        List<ActivityDailyStatistic> platformStatsList = activityDailyService.getPlatformStatistic(dateStart, dateEnd);
        if (platformStatsList.isEmpty()) {
            request.setAttribute("isNoData", true);
            return Action.SUCCESS;
        } else {
            request.setAttribute("isNoData", false);
        }
        
        String jsonDataPlatfrom = getjsonDataPlatfrom();
        sw.stop();
        request.setAttribute("executionTime", sw.getTotalTimeSeconds());
        request.setAttribute("reportTime", new Date(System.currentTimeMillis()));
        request.setAttribute("jsonDataPlatfrom", jsonDataPlatfrom);
        return Action.SUCCESS;
    }
        
    
    public String getjsonDataPlatfrom() {
        String jsonDataPlatfrom = "{}";
        List<ActivityDailyStatistic> platformList = null;

        platformList = activityDailyService.getPlatformStatistic(dateStart, dateEnd);
        
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
        
        request.setAttribute("platformStatsList", platformList);
        
        if (!StringUtils.equals(sortBy, SORT_BY_SHARE_TO_CLICKBACK)) {
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
            
            if (platformSharePie.size() > 0) {
                return OfcUtil.generateJsonDataPieChart(platformSharePie, this, detailsLabel, 
                            ConfigurationReader.getInt("bshare.statistics.platform.pie.max"), 
                            OfcUtil.PieChartType.PLATFORM_PIE);
            }
        } 
        return "{}";
    }

    public String getJsonDataPlatformsPie() {
        return jsonDataPlatformsPie;
    }
}
