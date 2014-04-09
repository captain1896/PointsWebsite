package com.buzzinate.bshare.points.action.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.PointsProductService;
import com.buzzinate.common.util.ConfigurationReader;

/**
 * @author james.chen
 * @since 2012-7-24
 */
@Controller
@Scope("request")
public class OlympicAction extends BaseAction {
    
    private static final long serialVersionUID = -7716674526486008459L;
    private static final int PRODUCT_NUM_OLYMPIC = ConfigurationReader.getInt("bshare.points.product.olympic.num");
    @Autowired
    private PointsProductService productService;
    
    @Autowired
    private ActivityService activityService;
    //activity of all Olympic
    private List<Activity> activities;
    //fourProducts
    private List<PointsProduct> products;
    //allProduct
    private List<PointsProduct> allProducts;
    
    
    public String list() {
        activities = activityService.getOlympicActivitys();
        products = productService.getProductsOnSale(PRODUCT_NUM_OLYMPIC);
        allProducts = productService.getProductsOnSale(-1);
        return SUCCESS;
    }
    
    public List<Activity> getActivities() {
        return activities;
    }

    public List<PointsProduct> getProducts() {
        return products;
    }

    public List<PointsProduct> getAllProducts() {
        return allProducts;
    }
}
