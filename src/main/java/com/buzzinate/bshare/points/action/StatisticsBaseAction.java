package com.buzzinate.bshare.points.action;

import java.util.Date;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.buzzinate.bshare.points.service.AccountService;
import com.buzzinate.bshare.points.service.ActivityDailyService;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.common.util.DateTimeUtil;

/**
 * 
 * @author martin
 *
 */
@Component
public class StatisticsBaseAction extends BaseAction {

    protected static final String SORT_BY_SHARE = "share";
    protected static final String SORT_BY_CLICKBACK = "clickback";
    protected static final String SORT_BY_SHARE_TO_CLICKBACK = "conversion";
    
    private static final long serialVersionUID = -6857281076975622069L;
    
    protected Date dateStart;
    protected Date dateEnd;
    
    @Autowired
    protected AccountService accountService;
    @Autowired
    protected ActivityService activityService;
    @Autowired
    protected ActivityDailyService activityDailyService;
    
    protected String sortBy = "";
    
    protected void initDateTimePicker() {
        // start date is default one month ago
        initDateTimePicker(1);
    }
    
    protected void initDateTimePicker(int month) {
        // validate and set the dates
        if (dateStart == null || dateEnd == null) {
            dateEnd = DateTimeUtil.getCurrentDateDay();
            dateStart = DateTimeUtil.plusMonths(dateEnd, -month);
        }
        dateEnd = DateUtils.addSeconds(dateEnd, 3600 * 23 + 3599);
        request.setAttribute("dateStart", getDateStart());
        request.setAttribute("dateEnd", getDateEnd());
    }
    
    public String getDateStart() {
        return DateTimeUtil.formatDate(dateStart);
    }
    public void setDateStart(String dateStart) {
        this.dateStart = DateTimeUtil.convertDate(dateStart);
    }
    public String getDateEnd() {
        return DateTimeUtil.formatDate(dateEnd);
    }
    public void setDateEnd(String dateEnd) {
        this.dateEnd = DateTimeUtil.convertDate(dateEnd);
    }
    public String getSortBy() {
        return sortBy;
    }
    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }

}
