package com.buzzinate.bshare.points.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.Account;
import com.buzzinate.bshare.points.bean.PointsPublisher;
import com.buzzinate.bshare.points.bean.enums.PointsStatModule;
import com.buzzinate.bshare.points.dao.AccountDao;
import com.buzzinate.bshare.user.bean.Role;
import com.buzzinate.bshare.user.bean.UserBase;
import com.buzzinate.bshare.user.bean.UserType;
import com.buzzinate.bshare.user.service.UserBaseServices;
import com.buzzinate.bshare.user.service.UserRoleServices;


/**
 * 积分合作站点管理Service
 * 
 * @author magic
 *
 */
@Service
public class PointsPublisherService {

    @Autowired
    private AccountDao accountDao;
    @Autowired
    private AccountService accountService;
    @Autowired
    private UserBaseServices userBaseServices;
    @Autowired
    private UserRoleServices userRoleServices;
    @Autowired
    private PointsOperateHisService operateHisService;
    
    /**
     * 获取所有站点Point信息
     * @return
     */
    public List<PointsPublisher> getAllSitePoints() {
        List<Account> accounts = accountDao.query(null);
        
        List<PointsPublisher> sites = new ArrayList<PointsPublisher>();
        for (Account account : accounts) {
            UserBase user = userBaseServices.getUser(account.getPublisherId());
            if (user != null) {
                sites.add(new PointsPublisher(user.getEmail()));
            }
        }
        return sites;
    }
    
    
    /**
     * 根据Email获取PointsPublisher
     * 
     * @param email
     * @return
     */
    public PointsPublisher getPointsPublisher(String email) {
        UserBase user = userBaseServices.getUserByEmail(email);
        if (user == null) {
            return null;
        }
        
        Account account = accountDao.read(user.getUserID());
        if (account == null) {
            return null;
        }
        
        return new PointsPublisher(user.getEmail());
    }
    public void create(int userId, PointsPublisher sitePoint) {
        //create account need to check userId
    	int recordId = accountService.createAccount(userId,"");
        
        //create add account log
        operateHisService.createAdd(PointsStatModule.PUBLISHER, recordId);
        String roleName = Role.parseRoleName(UserType.USERTYPE_CODE_POINTS_PUBLISHER);
        userRoleServices.addRoleToUser(userId, roleName);
    }
    public void delete(String email) {
        UserBase ub = userBaseServices.getUserByEmail(email);
        //create Delete account log
        operateHisService.createDelete(PointsStatModule.PUBLISHER, ub.getUserID());
        accountDao.delete(ub.getUserID());
        String roleName = Role.parseRoleName(UserType.USERTYPE_CODE_POINTS_PUBLISHER);
        userRoleServices.removeRoleFromUser(ub.getUserID(), roleName);
    }

}
