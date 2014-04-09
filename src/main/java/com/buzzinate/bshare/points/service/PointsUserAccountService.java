package com.buzzinate.bshare.points.service;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.PointsUserAccount;
import com.buzzinate.bshare.points.bean.enums.PointsCategory;
import com.buzzinate.bshare.points.dao.PointsUserAccountDao;
import com.buzzinate.common.services.MemcachedService;

/**
 * handle Points User Account operation
 * @author james.chen
 * @since 2012-7-3
 */
@Service
@SuppressWarnings("unchecked")
public class PointsUserAccountService extends MemcachedService<PointsUserAccount, Integer, PointsUserAccountDao>
        implements Serializable {

    private static final long serialVersionUID = 7232884121499727742L;
    private static final String USERID_CATE = "userIdCate";
    
    @Autowired
    private PointsUserAccountDao accountDao;
    
    public int storeUserAccount(PointsUserAccount account) {
        if (account == null || StringUtils.isBlank(account.getAccountName())) {
            return 0;
        }
        List<PointsUserAccount> accounts = accountDao.getUserAccount(account);
        PointsUserAccount temAccount = accounts.size() > 0 ? accounts.get(0) : account;
        if (temAccount.getId() == 0) {
            return accountDao.create(temAccount);
        } else {
            temAccount.setUpdateTime(new Date());
            accountDao.update(temAccount);
            memcachedClient.delete(getPrefix() + USERID_CATE);
            return temAccount.getId();
        }
    }
    
    public PointsUserAccount get(int id) {
        return accountDao.read(id);
    }
    
    public List<PointsUserAccount> getAccountByUserId(int userId) {
        return accountDao.getUserAccount(new PointsUserAccount(userId , null , null));
    }
    
    public List<PointsUserAccount> getAccountByInfo(int userId, PointsCategory pointsCategory, String accountName) {
        return accountDao.getUserAccount(new PointsUserAccount(userId , pointsCategory , accountName));
    }
    
    public List<PointsUserAccount> getAccountByUserIdPointsCate(int userId , PointsCategory pointsCate) {
        List<PointsUserAccount> useraccounts = (List<PointsUserAccount>) memcachedClient.get(getPrefix() + USERID_CATE);
        if (useraccounts == null) {
            useraccounts = accountDao.getUserAccount(new PointsUserAccount(userId , pointsCate , null));
            memcachedClient.set(getPrefix() + USERID_CATE, getExpired(), useraccounts);
        }
        return useraccounts;
    }

    @Override
    public String getPrefix() {
        return "PUA:";
    }

    @Override
    public void init() {
        setDao(accountDao);
    }
}
