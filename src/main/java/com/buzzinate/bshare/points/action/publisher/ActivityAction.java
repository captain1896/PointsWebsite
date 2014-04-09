package com.buzzinate.bshare.points.action.publisher;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.core.bean.UuidSite;
import com.buzzinate.bshare.core.bean.cache.UuidCacheInfo;
import com.buzzinate.bshare.core.cache.UuidSiteCache;
import com.buzzinate.bshare.core.service.UuidSiteServices;
import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Account;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ActivityLimitRule;
import com.buzzinate.bshare.points.bean.PointRecord;
import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.enums.ActivityCategory;
import com.buzzinate.bshare.points.bean.enums.ActivityType;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.bshare.points.service.AccountService;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.PointRecordService;
import com.buzzinate.bshare.points.service.PointRuleService;
import com.buzzinate.bshare.points.service.UserPointsPoolService;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.DateTimeUtil;
import com.opensymphony.xwork2.Action;

/**
 * 活动CRUD Controller
 * 
 * @author Martin Zhou
 * 
 */
@Controller
@Scope("request")
public class ActivityAction extends BaseAction {

    private static final long serialVersionUID = 8500476685192287649L;

    private static final int POUNDAGE_RATE = ConfigurationReader.getInt("bshare.points.poundage.rate", 12);

    @Autowired
    private UuidSiteServices uuidSiteServices;
    @Autowired
    private ActivityService activityService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private PointRuleService pointRuleService;
    @Autowired
    private PointRecordService pointRecordService;
    @Autowired
    private UserPointsPoolService userPointsPoolService;

    private List<Activity> activities;
    private Activity activity;
    private Account account;

    private int id;
    private String today;
    private String limitDay;
    private String minDay;

    private List<PointRecord> pointRecords;

    @Autowired
    private UuidSiteCache uuidSiteCache;

    // 积分规则
    private List<PointRule> pointRules;
    // 积分规则JSON格式，用于和前台交互
    private String rulesAsJson = "[]";

    /**
     * 活动列表页面
     * 
     * @return
     */
    public String list() {
        activities = activityService.getActivityByUserId(loginHelper.getUserId());
        request.setAttribute("poundage", (POUNDAGE_RATE + 100) / 100.0);
        request.setAttribute("poundageValue", POUNDAGE_RATE);
        request.setAttribute("uuidSize", uuidSiteServices.getUuidSiteByUserId(getCurrentUserId()).size());
        return Action.SUCCESS;
    }

    /**
     * 新建活动页面
     * 
     * @return
     */
    public String add() {
        if (uuidSiteServices.getUuidSiteByUserId(getCurrentUserId()).size() < 1) {
            addActionError(getText("bshare.points.activity.nouuid"));
            return Action.ERROR;
        }
        account = accountService.findAccount(getCurrentUserId());
        activity = new Activity();
        activity.setPublisherName(loginHelper.getUserName());
        init();
        return Action.SUCCESS;
    }

    /**
     * 保存新活动
     * 
     * @return
     */
    public String save() {
        // 根据界面输入，构造新活动
        validateNewActivity();

        if (hasErrors()) {
            initSiteSelector();
            return Action.ERROR;
        }

        constructNewActivity();
        int res = activityService.save(activity);
        if (res <= 0) {
            initSiteSelector();
            addActionError(getText("bshare.points.not.enough.activity.fail"));
            return Action.ERROR;
        }
        return Action.SUCCESS;
    }

    /**
     * 编辑活动页面
     * 
     * @return
     */
    public String edit() {
        account = accountService.findAccount(getCurrentUserId());
        activity = getAndWrapperActivity(id);
        
        // 编辑的活动已经被删除
        if (activity == null) {
            addActionError(getText("bshare.points.update.activity.delete"));
            return "list";
        }
        activity.setUsed(userPointsPoolService.isExistsCount(id));
        if (getCurrentUserId() == activity.getPublisherId() && activity.getActivityType() != ActivityType.EXPIRED &&
                activity.getActivityCate() == ActivityCategory.NORMAL) {
            // 积分规则
            pointRules = pointRuleService.getPointRuleByActivityId(activity.getId());

            init();
            setUuidSiteDesc(activity.getPublisherUuid());
            return Action.SUCCESS;
        } else {
            addActionError(getText("bshare.points.operation.unauthorized"));
            return Action.ERROR;
        }
    }

    /**
     * 更新活动
     * 
     * @return
     */
    public String update() {
        
        if (activity.getId() <= 0) {
            addActionError(getText("bshare.points.operation.unauthorized"));
            return returnError();
        }
        // 更新的活动已经被删除
        if (activityService.get(activity.getId()) == null) {
            addActionError(getText("bshare.points.update.activity.delete"));
            return "activityManage";
        }
        // 更新的活动已经被删除
        if (activityService.get(activity.getId()) == null) {
            addActionError(getText("bshare.points.update.activity.delete"));
            return "list";
        }

        validateUpdateActivity();
        if (hasErrors()) {
            return returnError();
        }

        // 构造更新的Activity
        constructUpdateActivity();

        activityService.updateActivity(activity);
        return Action.SUCCESS;
    }

    /**
     * 预览
     * 
     * @return
     */
    public String preview() {
        if (activity.getId() <= 0) {
            // 新建活动
            constructNewActivity();
        } else {
            // 更新活动
            constructUpdateActivity();
            Activity current = activityService.getActivityById(activity.getId());
            activity.setTotalPoints(current.getTotalPoints() + activity.getIncreasePoints());
        }
        return Action.SUCCESS;
    }

    /**
     * 构造新的活动内容
     */
    private void constructNewActivity() {
        activity.setPublisherId(getCurrentUserId());
        activity.setTotalPoints(activity.getTotalPoints() * 100);
        // 积分规则
        constructPointAndLimitRules(activity);
    }

    private boolean validateNewActivity() {
        if (!validateUuid(activity.getPublisherUuid())) {
            return false;
        }

        account = accountService.findAccount(loginHelper.getUserId());
        int increasePoints = activity.getTotalPoints();
        if (increasePoints > account.getCurrentPoints()) {
            addActionError(getText("bshare.points.not.enough.activity.fail"));
            return false;
        }
        if (increasePoints <= 0) {
            addActionError(getText("bshare.total.point.activity.fail"));
            return false;
        }
        if (!activity.isStop()) {
            activities =
                    activityService.getConfilctActivityByUuIdAndTime(activity.getUuid(), activity.getStartDate(),
                            activity.getEndDate());
            if (activities.size() > 0) {
                initDateRange();
                addActionError(getText("bshare.conflict.activity.fail"));
                return false;
            }
        }
        return true;
    }

    private boolean validateUuid(String publisherUuid) {
        UuidCacheInfo uuidCacheInfo = uuidSiteCache.getUuidCacheInfo(publisherUuid);
        if (uuidCacheInfo == null || uuidCacheInfo.getUserId() != getCurrentUserId()) {
            addActionError(getText("bshare.points.activity.uuid.invalid"));
            return false;
        }
        return true;
    }

    private void validateUpdateActivity() {
        int userId = getCurrentUserId();
        account = accountService.findAccount(userId);
        if (activity.getIncreasePoints() < 0) {
            addActionError(getText("bshare.total.point.activity.fail"));
            return;
        }
        // check this activity belong to this user
        if (activity == null || activity.getPublisherId() != userId) {
            addActionError(getText("bshare.points.operation.unauthorized"));
            return;
        }
        if (!activity.isStop()) {
            activities = activityService.getConfilctActivityByUuIdAndTime(activity.getUuid(), activity.getStartDate(),
                            activity.getEndDate());
            for (Activity confilct : activities) {
                if (!confilct.getId().equals(activity.getId())) {
                    request.setAttribute("update", "confilct");
                    addActionError(getText("bshare.conflict.activity.fail"));
                    return;
                }
            }
        }
    }

    /**
     * 构造更新后的活动内容
     */
    private void constructUpdateActivity() {
        activity.setPublisherId(getCurrentUserId());
        // totalPoints更新时是新增积分数
        activity.setIncreasePoints(activity.getIncreasePoints() * 100);
        // 积分规则
        constructPointAndLimitRules(activity);
    }

    /**
     * 初始化站长的网站列表
     */
    private void initSiteSelector() {
        List<UuidSite> uuidSites = uuidSiteServices.getUuidSiteByUserId(loginHelper.getUserID());
        request.setAttribute("siteSelector", uuidSiteServices.getUuidSiteSelector(uuidSites, ""));
    }


    private void setUuidSiteDesc(String siteUuid) {
        UuidSite uuidSite = uuidSiteServices.getUuidSiteByUuid(siteUuid);
        String uuidSiteDesc = uuidSiteServices.getUuidSiteDesc(uuidSite);
        request.setAttribute("uuidSiteDesc", uuidSiteDesc);
    }

    /**
     * 构造积分规则和限制规则 注意：保存之前，先确认Validate是否OK
     * 
     * @return
     */
    private void constructPointAndLimitRules(Activity currentActivity) {
        try {
            pointRules = parsePointRuleFromJson(rulesAsJson);

            // if exist this rule, then update it
            if (validatePointRule(pointRules)) {
                currentActivity.setPointRules(pointRules);
                ActivityLimitRule limitRule = constructLimitRule(pointRules, currentActivity.getActivityLimitRule());
                limitRule.setDomain(currentActivity.getDomain());
                currentActivity.setActivityLimitRule(limitRule);
            }
        } catch (Exception e) {
            addActionError(getText("bshare.points.rules.error"));
            return;
        }
    }

    private ActivityLimitRule constructLimitRule(List<PointRule> currentPointRules , ActivityLimitRule limitRule) {
        if (limitRule == null) {
            limitRule = new ActivityLimitRule();
        }

        PointRule sharePointRule = getPointRule(currentPointRules, PointsRuleType.SHARE);
        PointRule clickBackPointRule = getPointRule(currentPointRules, PointsRuleType.CLICKBACK);

        if (sharePointRule != null && sharePointRule.getLimitPoints() > 0) {
            limitRule.setShareLimitNo(sharePointRule.getLimitPoints());
        }

        if (clickBackPointRule != null && clickBackPointRule.getLimitPoints() > 0) {
            limitRule.setClickBackLimitNo(clickBackPointRule.getLimitPoints());
        }
        return limitRule;
    }

    private PointRule getPointRule(List<PointRule> currentPointRules , PointsRuleType pointRuleType) {
        if (currentPointRules == null || currentPointRules.isEmpty()) {
            return null;
        }

        for (PointRule pointRule : currentPointRules) {
            if (pointRule.getPointsRuleType().equals(pointRuleType)) {
                return pointRule;
            }
        }
        return null;
    }

    /**
     * validte point rules
     * 
     * @param rules
     * @return
     */
    private boolean validatePointRule(List<PointRule> rules) {
        if (rules == null || rules.isEmpty()) {
            addActionError(getText("bshare.points.rules.isempty"));
            return false;
        }

        for (PointRule pointRule : rules) {
            if (pointRule.getNum() <= 0) {
                addActionError(getText("bshare.points.rules.mustbe.positive", "分享或回流次数"));
                return false;
            }

            if (pointRule.getPoints() <= 0) {
                addActionError(getText("bshare.points.rules.mustbe.positive", "获取积分数"));
                return false;
            }
        }
        return true;
    }

    /**
     * delete activity
     * 
     * @return
     */
    public String delete() {
        if (loginHelper.isLoginAsPointsPublisher()) {
            activity = activityService.getActivityById(id);
            if (activity != null && activity.getPublisherId() == loginHelper.getUserID()) {
                if (!activity.isDelete()) {
                    addActionMessage(getText("bshare.delete.activity.fail"));
                    return Action.ERROR;
                }
                activityService.deleteActivityById(id);
            } else {
                addActionMessage(getText("bshare.points.operation.unauthorized"));
                return Action.ERROR;
            }
        }
        addActionMessage(getText("bshare.delete.activity.success"));
        return Action.SUCCESS;
    }
    
    public String finish() {
        if (loginHelper.isLoginAsPointsPublisher()) {
            activity = activityService.getActivityById(id);
            if (activity != null && activity.getPublisherId() == loginHelper.getUserID()) {
                if (!activity.isFinish()) {
                    addActionMessage(getText("bshare.finish.activity.fail"));
                    return Action.ERROR;
                }
                activityService.processFinishActivity(activity);
            } else {
                addActionMessage(getText("bshare.points.operation.unauthorized"));
                return Action.ERROR;
            }
        }
        addActionMessage(getText("bshare.finish.activity.success"));
        return Action.SUCCESS;
    }

    private void initDateRange() {
        Date currentDate = DateTimeUtil.getCurrentDateDay();
        today = DateTimeUtil.formatDate(currentDate);
        minDay = today;
        if (activity != null && (activity.getStartDate() == null && activity.getEndDate() == null)) {
            Date startDateDay = DateTimeUtil.plusDays(currentDate, 1);
            Date endDateDay = DateTimeUtil.plusDays(currentDate, 8);
            activity.setStartDate(startDateDay);
            activity.setEndDate(endDateDay);

        }

        if (activity.getStartDate().after(DateTimeUtil.getCurrentDateDay())) {
            minDay = activity.getStartDateStr();
        }
        limitDay = DateTimeUtil.formatDate(DateTimeUtil.plusMonths(currentDate, 12));
    }

    /**
     * 查看活动的积分记录
     * 
     * @return
     */
    public String pointRecords() {
        activity = getAndWrapperActivity(id);
        if (loginHelper.getUserID() == activity.getPublisherId()) {
            pointRecords = pointRecordService.getPointRecordsByActivityId(id);
        } else {
            addActionError(getText("bshare.points.operation.unauthorized"));
            return Action.ERROR;
        }
        return SUCCESS;
    }

    /**
     * 把积分规则的限制封装到PointRule中供显示用
     */
    private Activity getAndWrapperActivity(int activityId) {
        activity = activityService.getActivityById(activityId);

        if (activity == null) {
            return null;
        }
        ActivityLimitRule activityLimitRule = activity.getActivityLimitRule();

        if (activityLimitRule != null) {
            int shareLimitNo = activityLimitRule.getShareLimitNo();
            if (shareLimitNo > 0) {
                PointRule sharePointRule = activity.getPointRule(PointsRuleType.SHARE);
                sharePointRule.setLimitPoints(shareLimitNo);
            }

            int clickBackLimitNo = activityLimitRule.getClickBackLimitNo();
            if (clickBackLimitNo > 0) {
                PointRule clickPointRule = activity.getPointRule(PointsRuleType.CLICKBACK);
                clickPointRule.setLimitPoints(clickBackLimitNo);
            }
        }

        rulesAsJson = convertPointRuleToJson(activity.getPointRules());
        return activity;
    }

    private String convertPointRuleToJson(List<PointRule> currentPointRules) {
        if (currentPointRules == null || currentPointRules.isEmpty()) {
            return "{}";
        }

        JSONArray array = new JSONArray();
        for (PointRule pointRule : currentPointRules) {
            JSONObject object = new JSONObject();
            object.put("id", pointRule.getId());
            object.put("activityId", pointRule.getActivityId());
            object.put("pointsRuleType", String.valueOf(pointRule.getPointsRuleType()));
            object.put("num", pointRule.getNum());
            object.put("points", pointRule.getPoints());
            if (pointRule.isProductRule()) {
                object.put("rewardType", "product");
            } else {
                object.put("rewardType", "points");
            }
            object.put("limitPoints", pointRule.getLimitPoints());
            array.add(object);
        }
        return array.toJSONString();
    }

    private List<PointRule> parsePointRuleFromJson(String json) {
        JSONArray array = (JSONArray) JSONValue.parse(json);
        List<PointRule> newPointRules = new ArrayList<PointRule>();
        for (Object object : array) {
            JSONObject jsonObject = (JSONObject) object;
            PointRule pointRule = new PointRule();
            Object activityId = jsonObject.get("activityId");
            if (activityId != null) {
                pointRule.setActivityId(Integer.parseInt(activityId.toString()));
            }
            pointRule.setPointsRuleType(PointsRuleType.valueOf((String) jsonObject.get("pointsRuleType")));
            pointRule.setNum(Integer.parseInt(jsonObject.get("num").toString()));
            pointRule.setPoints(Integer.parseInt(jsonObject.get("points").toString()));
            pointRule.setLimitPoints(Integer.parseInt(jsonObject.get("limitPoints").toString()));

            newPointRules.add(pointRule);
        }
        return newPointRules;
    }

    private String returnError() {
        init();
        return Action.ERROR;
    }

    private void init() {
        initDateRange();
        initSiteSelector();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public String getToday() {
        return today;
    }

    public void setToday(String today) {
        this.today = today;
    }

    public String getLimitDay() {
        return limitDay;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public List<PointRecord> getPointRecords() {
        return pointRecords;
    }

    public String getMinDay() {
        return minDay;
    }

    public void setMinDay(String minDay) {
        this.minDay = minDay;
    }

    public List<PointRule> getPointRules() {
        return pointRules;
    }

    public void setPointRules(List<PointRule> pointRules) {
        this.pointRules = pointRules;
    }

    public String getRulesAsJson() {
        return rulesAsJson;
    }

    public void setRulesAsJson(String rulesAsJson) {
        this.rulesAsJson = rulesAsJson;
    }    
}
