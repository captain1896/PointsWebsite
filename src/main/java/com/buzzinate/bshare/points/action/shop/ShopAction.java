package com.buzzinate.bshare.points.action.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.core.constant.UserConstants;
import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Account;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.bshare.points.bean.PointsUser;
import com.buzzinate.bshare.points.bean.PointsUserAccount;
import com.buzzinate.bshare.points.bean.ProductCategory;
import com.buzzinate.bshare.points.bean.enums.PointsCategory;
import com.buzzinate.bshare.points.service.AccountService;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.bshare.points.service.PointsProductService;
import com.buzzinate.bshare.points.service.PointsUserService;
import com.buzzinate.bshare.points.service.ProductCategoryService;
import com.buzzinate.common.util.JsonResults;
import com.opensymphony.xwork2.Action;

/**
 * shop action for main page
 * 
 * @author james.chen
 * @since 2012-6-11
 */
@Controller
@Scope("request")
public class ShopAction extends BaseAction {

    private static final long serialVersionUID = 8500476685192287649L;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private PointsProductService productService;
    
    @Autowired
    private PointsUserService pointsUserService;
    
    @Autowired
    private AccountService accountService;
    
    @Autowired
    private ProductCategoryService categoryService;
    
    //@Autowired
    //private PointsUserAccountService userAccountService;
    
    //first Three activity
    private List<Activity> activities;
    //first 20 products
    private List<PointsProduct> exchanges;
    //pointsUser
    private PointsUser pointsUser;
    //if user is publisher need to display usedPoint.
    private Account account;
    //ajax object JsonResult
    private JsonResults results;
    //product category
    private List<ProductCategory> categories;
    //UserAcccount list
    private List<PointsUserAccount> userAccounts;
    //TAOBAO
    private PointsProduct taoBaoPoints;
    
    public String baseInfo() {
        results = new JsonResults();
        try {
            if (getCurrentUserId() > 0) {
                pointsUser = pointsUserService.getPointsByUserId(getCurrentUserId());
                pointsUser.setUserName(loginHelper.getUserName());
                results.addContent("pointsUser", pointsUser);
                if (loginHelper.hasRole(UserConstants.ROLE_PUBLISHER)) {
                    account = accountService.findAccount(getCurrentUserId());
                    results.addContent("account", account);
                }
            }
        } catch (Exception e) {
            results.setMessage("get baseinfo error");
        }
        return JsonResults.JSON_RESULT_NAME;
    }
    
    public String index() {
        activities = activityService.getProductActivitys();
        exchanges = productService.getProductsMainPage();
        categories = categoryService.getAllWithProduct();
        //userAccounts = userAccountService.getAccountByUserIdPointsCate(getCurrentUserId(), PointsCategory.TAOBAO);
        pointsUser = pointsUserService.getPointsByUserId(getCurrentUserId());
        taoBaoPoints = productService.getProductById(PointsCategory.TAOBAO.getCode());
        return Action.SUCCESS;
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public void setActivities(List<Activity> activities) {
        this.activities = activities;
    }


    public List<PointsProduct> getExchanges() {
        return exchanges;
    }

    public void setExchanges(List<PointsProduct> exchanges) {
        this.exchanges = exchanges;
    }

    public PointsUser getPointsUser() {
        return pointsUser;
    }

    public void setPointsUser(PointsUser pointsUser) {
        this.pointsUser = pointsUser;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public JsonResults getResults() {
        return results;
    }

    public List<ProductCategory> getCategories() {
        return categories;
    }

    public List<PointsUserAccount> getUserAccounts() {
        return userAccounts;
    }

    public PointsProduct getTaoBaoPoints() {
        return taoBaoPoints;
    }
}
