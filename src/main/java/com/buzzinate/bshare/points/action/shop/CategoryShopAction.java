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
import com.buzzinate.bshare.points.bean.ProductCategory;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.PointsProductService;
import com.buzzinate.bshare.points.service.ProductCategoryService;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.Pagination;
import com.opensymphony.xwork2.Action;

/**
 * product category Shop display product page
 * @author james.chen
 * @since 2012-6-28
 */
@Controller
@Scope("request")
public class CategoryShopAction extends BaseAction {

    private static final long serialVersionUID = -2956857681221715666L;
    
    private static final String DEFAULT_PAGE_NO = "1";
    private static final int PAGE_SIZE = ConfigurationReader.getInt("bshare.points.category_product.num");

    @Autowired
    private PointsProductService productService;
    
    @Autowired
    private ProductCategoryService categoryService;
    
    @Autowired
    private ActivityService activityService;
    //activities in Product Category display page
    private List<Activity> activities;
    //product Category
    private List<ProductCategory> categories;
    //products
    private List<PointsProduct> products;
    //categoryId
    private String categoryId;
    //category
    private ProductCategory category;
    //pagination
    private Pagination pagination;
    //pagNo
    private String pageNo;
  //exception handler
    private ExceptionHandler handler = new ExceptionHandler(getText("bshare.shop.exception.productCategory.title") ,
            getText("bshare.shop.exception.productCategory.error") , "shop");
    
    public String productCategory() {
        if (category == null || StringUtils.isBlank(category.getNameEn())) {
            return ERROR;
        }
        //category
        category = categoryService.getCategoryByName(category.getNameEn());
        if (category == null || category.getId() == 0) {
            return ERROR;
        }
        categoryId = "" + category.getId();
        //product info
        pagination =
                new Pagination(Integer.valueOf(getPageNo()) , productService.getProdutsByCateCount(category.getId()) ,
                        PAGE_SIZE);
        products = productService.getProdutsByCatePagination(category.getId(), pagination);
        //category info
        categories = categoryService.getAllWithProduct();
        
        //activities
        activities = activityService.getProductActivitys();
        return Action.SUCCESS;
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public Pagination getPagination() {
        return pagination;
    }

    public String getPageNo() {
        if (pageNo == null || pageNo.isEmpty() || !StringUtils.isNumeric(pageNo)) {
            pageNo = DEFAULT_PAGE_NO;
        }
        return pageNo;
    }

    public ExceptionHandler getHandler() {
        return handler;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public void setPageNo(String pageNo) {
        this.pageNo = pageNo;
    }

    public List<ProductCategory> getCategories() {
        return categories;
    }

    public List<PointsProduct> getProducts() {
        return products;
    }

    public ProductCategory getCategory() {
        return category;
    }

    public void setCategory(ProductCategory category) {
        this.category = category;
    }
}
