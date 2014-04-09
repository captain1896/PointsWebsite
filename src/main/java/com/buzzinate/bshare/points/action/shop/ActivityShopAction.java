package com.buzzinate.bshare.points.action.shop;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.core.bean.enums.PointsType;
import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ExceptionHandler;
import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.bshare.points.bean.UserPointsInfo;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.PointRecordService;
import com.buzzinate.bshare.points.service.PointsProductService;
import com.buzzinate.bshare.points.service.UserPointsPoolService;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.Pagination;
import com.opensymphony.xwork2.Action;

/**
 * to handle the activityInformation under points shop
 * @author james.chen
 * @since 2012-6-13
 */
@Controller
@Scope("request")
public class ActivityShopAction extends BaseAction {

    private static final long serialVersionUID = 2786058268747949474L;
    private static final String DEFAULT_PAGE_NO = "1";
    private static final String PAGESIZE = ConfigurationReader.getString("bshare.points.activities.perpage");
    
    @Autowired
    private ActivityService activityService;
    @Autowired
    private PointsProductService productService;
    
    private Activity activity;

    private List<PointsProduct> products;
    //Activities List Page
    private String pageNo;
    
    private Pagination pagination;
    private List<Activity> activities;
    // 用户参与活动 分享获取的积分情况
    private UserPointsInfo userPointsInfoOfShare;
    private UserPointsInfo userPointsInfoOfClickBack;
    
    @Autowired
    private PointRecordService pointRecordService;
    @Autowired
    private UserPointsPoolService userPointsPoolService;
    
    private ExceptionHandler handler = new ExceptionHandler(getText("bshare.shop.exception.activity.title") ,
            getText("bshare.shop.exception.activity.error") , "shop/activities");
    private String id;
    
    public String activity() {
        if (!StringUtils.isNumeric(id)) {
            return ERROR;
        }
        activity = activityService.getActivityById(Integer.valueOf(id));
        if (activity == null || activity.getId() == 0) {
            return ERROR;
        }
        // 获取用户参与该活动获取的积分情况
        userPointsInfoOfShare = getUserPointsInfo(activity, PointsType.SHARE);
        userPointsInfoOfClickBack = getUserPointsInfo(activity, PointsType.CLICKBACK);
        products = productService.getProductsActivity();
        return SUCCESS;
    }
    
    /**
     * 用户参加该活动获取的积分情况
     */
    private UserPointsInfo getUserPointsInfo(Activity currentActivity, PointsType pointsType) {
        Integer activityId = currentActivity.getId();
        int userId = getCurrentUserId();
        UserPointsInfo userPointsInfo = new UserPointsInfo(userId, activityId, pointsType);

        PointRule pointRule = currentActivity.getPointRule(PointsRuleType.valueOf(pointsType));
        if (pointRule != null) {
            // 分享或回流规则定义的次数
            userPointsInfo.setPointRuleCount(pointRule.getNum());

            // 目前分享或回流的积分
            int totalPoints = pointRecordService.getTotalPointsByPointsType(userId, activityId, pointsType);
            userPointsInfo.setTotalPoints(totalPoints);
            // 已分享或回流的次数
            int count = userPointsPoolService.getCount(userId, activityId, pointRule.getPointsRuleType().getCode());
            userPointsInfo.setCount(count);
        }
        return userPointsInfo;
    }
    
    /**get all normal activities
     * @return
     */
    public String activities() {
        pagination =
                new Pagination(Integer.valueOf(getPageNo()) , activityService.getCountNormalActivitys() ,
                        Integer.valueOf(PAGESIZE));
        activities = activityService.getPaginationNormalActivitys(pagination);
        return Action.SUCCESS;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public void setActivities(List<Activity> activities) {
        this.activities = activities;
    }

    public String getPageNo() {    
        if (pageNo == null || pageNo.isEmpty() || !StringUtils.isNumeric(pageNo)) {
            pageNo = DEFAULT_PAGE_NO;
        }
        return pageNo;
    }

    public void setPageNo(String pageNo) {
        this.pageNo = pageNo;
    }

    public Pagination getPagination() {
        return pagination;
    }

    public void setPagination(Pagination pagination) {
        this.pagination = pagination;
    }

    public ExceptionHandler getHandler() {
        return handler;
    }

    public void setHandler(ExceptionHandler handler) {
        this.handler = handler;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<PointsProduct> getProducts() {
        return products;
    }

    public UserPointsInfo getUserPointsInfoOfShare() {
        return userPointsInfoOfShare;
    }

    public void setUserPointsInfoOfShare(UserPointsInfo userPointsInfoOfShare) {
        this.userPointsInfoOfShare = userPointsInfoOfShare;
    }

    public UserPointsInfo getUserPointsInfoOfClickBack() {
        return userPointsInfoOfClickBack;
    }

    public void setUserPointsInfoOfClickBack(UserPointsInfo userPointsInfoOfClickBack) {
        this.userPointsInfoOfClickBack = userPointsInfoOfClickBack;
    }
    
}
