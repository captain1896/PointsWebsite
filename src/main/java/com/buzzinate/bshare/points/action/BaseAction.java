package com.buzzinate.bshare.points.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;

import com.buzzinate.bshare.user.service.LoginHelper;
import com.opensymphony.xwork2.ActionSupport;

/**
 * Action的父类
 * 
 * 实现了一些通用的Struts aware接口；一些Action常调用到的辅助方法有可以放到这
 * 
 * @author magic
 *
 */
public class BaseAction extends ActionSupport implements SessionAware, ServletRequestAware, ServletResponseAware {

    protected Map<String, Object> session;
    protected HttpServletResponse response;
    protected HttpServletRequest request;
    
    @Autowired
    protected LoginHelper loginHelper;
    
    @Override
    public void setServletResponse(HttpServletResponse httpServletResponse) {
        this.response = httpServletResponse;
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    public LoginHelper getLoginHelper() {
        return loginHelper;
    }

    /**
     * 获取当前用户ID
     * @return
     */
    public int getCurrentUserId() {
        return getLoginHelper().getUserId();
    }
}
