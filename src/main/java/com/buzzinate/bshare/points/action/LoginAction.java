package com.buzzinate.bshare.points.action;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.core.bean.UuidSite;
import com.buzzinate.bshare.core.service.UuidSiteServices;
import com.buzzinate.bshare.points.service.AccountService;
import com.buzzinate.common.exceptions.DataSourceException;
import com.buzzinate.common.exceptions.ServicesException;
import com.buzzinate.common.util.JsonResults;
import com.buzzinate.common.util.ServletUtils;
import com.opensymphony.xwork2.Action;

/**
 * 
 * @author John Chen Sep 24, 2009 Copyright 2009 Buzzinate Co. Ltd.
 *
 */
@Controller
@Scope("request")
public class LoginAction extends BaseAction {

    private static final long serialVersionUID = -728117070457501306L;

    private String dynamicAction;
    private Integer error;

    @Autowired
    private UuidSiteServices uuidSiteServices;
    private JsonResults results;
    private String defaultPage = "/jsp/user/Login.jsp";
    
    private String callback;
    
    @Autowired
    private AccountService accountService;

    public String execute() throws ServicesException, DataSourceException {
        initDefaultPage();
        
        if (!loginHelper.isLoggedIn()) {
            if (getError() != null) {
                if (getError().intValue() == 1) {
                    addActionError(getText("bshare.points.userAuthentication.invalid"));
                } else if (getError().intValue() == 2) {
                    addActionError(getText("bshare.points.userAuthentication.invalid"));
                    setDynamicAction(dynamicAction);
                    return "dynamicAction";
                }
            }
            return Action.ERROR;
        }
        
        if (!StringUtils.isEmpty(dynamicAction)) {
            setDynamicAction(dynamicAction);
            return "dynamicAction";
        }
        
        dynamicAction = (String) session.get("dynamicAction");
        if (!StringUtils.isEmpty(dynamicAction)) {
            return "dynamicAction";
        }
        
        // direct to different landing pages depending on the type of user...
        if (loginHelper.isLoginAsPointsAdmin()) {
            setDynamicAction("/admin/publisher");
            return "dynamicAction";
        } else if (loginHelper.isLoginAsPointsPublisher()) {
            setDynamicAction("/publisher/userDashboard");
            return "dynamicAction";
        } else if (loginHelper.isLoginAsUser()) {
            setDynamicAction("/shop");
            return "dynamicAction";
        } else {
            // DEFAULT: this goes to the profile...
            return Action.SUCCESS; 
        }
    }
    
    /**
     * for user customize default render page
     */
    private void initDefaultPage() {
        String customizeDefaultPage = (String) session.get("defaultPage");
        if (!StringUtils.isEmpty(customizeDefaultPage)) {
            this.defaultPage = customizeDefaultPage;
        }
    }
    
    /**
     * JSON: Provides AJAX way to login. NOT USED!!!
     * 
     * @return
     */
    public String login() {
        results = new JsonResults();
        if (!loginHelper.isLoggedIn()) {
            results.set(false, getText("bshare.points.userAuthentication.invalid"));
            return JsonResults.JSON_RESULT_NAME; 
        }
        
        List<UuidSite> uuidSites = uuidSiteServices.getUuidSiteByUserId(loginHelper.getUserID());
        if (!uuidSites.isEmpty()) {
            // TODO: Maybe later we let user choose a uuid if has multiple sites
            results.addContent("uuid", uuidSites.get(0).getUuid());
        }
        return JsonResults.JSON_RESULT_NAME; 
    }
    
    public Integer getError() {
        return error;
    }

    public void setError(Integer error) {
        this.error = error;
    }

    public String getDynamicAction() {
        return this.dynamicAction;
    }

    public void setDynamicAction(String dynamicAction) {
        this.dynamicAction = dynamicAction;
    }
    
    public JsonResults getResults() {
        return results;
    }

    public String getDefaultPage() {
        return defaultPage;
    }

    public void setDefaultPage(String defaultPage) {
        this.defaultPage = defaultPage;
    }
    
    public String getCallback() {
        return callback;
    }
    
    public void setCallback(String callback) {
        this.callback = callback;
    }
    
}
