package com.buzzinate.bshare.points.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.analytics.bean.aggregate.WebsiteDailyStatistic;
import com.buzzinate.bshare.core.bean.UuidSite;
import com.buzzinate.bshare.core.cache.PlatformCache;
import com.buzzinate.bshare.core.service.UuidSiteServices;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ActivityDailyStatistic;
import com.buzzinate.bshare.points.dao.ActivityDailyDao;
import com.buzzinate.common.util.DateTimeUtil;


/**
 * 
 * @author martin
 *
 */
@Service
public class ActivityDailyService implements Serializable {

    private static final long serialVersionUID = -3486688172876581786L;
    
    @Autowired
    private ActivityDailyDao activityDailyDao;
    @Autowired
    private PlatformCache platformCache;
    @Autowired
    private ActivityService activityService;
    @Autowired
    private UuidSiteServices uuidSiteServices;
    
    public List<ActivityDailyStatistic> getStatisticByDay(int userId, Date dateStart, Date dateEnd) {
        List<ActivityDailyStatistic> dailyList = new ArrayList<ActivityDailyStatistic>();
        List<byte[]> uuids = getUuidsByPublisherId(userId);
        if (uuids.size() > 0) {
            List<Object[]> list = activityDailyDao.getStatisticByDay(uuids, dateStart, dateEnd);
            for (Object[] o : list) {
                ActivityDailyStatistic ads = new ActivityDailyStatistic();
                ads.setDate((Date) o[0]);
                ads.setShareCount((Long) o[1]);
                ads.setClickbackCount((Long) o[2]);
                dailyList.add(ads);
            }
        }
        return dailyList;
    }
    
    private List<byte[]> getUuidsByPublisherId(int userId) {
        List<UuidSite> uuids = uuidSiteServices.getUuidSiteByUserId(userId);
        List<byte[]> results = new ArrayList<byte[]>();
        for (UuidSite uuid : uuids) {
            results.add(uuid.getUuidBytes());
        }
        return results;
    }

    public List<ActivityDailyStatistic> getStatisticByPlatform(int userId, Date dateStart, Date dateEnd) {
        List<ActivityDailyStatistic> dailyList = new ArrayList<ActivityDailyStatistic>();
        List<byte[]> uuids = getUuidsByPublisherId(userId);
        if (uuids.size() > 0) {
            List<Object[]> list = activityDailyDao.getStatisticByPlatform(uuids, dateStart, dateEnd);
            for (Object[] o : list) {
                ActivityDailyStatistic ads = new ActivityDailyStatistic();
                ads.setPlatformId((Integer) o[0]);
                ads.setShareCount((Long) o[1]);
                ads.setClickbackCount((Long) o[2]);
                ads.setPlatformName(platformCache.getPlatformById(ads.getPlatformId()).getPlatformName());
                dailyList.add(ads);
            }
        }
        return dailyList;
    }
    
    public List<ActivityDailyStatistic> getStatisticByActivityId(int userId, Date dateStart, Date dateEnd) {
        List<ActivityDailyStatistic> dailyList = new ArrayList<ActivityDailyStatistic>();
        List<byte[]> uuids = getUuidsByPublisherId(userId);
        if (uuids.size() > 0) {
            List<Object[]> list = activityDailyDao.getStatisticByActivityId(uuids, dateStart, dateEnd);
            for (Object[] o : list) {
                ActivityDailyStatistic ads = new ActivityDailyStatistic();
                ads.setActivityId((Integer) o[0]);
                ads.setShareCount((Long) o[1]);
                ads.setClickbackCount((Long) o[2]);
                // TODO 使用cache优化
                ads.setActivityName(activityService.getActivityById(ads.getActivityId()).getName());
                dailyList.add(ads);
            }
        }

        return dailyList;
    }
    
    public List<ActivityDailyStatistic> getDailyStatisticByActivityId(int userId, int activityId, 
            Date dateStart, Date dateEnd) {
        List<ActivityDailyStatistic> dailyList = new ArrayList<ActivityDailyStatistic>();
        Activity a = activityService.getActivityById(activityId);
        if (userId == a.getPublisherId()) {
            List<Object[]> list = activityDailyDao.getDailyStatisticByActivityId(activityId, dateStart, dateEnd);
            for (Object[] o : list) {
                ActivityDailyStatistic ads = new ActivityDailyStatistic();
                ads.setDate((Date) o[0]);
                ads.setShareCount((Long) o[1]);
                ads.setClickbackCount((Long) o[2]);
                dailyList.add(ads);
            }
        }
        return dailyList;
    }
    
    public List<ActivityDailyStatistic> sortActivityStatistic(List<ActivityDailyStatistic> datas, 
            final String orderby) {

        if (orderby.equals("share")) {
            Collections.sort(datas, new Comparator<ActivityDailyStatistic>() {
                public int compare(ActivityDailyStatistic o1, ActivityDailyStatistic o2) {
                    return (int) (o2.getShareCount() - o1.getShareCount());
                }
            });
        } else if (orderby.equals("clickback")) {
            Collections.sort(datas, new Comparator<ActivityDailyStatistic>() {
                public int compare(ActivityDailyStatistic o1, ActivityDailyStatistic o2) {
                    return (int) (o2.getClickbackCount() - o1.getClickbackCount());
                }
            });
        } else {
            Collections.sort(datas, new Comparator<ActivityDailyStatistic>() {
                public int compare(ActivityDailyStatistic o1, ActivityDailyStatistic o2) {
                    if (o2.getShareToClickbackDouble() - o1.getShareToClickbackDouble() > 0) {
                        return 1;
                    } else if (o2.getShareToClickbackDouble() - o1.getShareToClickbackDouble() == 0) {
                        return 0;
                    } else {
                        return -1;
                    }
                }
            });
        }
        
        return datas;
    }
    
    public Map<String, Map<String, ActivityDailyStatistic>> getDailyStatisticByActivityIds(int userId, String[] ids,
            Date dateStart, Date dateEnd) {
        List<Object[]> list = activityDailyDao.getDailyStatisticByActivityIds(ids, dateStart, dateEnd);
        Map<String, Map<String, ActivityDailyStatistic>> dailyMap = 
                new LinkedHashMap<String, Map<String, ActivityDailyStatistic>>();
        int dateIndex = DateTimeUtil.getDaysDiff(dateStart, dateEnd);
        Map<String, ActivityDailyStatistic> map = null;
        for (int i = 0; i <= dateIndex; i++) {
            Date date = DateTimeUtil.plusDays(dateStart, i);
            map = new LinkedHashMap<String, ActivityDailyStatistic>();
            String key = DateTimeUtil.formatDate(date);
            dailyMap.put(key, map);
        }
        
        for (Object[] o : list) {
            ActivityDailyStatistic ads = new ActivityDailyStatistic();
            ads.setDate((Date) o[0]);
            ads.setActivityId((Integer) o[1]);
            ads.setShareCount((Long) o[2]);
            ads.setClickbackCount((Long) o[3]);
            String key = DateTimeUtil.formatDate(ads.getDate());
            dailyMap.get(key).put(String.valueOf(ads.getActivityId()), ads);
        }
        return dailyMap;
    }

    public List<ActivityDailyStatistic> getPlatformStatisticByActivityId(int userId, int activityId, 
            Date dateStart, Date dateEnd) {
        List<ActivityDailyStatistic> platformList = new ArrayList<ActivityDailyStatistic>();
        Activity a = activityService.getActivityById(activityId);
        if (userId == a.getPublisherId()) {
            List<Object[]> list = activityDailyDao.getPlatformStatisticByActivityId(activityId, dateStart, dateEnd);
            for (Object[] o : list) {
                ActivityDailyStatistic ads = new ActivityDailyStatistic();
                ads.setPlatformId((Integer) o[0]);
                ads.setShareCount((Long) o[1]);
                ads.setClickbackCount((Long) o[2]);
                ads.setPlatformName(platformCache.getPlatformById(ads.getPlatformId()).getPlatformName());
                platformList.add(ads);
            }
        }
        return platformList;
    }

    public List<ActivityDailyStatistic> getPlatformStatisticByUserId(int userId, Date dateStart, Date dateEnd) {
        List<ActivityDailyStatistic> platformList = new ArrayList<ActivityDailyStatistic>();
        List<byte[]> uuids = getUuidsByPublisherId(userId);
        if (uuids.size() > 0) {
            List<Object[]> list = activityDailyDao.getPlatformStatisticByUserId(uuids, dateStart, dateEnd);
            for (Object[] o : list) {
                ActivityDailyStatistic ads = new ActivityDailyStatistic();
                ads.setPlatformId((Integer) o[0]);
                ads.setShareCount((Long) o[1]);
                ads.setClickbackCount((Long) o[2]);
                ads.setPlatformName(platformCache.getPlatformById(ads.getPlatformId()).getPlatformName());
                platformList.add(ads);
            }
        }
        return platformList;
    }

    public List<ActivityDailyStatistic> getDailyStatistic(Date dateStart, Date dateEnd) {
        List<ActivityDailyStatistic> dailyList = new ArrayList<ActivityDailyStatistic>();
        List<Object[]> list = activityDailyDao.getDailyStatistic(dateStart, dateEnd);
        for (Object[] o : list) {
            ActivityDailyStatistic ads = new ActivityDailyStatistic();
            ads.setDate((Date) o[0]);
            ads.setShareCount((Long) o[1]);
            ads.setClickbackCount((Long) o[2]);
            dailyList.add(ads);
        }
        return dailyList;
    }

    public List<ActivityDailyStatistic> getPlatformStatistic(Date dateStart, Date dateEnd) {
        List<ActivityDailyStatistic> platformList = new ArrayList<ActivityDailyStatistic>();
        List<Object[]> list = activityDailyDao.getPlatformStatistic(dateStart, dateEnd);
        for (Object[] o : list) {
            ActivityDailyStatistic ads = new ActivityDailyStatistic();
            ads.setPlatformId((Integer) o[0]);
            ads.setShareCount((Long) o[1]);
            ads.setClickbackCount((Long) o[2]);
            ads.setPlatformName(platformCache.getPlatformById(ads.getPlatformId()).getPlatformName());
            platformList.add(ads);
        }
        return platformList;
    }

    public List<WebsiteDailyStatistic> getUuidStatDailyByUuids(Date dateStart, Date dateEnd, 
            List<byte[]> uuids) {
        List<WebsiteDailyStatistic> list = new ArrayList<WebsiteDailyStatistic>();

        for (byte[] uuid : uuids) {
            WebsiteDailyStatistic wds = getUuidSiteStatistic(uuid, dateStart, dateEnd);
            if (wds != null) 
                list.add(wds);
        }
        return list;
    }
    
    public WebsiteDailyStatistic getUuidSiteStatistic(byte[] uuid, Date dateStart, Date dateEnd) {
        //List<Integer> ids = activityDailyDao.getActivityIdByUuid(uuid, dateStart, dateEnd);
        List<Object[]> list = activityDailyDao.getActivityStatisticByIds(uuid, dateStart, dateEnd);
        WebsiteDailyStatistic wds = null;
        if (list.size() > 0) {
            wds = new WebsiteDailyStatistic();
            wds.setWebsiteUuid(uuid);
            long shareCount = 0L;
            long clickbackCount = 0L;
            for (Object[] o : list) {
                shareCount += (Long) o[0];
                clickbackCount += (Long) o[1];
            }
            wds.setShareCount(shareCount);
            wds.setClickbackCount(clickbackCount);

        }
        return wds;
    }
    
    public List<WebsiteDailyStatistic> getWebsiteStatSum(Date dateStart, Date dateEnd, String orderBy) {
        List<WebsiteDailyStatistic> uuidSiteList = new ArrayList<WebsiteDailyStatistic>();
        List<Object[]> list = activityDailyDao.getActivityStatistic(dateStart, dateEnd);
        for (Object[] o : list) {
            WebsiteDailyStatistic wds = new WebsiteDailyStatistic();
            wds.setWebsiteUuid((byte[]) o[0]);
            wds.setShareCount((Long) o[1]);
            wds.setClickbackCount((Long) o[2]);
            uuidSiteList.add(wds);
        }
        return uuidSiteList;
    }
    
}
