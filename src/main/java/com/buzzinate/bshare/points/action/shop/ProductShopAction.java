package com.buzzinate.bshare.points.action.shop;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ExceptionHandler;
import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.bshare.points.bean.PointsUser;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.PointsProductService;
import com.buzzinate.bshare.points.service.PointsUserService;
import com.opensymphony.xwork2.Action;

/**
 * handle all product information under points shop
 * @author james.chen
 * @since 2012-6-13
 */
@Controller
@Scope("request")
public class ProductShopAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = -2149486280910284298L;
    
    @Autowired
    private PointsProductService productService;
    
    @Autowired
    private ActivityService activityService;
    
    @Autowired
    private PointsUserService pointsUserService;
    //first Three activity
    private List<Activity> activities;
    //the product description in shops
    private PointsProduct product;
    //the id parameter
    private String  id;
    private PointsUser pointsUser;
    //exception handler
    private ExceptionHandler handler = new ExceptionHandler(getText("bshare.shop.exception.product.title") ,
            getText("bshare.shop.exception.product.error") , "shop");
    
    
    public String product() {
        if (!StringUtils.isNumeric(id)) {
            return Action.ERROR;
        }
        product = productService.getProductById(Integer.valueOf(id));
        if (product == null || product.validate()) {
            return Action.ERROR;
        }
        if (getCurrentUserId() > 0) {
            pointsUser = pointsUserService.getPointsByUserId(getCurrentUserId());
        }
        activities = activityService.getProductActivitys();
        return Action.SUCCESS;
    }

    public PointsProduct getProduct() {
        return product;
    }

    public void setProduct(PointsProduct pointsProduct) {
        this.product = pointsProduct;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public void setActivities(List<Activity> activities) {
        this.activities = activities;
    }

    public PointsUser getPointsUser() {
        return pointsUser;
    }

    public void setPointsUser(PointsUser pointsUser) {
        this.pointsUser = pointsUser;
    }

    public ExceptionHandler getHandler() {
        return handler;
    }

    public void setHandler(ExceptionHandler handler) {
        this.handler = handler;
    }
}
