package com.buzzinate.bshare.points.action.admin;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.analytics.bean.aggregate.WebsiteDailyStatistic;
import com.buzzinate.bshare.analytics.bean.UuidWebsiteStatistics;
import com.buzzinate.bshare.core.bean.UuidSite;
import com.buzzinate.bshare.core.bean.cache.UuidCacheInfo;
import com.buzzinate.bshare.core.cache.UuidSiteCache;
import com.buzzinate.bshare.core.service.UuidSiteServices;
import com.buzzinate.bshare.points.action.StatisticsBaseAction;
import com.buzzinate.common.util.DateTimeUtil;
import com.buzzinate.common.util.JsonResults;
import com.buzzinate.common.util.string.StringUtil;
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
public class UuidSiteStatisticsAction extends StatisticsBaseAction {

    private static final long serialVersionUID = -3179937785669011738L;
    
    @Autowired
    private UuidSiteServices uuidSiteServices;
    @Autowired
    private UuidSiteCache uuidSiteCache;
    
    private JsonResults results;
    private String filterText;
    private int page;
    private String domainSort;

    @Override
    public String execute() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            results.set(false, getText("bshare.points.permission.unauthorized"));
            return null;
        }
        int pageSize = 100;
        Date dateEndDate = DateTimeUtil.getCurrentDate();
        Date dateStartDate = DateTimeUtil.subtractDays(dateEndDate, 2);
        // query by specific uuid
        UuidSite uniqueSite = null;
        if (domainSort == null || domainSort.isEmpty()) {
            domainSort = "share";
        }

        Comparator<UuidWebsiteStatistics> comparator;
        String orderBy = "";
        if (domainSort.equals("share")) {
            orderBy = "OrderByShare";
            comparator = new Comparator<UuidWebsiteStatistics>() {
                public int compare(UuidWebsiteStatistics a, UuidWebsiteStatistics b) {
                    return (int) (b.getShareCount() - a.getShareCount());
                }
            };
        } else {
            // clickback
            orderBy = "OrderByBurl";
            comparator = new Comparator<UuidWebsiteStatistics>() {
                public int compare(UuidWebsiteStatistics a, UuidWebsiteStatistics b) {
                    return (int) (b.getClickbackCount() - a.getClickbackCount());
                }
            };
        }

        List<UuidWebsiteStatistics> uuidWebsiteList = new ArrayList<UuidWebsiteStatistics>();

        // here first get the uuid daily data, then get uuidsite from cache
        List<WebsiteDailyStatistic> webSiteDailyStats = activityDailyService.getWebsiteStatSum(dateStartDate,
                dateEndDate, orderBy);
        
        List<WebsiteDailyStatistic> websiteResults = null;
        
        if (StringUtils.isNotEmpty(filterText)) {
            websiteResults = webSiteDailyStats;
            //webSiteDailyStats.subList(pageSize * page, pageSize * (page + 1));
        } else {
            if (webSiteDailyStats.size() > pageSize * (page + 1)) {
                websiteResults = webSiteDailyStats.subList(pageSize * page, pageSize * (page + 1));
            } else {
                websiteResults = webSiteDailyStats.subList(pageSize * page, webSiteDailyStats.size());
            }
            request.setAttribute("totalSites", webSiteDailyStats.size());
        }
        
        for (WebsiteDailyStatistic webSiteDailyStat : websiteResults) {
            String uuid = StringUtil.byteArrayToUuid(webSiteDailyStat.getWebsiteUuid());
            UuidCacheInfo uuidCache = uuidSiteCache.getUuidCacheInfo(uuid);
            if (uuidCache != null) {
                UuidWebsiteStatistics uuidWebsiteStatistics = new UuidWebsiteStatistics(uuid, uuidCache.getName(),
                        uuidCache.getUrl(), webSiteDailyStat.getViewCount(), webSiteDailyStat.getClickCount(),
                        webSiteDailyStat.getShareCount(), webSiteDailyStat.getClickbackCount());
                uuidWebsiteList.add(uuidWebsiteStatistics);
            }
        }
        List<UuidWebsiteStatistics> uuidList = new ArrayList<UuidWebsiteStatistics>();
        
        if (StringUtils.isNotEmpty(filterText)) {
            for (UuidWebsiteStatistics uuidDailyStat : uuidWebsiteList) {
                if (StringUtils.contains(uuidDailyStat.getUrl(), filterText)) {
                    uuidList.add(uuidDailyStat);
                }
            }
            
            if (uuidList.size() > pageSize * (page + 1)) {
                uuidList = uuidList.subList(pageSize * page, pageSize * (page + 1));
            } else {
                uuidList = uuidList.subList(pageSize * page, uuidList.size());
            }
            request.setAttribute("totalSites", uuidList.size());
            request.setAttribute("uuidWebsiteList", uuidList);
        } else {
            request.setAttribute("uuidWebsiteList", uuidWebsiteList); 
        }
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("page", page);


        return Action.SUCCESS;
    }
    
    public JsonResults getResults() {
        return results;
    }

    public void setResults(JsonResults results) {
        this.results = results;
    }

    public String getDomainSort() {
        return domainSort;
    }

    public void setDomainSort(String domainSort) {
        this.domainSort = domainSort;
    }

    public String getFilterText() {
        return filterText;
    }

    public void setFilterText(String filterText) {
        this.filterText = filterText;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

}
