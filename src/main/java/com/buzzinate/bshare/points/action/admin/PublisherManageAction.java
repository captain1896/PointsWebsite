package com.buzzinate.bshare.points.action.admin;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.core.constant.UserConstants;
import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.ExceptionHandler;
import com.buzzinate.bshare.points.bean.PointsPublisher;
import com.buzzinate.bshare.points.service.PointsPublisherService;
import com.buzzinate.bshare.user.bean.UserBase;
import com.buzzinate.bshare.user.service.UserBaseServices;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 
 * 积分合作站点管理
 * 
 * @author magic
 *
 */
@Controller
@Scope("request")
public class PublisherManageAction extends BaseAction implements ModelDriven<PointsPublisher> {

    private static final long serialVersionUID = 887420130752032297L;

    private List<PointsPublisher> publishers;
    
    private PointsPublisher pointsPublisher = new PointsPublisher();
    
    private ExceptionHandler handler = new ExceptionHandler(getText("bshare.shop.exception.unauthorized.title") ,
            getText("bshare.shop.exception.unauthorized.error") , "");
    
    @Autowired
    private PointsPublisherService pointsPublisherService;
    
    @Autowired
    private UserBaseServices userBaseServices;
    
    public String execute() {
        if (!loginHelper.isLoginAsPointsAdmin()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        publishers = pointsPublisherService.getAllSitePoints();
        return SUCCESS;
    }
    
//    public String edit() {
//        pointsPublisher = pointsPublisherService.getPointsPublisher(email);
//        return SUCCESS;
//    }
    
    public String delete() {
        
        if (loginHelper.isLoginAsPointsAdmin() && StringUtils.isNotEmpty(pointsPublisher.getEmail())) {
            pointsPublisher = pointsPublisherService.getPointsPublisher(pointsPublisher.getEmail());
            if (pointsPublisher != null) {
                pointsPublisherService.delete(pointsPublisher.getEmail());
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
        if (StringUtils.isEmpty(getPointsPublisher().getEmail())) {
            addActionError(getText("bshare.points.admin.email.required"));
            return ERROR;
        }
        
        if (pointsPublisherService.getPointsPublisher(getPointsPublisher().getEmail()) != null) {
            addActionError(getText("bshare.points.admin.email.has.pointId"));
            return ERROR;
        }
        
        UserBase user = userBaseServices.getUserByEmail(getPointsPublisher().getEmail());
        if (user == null) {
            addActionError(getText("bshare.points.admin.email.not.exist"));
            return ERROR;
        }
        
        pointsPublisherService.create(user.getUserID(), getPointsPublisher());
        return SUCCESS;
    }
    //apply publisher
    public String apply() {
        if (!loginHelper.isLoginAsPublisher()) {
            handler.setErrorInfo(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        if (!loginHelper.hasRole(UserConstants.ROLE_POINTS_PUBLISHER)) {
            pointsPublisherService.create(loginHelper.getUserId(), new PointsPublisher(loginHelper.getUserEmail()));
            loginHelper.reLogin();
        }
        return SUCCESS;
    }


    @Override
    public PointsPublisher getModel() {
        return getPointsPublisher();
    }

    public List<PointsPublisher> getPublishers() {
        return publishers;
    }

    public void setPublishers(List<PointsPublisher> publishers) {
        this.publishers = publishers;
    }

    public PointsPublisher getPointsPublisher() {
        return pointsPublisher;
    }

    public void setPointsPublisher(PointsPublisher pointsPublisher) {
        this.pointsPublisher = pointsPublisher;
    }

    public ExceptionHandler getHandler() {
        return handler;
    }
}
