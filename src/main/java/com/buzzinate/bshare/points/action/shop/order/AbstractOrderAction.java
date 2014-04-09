package com.buzzinate.bshare.points.action.shop.order;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ExceptionHandler;
import com.buzzinate.bshare.points.bean.Order;
import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.bshare.points.bean.PointsUser;
import com.buzzinate.bshare.points.bean.enums.OrderStatus;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.OrderService;
import com.buzzinate.bshare.points.service.PointsProductService;
import com.buzzinate.bshare.points.service.PointsUserService;
import com.buzzinate.bshare.points.util.RandomUtils;
import com.buzzinate.common.util.JsonResults;

/**
 * AbstractOrderAction
 * 
 * @author james.chen
 * @since 2012-7-21
 */
public abstract class AbstractOrderAction extends BaseAction {
    
    public static final String ORDERPRODUCT = "orderProduct";
    public static final String ORDERPRODUCTJS = "orderProductJs";
    public static final String ORDERCONFIRM = "orderConfirm";
    private static final long serialVersionUID = -7646767891141918936L;

    private static Log log = LogFactory.getLog(OrderAction.class);

    
    @Autowired
    protected OrderService orderService;
    @Autowired
    protected PointsProductService productService;
    @Autowired
    protected PointsUserService pointUserService;
    @Autowired
    protected ActivityService activityService;

    protected Order order;
    // the product description in shops
    protected PointsProduct product;
    // point user
    protected PointsUser pointsUser;
    // ajax object JsonResult
    protected JsonResults results;
    // currentMethod
    protected String currentMethod = ORDERPRODUCT;
    // exception handler.
    protected ExceptionHandler handler = new ExceptionHandler(getText("bshare.shop.exception.order.title") ,
            getText("bshare.shop.order.illegalsystem") , "");
    protected List<Activity> activities;

    protected String redirectUrl;

    public String orderProduct() {
        try {
            if (order == null || order.getProductId() == 0) {
                handler.setErrorInfo(getText("bshare.shop.order.illegalparameter"));
                return ERROR;
            }
            // fillValue
            fill();
            // validate
            String error = validateMessage();
            if (StringUtils.isNotBlank(error) && !getText("bshare.shop.pointsorder.nouseraccount").equals(error)) {
                return handError(error);
            }
            activities = activityService.getProductActivitys();
        } catch (Exception e) {
            log.error("illegalSystem error", e);
            return ERROR;
        }
        return SUCCESS;
    }
    
    // confirm Order
    public String orderConfirm() {
        try {
            currentMethod = ORDERCONFIRM;
            if (order == null || order.getProductId() == 0) {
                handler.setErrorInfo(getText("bshare.shop.order.illegalparameter"));
                return ERROR;
            }
            // fillValue
            fill();
            // store contact info again
            storeOthers();
            // validate
            String error = validateMessage();
            if (StringUtils.isNotBlank(error)) {
                handler.setErrorInfo(error);
                return ERROR;
            }
            // handle order();
            handlerOrder();
        } catch (Exception e) {
            log.error("illegalSystem error", e);
            return ERROR;
        }
        return SUCCESS;
    }

    /**
     * validate the product by JS
     */
    public String orderProductJs() {
        currentMethod = ORDERPRODUCTJS;
        results = new JsonResults();
        if (order == null || order.getProductId() == 0) {
            results.addContent("message", getText("bshare.shop.order.illegalparameter"));
            results.fail();
            return JsonResults.JSON_RESULT_NAME;
        }
        // fill the value
        fill();
        try {
            storeOthers();
            String message = validateMessage();
            if (StringUtils.isNotBlank(message)) {
                results.addContent("message", message);
                results.fail();
            }
        } catch (Exception e) {
            log.error("orderProductJs error", e);
            results.setMessage("get baseinfo error");
            results.fail();
        }
        return JsonResults.JSON_RESULT_NAME;
    }

    /**
     * fill the order Object include order Product
     */
    private void fill() {
        order.setUserId(getCurrentUserId());
        product = productService.getProductById(order.getProductId());
        pointsUser = pointsUser == null ? new PointsUser() : pointsUser;
        pointsUser.setUserId(getCurrentUserId());
        if (StringUtils.isBlank(order.getOrderNo())) {
            order.setOrderNo(RandomUtils.genOrderNo());
        }
        order.setOrderTime(new Date());
        order.setOrderStatus(OrderStatus.WAITING);
        PointsUser currentUser = pointUserService.getPointsByUserId(order.getUserId());
        pointsUser.setPoints(currentUser.getPoints());
        // set contact info or points user account info
        fillOthers();
    }

    private String validateMessage() {
        // login error
        if (!loginHelper.isLoginAsUser()) {
            return getText("bshare.points.permission.unauthorized");
        }
        if (order.getProductId() == 0 || order.getUserId() == 0) {
            // illegal parameter
            return getText("bshare.shop.order.illegalparameter");
        }
        if (product == null || product.validate()) {
            // illegal product
            return getText("bshare.shop.order.illegalproduct");
        }

        if (order.getProdNum() == 0) {
            order.setProdNum(1);
        }
        // validate other informations
        // different order will validate by theirself
        String others = validateOthers();
        if (StringUtils.isNotBlank(others)) {
            return others;
        }
        // will use later
        if (product.isLimit() && product.getStoreNum() < order.getProdNum()) {
            // not enough
            return getText("bshare.shop.order.noproduct");
        }
        if (pointsUser.getPoints() < order.getOrderPoints()) {
            // not enough points
            List<Integer> params = new ArrayList<Integer>();
            params.add(order.getOrderPoints());
            params.add(pointsUser.getPoints());
            return getText("bshare.shop.order.pointsnotenough", params);
        }
        return "";
    }

    /**
     * 处理错误情况
     * 
     * @param error
     * @return
     */
    protected String handError(String error) {
        handler.setErrorInfo(error);
        return ERROR;
    }
    
    /**
     * this method is to fill the other info in Order by related Product for
     * normal order only store contact address
     */
    public abstract void fillOthers();

    /**
     * this method is to validate other information for normal order ,we will
     * validate whether the contact is correct and user must store the
     * 
     * @return
     */
    protected String validateOthers() {
        return "";
    }

    /**
     * need to store the information in the middle
     */
    protected void storeOthers() {
    }

    /**
     * the handler information after store Order
     */
    public abstract void handlerOrder();

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public PointsProduct getProduct() {
        return product;
    }

    public void setProduct(PointsProduct product) {
        this.product = product;
    }

    public PointsUser getPointsUser() {
        return pointsUser;
    }

    public void setPointsUser(PointsUser pointsUser) {
        this.pointsUser = pointsUser;
    }

    public JsonResults getResults() {
        return results;
    }

    public void setResults(JsonResults results) {
        this.results = results;
    }

    public ExceptionHandler getHandler() {
        return handler;
    }

    public void setHandler(ExceptionHandler handler) {
        this.handler = handler;
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }
    
}
