package com.buzzinate.bshare.points.action.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.service.AccountService;
import com.buzzinate.bshare.user.bean.UserBase;
import com.buzzinate.bshare.user.service.UserBaseServices;

/**
 * Admin后台
 * 
 * @author magic
 */
@Controller
@Scope("request")
public class AdminAction extends BaseAction {

    private static final long serialVersionUID = 1237719421242305656L;

    private String email;
    private int points;
    
    @Autowired
    private AccountService accountService;
    @Autowired
    private UserBaseServices userBaseServices;
    
    /**
     * 给站长充积分
     * 
     * @throws Exception
     */
    public String topup() throws Exception {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return ERROR;
        }
        UserBase user = userBaseServices.getUserByEmail(email);
        if (user == null) {
            addActionError(getText("bshare.points.admin.email.not.exist"));
            return ERROR;
        }
        
        if (points <= 0) {
            addActionError(getText("bshare.points.admin.points.error"));
            return ERROR;
        }
        
        int userId = user.getUserID();
        if (!accountService.isExistsAccount(userId)) {
            addActionError(getText("bshare.points.account.not.exist"));
            return ERROR;
        }
        
        if (!accountService.chargePoints(userId, points)) {
            addActionError(getText("bshare.points.admin.topup.fail"));
            return ERROR;
        }

        addActionMessage(getText("bshare.points.admin.topup.success"));
        return SUCCESS;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public int getPoints() {
        return points;
    }

}
