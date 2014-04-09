package com.buzzinate.bshare.points.action.shop.order;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.ExceptionHandler;
import com.buzzinate.bshare.points.bean.PointsUserAccount;
import com.buzzinate.bshare.points.bean.enums.PointsCategory;
import com.buzzinate.bshare.points.service.PointsUserAccountService;
import com.buzzinate.bshare.points.util.AlipayApiUtil;
import com.buzzinate.common.util.ConfigurationReader;
import com.opensymphony.xwork2.Action;

/**
 * Alipay快捷登陆
 * 
 * 构造快捷登陆请求参数，发送请求给alipay ---> 用户在alipay完成登陆 --->
 * 
 * ---> alipay返回响应数据到redirectURL ---> 对获取的返回结果数据进行处理
 * 
 * @author magic
 * 
 */
@Controller
@Scope("request")
public class AlipayQuickLogin extends BaseAction {

    private static final String SERVICE = "alipay.auth.authorize";
    private static final String TARGET_SERVICE = "user.auth.quick.login";
    private static final String RETURN_URL = ConfigurationReader.getString("bshare.points.server") +
            "/alipayQuickLogin/callback";

    private static final String ORDER_POINTS_URL = ConfigurationReader.getString("bshare.points.server") +
            "/shop/order/points";

    private String redirectURL;

    @Autowired
    private PointsUserAccountService pointsUserAccountService;

    private ExceptionHandler handler;

    /**
     * 构造好参数，发送请求给alipay
     * 
     * @return alipay request url
     */
    public String tryToLogin() {
        // 基本参数: service, return_url, partner, _input_charset, sign_type, sign
        // 授权业务参数: target_service, exter_invoke_ip, anti_phishing_key
        Map<String, String> params = new HashMap<String, String>();
        params.put("service", SERVICE);
        params.put("target_service", TARGET_SERVICE);
        params.put("return_url", RETURN_URL);

        // 构造请求URL
        redirectURL = AlipayApiUtil.getApiRequestUrl(params);
        return Action.SUCCESS;
    }

    /**
     * 用户在alipay快捷登陆后，回调callbak，对获取的返回结果数据进行处理
     * 
     * @return 系统内部请求快捷登陆的url
     */
    public String callback() {
        // 基本参数: is_success, sign_type, sign
        // 业务参数: notify_id, user_id, real_name, email, token, user_grade,
        // user_grade_type, gmt_decay, target_url
        String queryString = request.getQueryString();
        System.out.println(queryString);
        String isSuccess = request.getParameter("is_success");

        if (AlipayApiUtil.API_SUCCESS.equals(isSuccess)) {
            String email = request.getParameter("email");
            PointsUserAccount account = new PointsUserAccount(getCurrentUserId() , PointsCategory.TAOBAO , email);
            pointsUserAccountService.storeUserAccount(account);

            // 跳转到兑换页面
            redirectURL = ORDER_POINTS_URL;
            return Action.SUCCESS;
        } else {
            handler =
                    new ExceptionHandler(getText("bshare.alipay.quicklogin") ,
                            getText("bshare.alipay.quicklogin.fail") , "");
            return Action.ERROR;
        }
    }

    public String getRedirectURL() {
        return redirectURL;
    }

    public void setRedirectURL(String redirectURL) {
        this.redirectURL = redirectURL;
    }

    public ExceptionHandler getHandler() {
        return handler;
    }

    public void setHandler(ExceptionHandler handler) {
        this.handler = handler;
    }

}
