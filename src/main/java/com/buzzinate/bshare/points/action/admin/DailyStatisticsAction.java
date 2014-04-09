package com.buzzinate.bshare.points.action.admin;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.StopWatch;

import com.buzzinate.bshare.core.util.OfcUtil;
import com.buzzinate.bshare.points.action.StatisticsBaseAction;
import com.buzzinate.bshare.points.bean.ActivityDailyStatistic;
import com.buzzinate.common.exceptions.ServicesException;
import com.opensymphony.xwork2.Action;

/**
 * Admin activity statistics action
 * 
 * 
 * @author martin
 * 
 */
@Controller
@Scope("request")
public class DailyStatisticsAction extends StatisticsBaseAction {

    private static final long serialVersionUID = -2651871264705267706L;

    private static DecimalFormat format = new DecimalFormat("######0.00");

    private String jsonDataShares = "{}";
    private String jsonDataBurlClicks = "{}";
    private String jsonDataConversion = "{}";

    @Override
    public String execute() throws ServicesException {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }

        StopWatch sw = new StopWatch();
        sw.start();

        initDateTimePicker();

        List<ActivityDailyStatistic> dailyList;
        
        dailyList = activityDailyService.getDailyStatistic(dateStart, dateEnd);

        // generate current stats and charts
        preparedailyStatisticBarChart(dailyList, true);

        sw.stop();
        request.setAttribute("executionTime", sw.getTotalTimeSeconds());
        request.setAttribute("reportTime", new Date(System.currentTimeMillis()));
        return Action.SUCCESS;
    }

    private void preparedailyStatisticBarChart(List<ActivityDailyStatistic> dailyList,
            boolean isCurrentStats) {

        if (dailyList != null) {
            List<Object[]> shares = new ArrayList<Object[]>();
            List<Object[]> burlClicks = new ArrayList<Object[]>();
            List<Object[]> shareToClickback = new ArrayList<Object[]>();

            for (ActivityDailyStatistic daily : dailyList) {
                shares.add(new Object[] { daily.getShareCount(), daily.getDate() });
                burlClicks.add(new Object[] { daily.getClickbackCount(), daily.getDate() });
                shareToClickback.add(new Object[] {
                        Double.parseDouble(format.format(daily.getShareToClickbackDouble() * 100)), daily.getDate() });
            }
            if (isCurrentStats) {

                jsonDataShares = OfcUtil.getOfc2ChartJsonData(shares, dateStart, dateEnd, OfcUtil.ChartType.LINE,
                        true, null, null, true);
                jsonDataBurlClicks = OfcUtil.getOfc2ChartJsonData(burlClicks, dateStart, dateEnd,
                        OfcUtil.ChartType.LINE, true, null, null, true);
            }
        }

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
}
