package com.buzzinate.bshare.points.action.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.ExceptionHandler;
import com.buzzinate.bshare.points.bean.Order;
import com.buzzinate.bshare.points.bean.enums.OrderStatus;
import com.buzzinate.bshare.points.service.OrderService;
import com.buzzinate.common.util.Pagination;
/**
 * this action handle the admin Orders change status
 * @author james.chen
 * @since 2012-6-27
 */
@Controller
@Scope("request")
public class AdminOrderAction extends BaseAction {

    private static final long serialVersionUID = 5948882899505025529L;
    private static final String DEFAULT_PAGE_NO = "1";
    private static final int DEFAULT_PAGE_SIZE = 10;
    
    @Autowired
    private OrderService orderService;
    //below parameter for page
    //page sequence pagination
    private Pagination pagination;
    //pageNo
    private String pageNo;
    
    private List<Order> orders;
    //orderStatus
    private Map<Integer, String> orderMap;
    
    private ExceptionHandler handler = new ExceptionHandler(
            getText("bshare.shop.exception.unauthorized.title") , getText("bshare.shop.exception.unauthorized.error") ,
            "");
    
    //below parameter for update
    private int[] orderId;
    private int orderStatus;
    private String isNext;
    
    //list orders
    public String orders() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            return ERROR;
        }
        pagination =
                new Pagination(Integer.valueOf(getPageNo()) , orderService.getOrdersCount(orderStatus) ,
                        DEFAULT_PAGE_SIZE);
        orders = orderService.getPaginationOrders(pagination, orderStatus);
        orderMap = getStatus();
        return SUCCESS;
    }
    //update
    public String updateOrders() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            return ERROR;
        }
        for (int i = 0; i < orderId.length; i++) {
            OrderStatus newStatus = null;
            if ("Y".equals(isNext)) {
                newStatus =
                        OrderStatus.getCurrent(Integer.valueOf(request.getParameter("oldStatus" + orderId[i])))
                                .getNext();
            } else {
                newStatus = OrderStatus.getCurrent(orderStatus);
            }
            if (newStatus != null) {
                orderService.updateOrderStatus(orderId[i], newStatus);
            }
        }
        return SUCCESS;
    }
    
    private Map<Integer, String> getStatus() {
        Map<Integer, String> status = new HashMap<Integer, String>();
        for (OrderStatus os : OrderStatus.values()) {
            status.put(os.getCode(), getText("bshare.shop.order.orderstatus" + os.getCode()));
        }
        return status;
    }
    public Pagination getPagination() {
        return pagination;
    }

    public void setPagination(Pagination pagination) {
        this.pagination = pagination;
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

    public List<Order> getOrders() {
        return orders;
    }
    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }
    public Map<Integer, String> getOrderMap() {
        return orderMap;
    }
    public void setOrderMap(Map<Integer, String> orderMap) {
        this.orderMap = orderMap;
    }
    public int[] getOrderId() {
        return orderId;
    }
    public void setOrderId(int[] orderId) {
        this.orderId = orderId;
    }
    public ExceptionHandler getHandler() {
        return handler;
    }
    public String getIsNext() {
        return isNext;
    }
    public void setIsNext(String isNext) {
        this.isNext = isNext;
    }
    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }
    public int getOrderStatus() {
        return orderStatus;
    }
}
