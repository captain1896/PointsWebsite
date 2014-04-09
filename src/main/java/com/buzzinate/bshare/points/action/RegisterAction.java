package com.buzzinate.bshare.points.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.user.service.LoginHelper;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.TextProvider;

/**
 * First part of registration.
 * 
 * @author Martin
 */
@Controller
@Scope("request")
public class RegisterAction extends ActionSupport implements ServletRequestAware {

    private static final long serialVersionUID = -6302593969417954587L;

    private TextProvider textProvider;
    private String dynamicAction;
    private HttpServletRequest request;
    @Autowired
    private LoginHelper loginHelper;

    public String execute() {
        addActionMessage(textProvider.getText("bshare.user.register.successfully"));

        dynamicAction = (String) request.getSession().getAttribute("dynamicAction");
        if (!StringUtils.isEmpty(dynamicAction)) {
            return "dynamicAction";
        }
        if (loginHelper.isLoginAsPublisher()) {
            return "publisher";
        }
        return Action.SUCCESS;    
    }

    public void setTextProvider(TextProvider textProvider) {
        this.textProvider = textProvider;
    }
    
    public String getDynamicAction() {
        return dynamicAction;
    }

    public void setDynamicAction(String dynamicAction) {
        this.dynamicAction = dynamicAction;
    }

    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.request = request;
    }

}
