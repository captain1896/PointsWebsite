package com.buzzinate.bshare.points.action.user;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.Order;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.OrderService;
import com.buzzinate.common.util.Pagination;

/**
 * this product handle user order information
 * @author james.chen
 * @since 2012-6-14
 */
@Controller
@Scope("request")
public class UserOrderAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = -5462108810638789457L;
    private static final String DEFAULT_PAGE_NO = "1";
    private static final int DEFAULT_PAGE_SIZE = 10;
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private ActivityService activityService;
    
    private List<Order> orders;
    
    private List<Activity> activities;
    
    private String pageNo;
    
    private Pagination pagination;
    
    /**
     * get userOrders
     * @return
     */
    public String userOrders() {
        int userId = getCurrentUserId();
        if (userId > 0) {
            pagination =
                    new Pagination(Integer.valueOf(getPageNo()) , orderService.getOrdersByUserIdCount(userId) ,
                            DEFAULT_PAGE_SIZE);
            orders = orderService.getOrdersByUserIdPagination(userId, pagination);
            activities = activityService.getFirstThreeActivitys();
        }
        return SUCCESS;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
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
}
