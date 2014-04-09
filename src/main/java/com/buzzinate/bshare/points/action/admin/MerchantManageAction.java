package com.buzzinate.bshare.points.action.admin;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Merchant;
import com.buzzinate.bshare.points.service.MerchantService;
import com.buzzinate.bshare.user.bean.UserBase;
import com.buzzinate.bshare.user.service.UserBaseServices;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;
import com.taobao.api.internal.util.StringUtils;

/**
 * 
 * Merchant manage action
 * 
 * @author Martin
 *
 */
@Controller
@Scope("request")
public class MerchantManageAction extends BaseAction implements ModelDriven<Merchant> {

    private static final long serialVersionUID = -1083005833513423681L;

    @Autowired
    private MerchantService merchantService;
    @Autowired
    private UserBaseServices userBaseServices;
    
    private List<Merchant> merchants;
    private Merchant merchant = new Merchant();
    
    public String execute() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        merchants = merchantService.getAll();
        return SUCCESS;
    }
    
    public String edit() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        merchant = merchantService.get(merchant.getId());
        return SUCCESS;
    }
    
    public String update() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        Merchant merchantSrc = merchantService.get(merchant.getId());
        merchantSrc.setHomeURL(merchant.getHomeURL());
        merchantSrc.setEmail(merchant.getEmail());
        merchantSrc.setName(merchant.getName());
        merchantService.update(merchantSrc);
        return SUCCESS;
    }
    
    public String delete() {
        if (loginHelper.isLoggedIn() && loginHelper.isLoginAsPointsAdmin() && merchant.getId() > 0) {
            merchant = merchantService.get(merchant.getId());
            if (merchant != null) {
                merchantService.delete(merchant);
                addActionMessage(getText("bshare.points.common.delete.success"));
                return Action.SUCCESS;
            }
        }
        addActionMessage(getText("bshare.points.operation.unauthorized"));
        return Action.ERROR;
    }
    
    public String create() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        if (StringUtils.isEmpty(merchant.getEmail())) {
            addActionError(getText("bshare.points.admin.email.required"));
            return ERROR;
        }
        
        if (merchantService.getMerchantByEmail(merchant.getEmail()) != null) {
            addActionError(getText("bshare.points.admin.merchart.has.exist"));
            return ERROR;
        }
        
        UserBase user = userBaseServices.getUserByEmail(merchant.getEmail());
        if (user == null) {
            addActionError(getText("bshare.points.admin.email.not.exist"));
            return ERROR;
        }
        merchant.setUserId(user.getUserID());
        merchant.setJoinTime(new Date());
        merchantService.create(merchant);
        return SUCCESS;
    }


    @Override
    public Merchant getModel() {
        return merchant;
    }

    public List<Merchant> getMerchants() {
        return merchants;
    }

    public void setMerchants(List<Merchant> merchants) {
        this.merchants = merchants;
    }

    public Merchant getMerchant() {
        return merchant;
    }

    public void setMerchant(Merchant merchant) {
        this.merchant = merchant;
    }

}
