package com.buzzinate.bshare.points.service;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.safehaus.uuid.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.core.bean.UuidCustomization;
import com.buzzinate.bshare.core.bean.UuidSite;
import com.buzzinate.bshare.core.service.UuidCustomizationServices;
import com.buzzinate.bshare.core.service.UuidSiteServices;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.enums.AccountRecordType;
import com.buzzinate.bshare.points.bean.enums.ActivityCategory;
import com.buzzinate.bshare.points.bean.enums.ActivityType;
import com.buzzinate.bshare.points.dao.ActivityDao;
import com.buzzinate.bshare.points.util.CacheConstants;
import com.buzzinate.common.services.MemcachedService;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.Pagination;
import com.buzzinate.common.util.string.StringUtil;

/**
 * Activity manager service
 * 
 * @author martin
 *
 */
@Service
public class ActivityService extends MemcachedService<Activity, Integer, ActivityDao> implements Serializable {
    
    private static final long serialVersionUID = 6900059769541777569L;
    
    private static Log log = LogFactory.getLog(ActivityService.class);
    
    private static final String FIRST_THREE_A = "FIRSTTHREE";
    private static final String PRODUCT_A = "PRODUCT";
    
    private static final String NORMAL_A = "NORMAL";
    private static final String OLYMPIC = "Olympic";
    private static final String OLYMPIC_LIST = "Olympic_List";
    
    //private static final String NORMAL_COUNT = CacheConstants.ACTIVITY + "NORMAL_COUNT";
    private static final int FIRST_PAGE = ConfigurationReader.getInt("bshare.points.firstpage.activity.num");
    private static final int PRODUCT_PAGE = ConfigurationReader.getInt("bshare.points.product.activity.num");
    
    private static final int PUBLISHER_ID = ConfigurationReader.getInt("bshare.points.publisher.id");
    private static final String POINTS_UUID = ConfigurationReader.getString("bshare.points.uuid");
    
    private static final int TOTAL_POINTS = ConfigurationReader.getInt("bshare.points.task.olympic.totalpoints");

    //
    private static final boolean REFUNDSPECIALFLAG = ConfigurationReader
            .getBoolean("bshare.task.special.close.refundflag");
    @Autowired
    private ActivityDao activityDao;
    @Autowired
    private PointRuleService pointRuleService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private UuidSiteServices uuidSiteService;
    @Autowired
    private UuidCustomizationServices uuidCustomizationServices;
    @Autowired
    private PointsActivityStatService statService;
    
    public ActivityService() {
        entitiesSuffixs.add(FIRST_THREE_A);
        entitiesSuffixs.add(PRODUCT_A);
        entitiesSuffixs.add(NORMAL_A);
        entitiesSuffixs.add(OLYMPIC);
        entitiesSuffixs.add(OLYMPIC_LIST);
    }
    

    public List<Activity> getActivityByUserId(int userId) {
        List<Activity> activities = activityDao.getActivityByUserId(userId);
        Collections.sort(activities, new ActivityComparator());
        return activities;
    }

    public Activity getActivityById(int id) {
        return fullActivity(get(id));
    }
    
    public Activity getActivityByIdFromDb(int id) {
        return fullActivity(get(id));
    }

    /**
     * 删除活动，积分规则一并删除；同时返还积分
     * 
     * @param id
     */
    @Transactional(value = "points", readOnly = false)
    public void deleteActivityById(int id) {
        Activity activity = getActivityById(id);
        if (activity != null) {
            //set activity status to DELETE
            //if expired status the point was returned during finish prcess.
            if (ActivityType.EXPIRED != activity.getActivityType()) {
                accountService.returnPoints(activity);
            }
            activity.setActivityType(ActivityType.DELETE);
            modify(activity);
            memcachedClient.delete(getPrefix() + activity.getPublisherUuid());
            memcachedClient.delete(CacheConstants.UUID_ACTIVITY + activity.getPublisherUuid());
        }

    }

       
    public List<Activity> getNormalActivityByUserId(int userId) {
        return activityDao.getNormalActivityByUserId(userId);
    }
    
    public List<Activity> getConfilctActivityByUuIdAndTime(byte[] uuid , Date startDate , Date endDate) {
        return activityDao.getConfilctActivityByUuidIdAndTime(uuid, startDate, endDate);
    }

    @Transactional(value = "points", readOnly = false)
    public int save(Activity activity) {
        // save activity
        activity.getActivityLimitRule().setActivity(activity);
        modify(activity);
        // deduction Points
        accountService.deductPoints(activity, activity.getTotalPoints(), false);
        // save pointsRule
        pointRuleService.save(activity.getPointRules(), activity.getId());
        // delete memcached othes
        memcachedClient.delete(getPrefix() + activity.getPublisherUuid());
        memcachedClient.delete(CacheConstants.UUID_ACTIVITY + activity.getPublisherUuid());
        return activity.getId();
    }
    
    @Transactional(value = "points", readOnly = false)
    public int updateActivity(Activity newActivity) {
        // deduction Points
        int points = newActivity.getIncreasePoints();
        accountService.deductPoints(newActivity, points, true);
        // update activity
        Activity activity = getActivityById(newActivity.getId());
        newActivity.setPublisherId(activity.getPublisherId());
        newActivity.setUuid(activity.getUuid());
        newActivity.setTotalPoints(activity.getTotalPoints() + points);
        newActivity.setUsedPoints(activity.getUsedPoints());

        newActivity.getActivityLimitRule().setActivity(newActivity);
        // modify(newActivity);
        activityDao.updateInfo(newActivity);

        // save points Rule
        pointRuleService.deletePointRulesByActivityId(activity.getId());
        pointRuleService.save(newActivity.getPointRules(), newActivity.getId());
        //if the activity need to finish expire this activity
        if (newActivity.isNeedFinish()) {
            processFinishActivity(newActivity);
        } else {
            // manage memcached Cache
            clear(newActivity.getId());
            memcachedClient.delete(getPrefix() + newActivity.getPublisherUuid());
            memcachedClient.delete(CacheConstants.UUID_ACTIVITY + newActivity.getPublisherUuid());
        }
        return newActivity.getId();
    }
    
    private Activity fullActivity(Activity activity) {
        if (activity == null || activity.getId() <= 0) {
            return activity;
        }
        List<PointRule> pointRules = pointRuleService.getPointRuleByActivityId(activity.getId());
        activity.setPointRules(pointRules);
        return activity;
    }
    
    public List<Activity> getFinishActivityByDate(Date day) {
        return activityDao.getFinishActivityByDate(day);
    }

    @Transactional(value = "points", readOnly = false)
    public boolean processFinishActivity(Activity a) {
        Activity activity = activityDao.read(a.getId());
        if (activity.getActivityType() != ActivityType.EXPIRED) {
            activity.setActivityType(ActivityType.EXPIRED);
            // update activity
            modify(activity);
            // return points
            accountService.returnPoints(activity);
            // if Olympic activity need to recover the special points and close
            // Olympic Activity flag
            if (ActivityCategory.OLYMPIC == a.getActivityCate()) {
                //remove it
                //closeOlympicFlag(activity.getUuidStr());
                statService.statFinish(getOlympicActivity().getId(), 1);
                if (REFUNDSPECIALFLAG) {
                    accountService.chargePoints(a.getPublisherId(), a.getUsedPoints() - a.getTotalPoints(),
                            AccountRecordType.DEDUCT, a.getName() + "回收积分");
                }
            }
            //special Activity need to Collect Points
            if (activityDao.isSpecialActivity(activity.getId())) {
                accountService.chargePoints(a.getPublisherId(), a.getUsedPoints() - a.getTotalPoints(),
                        AccountRecordType.DEDUCT, a.getName() + "回收积分");
            }
            memcachedClient.delete(getPrefix() + activity.getPublisherUuid());
            memcachedClient.delete(CacheConstants.ACCOUNT + activity.getPublisherId());
            memcachedClient.set(CacheConstants.UUID_ACTIVITY + activity.getPublisherUuid(),
                    getExpired(), "0");
        }
        return true;
    }
    
    public Activity getOlympicActivity() {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("publisherId", PUBLISHER_ID);
        param.put("uuid", new UUID(POINTS_UUID).asByteArray());
        param.put("activityCate", ActivityCategory.OLYMPIC);
        param.put("curDate", new Date());
        Activity activity = (Activity) getEntity(OLYMPIC, "Activity.getActivityByCate", param);
        return activity == null ? new Activity() : fullActivity(activity);
    }

    public boolean processStartActivity(Activity a) {
        if (ActivityType.START == a.getActivityType()) {
            changeActivityStatus(a, ActivityType.START);
        }
        return true;
    }
    //process Olympic Activity
    public void processOlympicActivity(String uuid , boolean flag) {
        Activity olympic = getOlympicActivity();
        if (olympic.getId() == 0) {
            return;
        }
        UuidSite uuidSite = uuidSiteService.getUuidSiteByUuid(uuid);
        Date current = DateUtils.truncate(new Date(), Calendar.DATE);
        Activity activity =
                new Activity(uuidSite.getUserId() , uuid , "" , olympic.getName() , olympic.getDescription() ,
                        olympic.getStartDate().before(current) ? current : olympic.getStartDate() ,
                        olympic.getEndDate() , TOTAL_POINTS , 0 , ActivityType.NOSTART ,
                        ActivityCategory.OLYMPIC);
        activity.setPic(olympic.getPic());
        activity.setPublisherSite(uuidSite.getUrl());
        activity.setPublisherName(uuidSite.getName());
        activity.setUrl(olympic.getUrl());
        for (PointRule pr : olympic.getPointRules()) {
            activity.addPointsRule(new PointRule(pr.getPointsRuleType() , pr.getNum() , pr.getPoints()));
        }
        processSpecialActivity(activity, flag, olympic.getId());
    }

    //process special Activity
    //if start, 
    //first we charge the points to publisher auto 
    //second we save the activity
    //if end
    //first finished the activity
    //return the points
    //if need recover the point recollect from publisher.
    public void processSpecialActivity(Activity special , boolean isStart , int templateId) {
        if (special == null || special.getPublisherId() == 0 || special.getStartDate() == null ||
                special.getEndDate() == null || special.getStartDate().after(special.getEndDate())) {
            return;
        }
        if (isStart) {
            startSpecialActivity(special);
            statService.statAccept(templateId, 1);
        } else {
            stopSpecialActivity(special);
            statService.statReject(templateId, 1);
        }
    }
    
    public void changeActivityStatus(Activity activity , ActivityType type) {
        activity.setActivityType(type);
        modify(activity);
        memcachedClient.delete(getPrefix() + activity.getPublisherUuid());
        memcachedClient.delete(CacheConstants.UUID_ACTIVITY + activity.getPublisherUuid());
    }
     //start Special Activity
    public void startSpecialActivity(Activity special) {
        List<Activity> currentActivitys =
                activityDao.getActivityByDateUuid(special.getPublisherId(), special.getUuid(), special.getStartDate(),
                        special.getEndDate());
        if (currentActivitys.size() == 1 && ActivityCategory.OLYMPIC == currentActivitys.get(0).getActivityCate()) {
            changeActivityStatus(currentActivitys.get(0), ActivityType.START);
        } else if (currentActivitys.size() > 1) {
            log.error("finisher Activity error, two much Activy found,pulicherId=" + special.getPublisherId());
        } else {
            saveSpecialActivity(special);
        }
        if (currentActivitys.size() == 1 && ActivityCategory.NORMAL == currentActivitys.get(0).getActivityCate()) {
            changeActivityStatus(special, ActivityType.STOP);
        }
    }   
    //stop Special Activity
    public void stopSpecialActivity(Activity special) {
        List<Activity> activitys =
                activityDao.getActivityByCate(special.getPublisherId(), special.getActivityCate(), special.getUuid(),
                        null);
        if (activitys.size() == 0) {
            log.error("finisher Activity error, no Activy found,pulicherId=" + special.getPublisherId());
            return;
        }
        changeActivityStatus(activitys.get(0), ActivityType.STOP);
    }
    
    public List<Activity> getOlympicActivitys() {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("publisherId", -1);
        param.put("uuid", "1".getBytes());
        param.put("activityCate", ActivityCategory.OLYMPIC);
        param.put("curDate", new Date());
        return getEntities(OLYMPIC_LIST, "Activity.getActivityByCate", param);
    }
    
    @Transactional(value = "points", readOnly = false)
    public void saveSpecialActivity(Activity special) {
        //if no account create the Account first
        accountService.createAccount(special.getPublisherId(), "");
        //charge the activity point to Account
        accountService.chargePoints(special.getPublisherId(), special.getTotalPoints());
        //call save activity process
        save(special);
    } 
    //close OlympicFlag
    public void closeOlympicFlag(String uuid) {
        try {
            UuidCustomization uc = uuidCustomizationServices.getUuidCustomizationByUuid(uuid);
            uc.setIsOlymPicShare(false);
            uuidCustomizationServices.updateUuidCustomizationByUuid(uuid, uc);
        } catch (Exception e) {
            log.error("close Olympic error,uuid=" + uuid, e);
        }
    }
    
    /**
     * 获取网站正在进行的活动
     * 
     * 约定：一个UUID，最多同时只能有一个活动在进行
     * 
     * @param uuid
     * @param domain
     * @return          返回对应正在进行的活动
     */
    public Activity getCurrentActivity(String uuid) {
        if (StringUtils.isEmpty(uuid)) {
            return null;
        }
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("uuid", new UUID(uuid).asByteArray());
        return fullActivity(getEntity(uuid, "Activity.getCurrentActivity", param));
    }

    public List<Activity> getActivityByDate(int userId, Date dateStart, Date dateEnd) {
        return activityDao.getActivityByDate(userId, dateStart, dateEnd);
    }

    /**
     * 扣除活动积分
     * @param activityId
     * @param points
     * @return
     */
    public boolean decrActivityPoints(int activityId , int points) {
        if (!activityDao.decrActivityPoints(activityId, points)) {
            throw new RuntimeException("decr activity points error. Activity id=" + activityId);
        }
        memcachedClient.delete(getPrefix() + activityId);
        Activity orgin = getActivityById(activityId);
        if (orgin.getLeftPoints() == 0) {
            clearOthers(activityId);
        }
        return true;
    }
    
    private static class ActivityComparator implements Comparator<Activity> {
        @Override
        public int compare(Activity activity1, Activity activity2) {
            if (activity1.getActivityType() != activity2.getActivityType()) {
                // 正常 > 未开始 > 停止 > 结束
                if (ActivityType.START == activity1.getActivityType()) {
                    return -1;
                }
                
                if (ActivityType.START == activity2.getActivityType()) {
                    return 1;
                }
                
                // 没有”正常“情况下，按照ActivityType的升序排
                return activity1.getActivityType().getCode() - activity2.getActivityType().getCode();
            } else {
                // 再按照开始时间排
                return activity2.getStartDate().compareTo(activity1.getStartDate());
            }
        }
        
    }

    public List<Activity> getStartActivityByDate(Date today) {
        return activityDao.getStartActivityByDate(today);
    }
    
    private List<Activity> getNormalActivitys(int maxResult , String suffix) {
        Map<String, Object> param = new HashMap<String, Object>();
        if (maxResult > 0) {
            param.put(ActivityDao.MAXRESULT, maxResult);
        }
        return getEntities(suffix, "Activity.getNormalActivitys", param);
    }
    
    /**First Page
     * @return
     */
    public List<Activity> getFirstThreeActivitys() {
        return getNormalActivitys(FIRST_PAGE, FIRST_THREE_A);
    }
    
    /**get the activity under product page
     * @return
     */
    public List<Activity> getProductActivitys() {
        return getNormalActivitys(PRODUCT_PAGE, PRODUCT_A);
    }
    
    //get normal Activities
    public List<Activity> getNormalActivitys() {
        return getNormalActivitys(0, NORMAL_A);
    }
    //get count Activity
    public long getCountNormalActivitys() {
        return activityDao.getCountNormalActivitys();
    }
    
    /**
     * get activity list by pagination.
     * @param pagination
     * @return
     */
    public List<Activity> getPaginationNormalActivitys(Pagination pagination) {
        return activityDao.getPaginationNormalActivitys(pagination);
    }

    /**
     * get uuid activity for button set [activityId],[domain] in memcached
     * 
     * @param uuid
     */
    public void getUuidActivity(byte[] uuidByte) {
        String uuid = StringUtil.byteArrayToUuid(uuidByte);
        String key = CacheConstants.UUID_ACTIVITY + uuid;
        String result = "";
        if (StringUtils.isEmpty((String) memcachedClient.get(key))) {
            Activity a = getCurrentActivity(uuid);
            if (a != null && a.getId() > 0) {
                result = a.getId() + "," + a.getDomain();
            } else {
                result = "0";
            }
            memcachedClient.set(key, getExpired(), result);
        }
    }
    
    public List<Integer> getSpecialActivityIds(int type) {
        return activityDao.getSpecialActivityId(type);
    }

    @Override
    public String getPrefix() {
        return CacheConstants.ACTIVITY;
    }

    @Override
    public void init() {
        setDao(activityDao);
    }
    @Override
    protected int getExpired() {
        return CacheConstants.getTillTomorrowExpireTime();
    }
}
