package com.buzzinate.bshare.points.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.Account;
import com.buzzinate.bshare.points.bean.AccountRecord;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.AlipayRecord;
import com.buzzinate.bshare.points.bean.enums.AccountRecordType;
import com.buzzinate.bshare.points.bean.enums.PointsStatModule;
import com.buzzinate.bshare.points.bean.enums.TradeStatus;
import com.buzzinate.bshare.points.dao.AccountDao;
import com.buzzinate.bshare.points.util.CacheConstants;
import com.buzzinate.common.memcached.MemcachedClientAdapter;

/**
 * Account Service
 * 
 * @author magic
 * 
 */
@Service
public class AccountService {


    @Autowired
    private AccountDao accountDao;
    @Autowired
    private AccountRecordService accountRecordService;
    @Autowired
    private MemcachedClientAdapter memcachedClient;
    @Autowired
    private PointsOperateHisService operateHisService;
    @Autowired
    private AlipayRecordService alipayRecordService;

    /**
     * 账户信息
     * 
     * @param publisherId
     * @return
     */
    public Account findAccount(int publisherId) {
        String key = CacheConstants.ACCOUNT + publisherId;
        Account account = (Account) memcachedClient.get(key);
        if (account == null) {
            account = accountDao.read(publisherId);
            if (account != null) {
                memcachedClient.set(key, CacheConstants.EXPIRE_ACCOUNT, account);
            }
        }
        return account == null ? new Account(publisherId) : account;
    }
    
    public boolean isExistsAccount(int publisherId) {
        Account account = accountDao.read(publisherId);
        return account == null ? false : true;
    }

    /**
     * 账户充值
     * 
     * @param userId
     * @param points
     */
    @Transactional(value = "points", readOnly = false)
    public boolean chargePoints(int publisherId , int points) {
        return chargePoints(publisherId, points, AccountRecordType.CHARGE, "账户充值");
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean chargePoints(int publisherId , int points , AccountRecordType recordType , String message) {
        if (!accountDao.charge(publisherId, points)) {
            throw new RuntimeException("charge point issue,publisherId=" + publisherId + ",points=" + points);
        }
        // charge account
        operateHisService.createModify(PointsStatModule.PUBLISHER, publisherId);
        // 充值记录
        AccountRecord accountRecord = new AccountRecord(publisherId , Math.abs(points) , recordType , message);
        accountRecordService.create(accountRecord);
        String key = CacheConstants.ACCOUNT + publisherId;
        memcachedClient.delete(key);
        return true;
    }
    
    
    /**
     * 支付宝账户充值
     * 
     * @param userId
     * @param points
     */
    @Transactional(value = "points", readOnly = false)
    public int chargePoints(int publisherId , AlipayRecord alipayRecord) {
        int points = alipayRecord.getPoints() * 100;
        if (!accountDao.chargeWithTradNo(publisherId, points, alipayRecord.getTradeNo())) {
            throw new RuntimeException("charge for taobao error,publisherId=" + publisherId + "points=" + points +
                    ",tradeNo=" + alipayRecord.getTradeNo());
        }
        // charge account
        operateHisService.createModify(PointsStatModule.PUBLISHER, publisherId);
        // 充值记录
        AccountRecord accountRecord = new AccountRecord(publisherId , points , AccountRecordType.CHARGE , "支付宝账户充值");
        accountRecordService.create(accountRecord);
        String key = CacheConstants.ACCOUNT + publisherId;
        memcachedClient.delete(key);
        return accountRecord.getId();
    }

    /**
     * 活动扣除积分
     * 
     * @param publisherId
     * @param points
     */
    @Transactional(value = "points", readOnly = false)
    public boolean deductPoints(Activity activity, int points, boolean update) {
        if (activity == null) {
            return false;
        }
        if (points <= 0) {
            return true;
        }
        //freeze Points
        //if can not freezen Activity throw exception
        if (!accountDao.freeze(activity.getPublisherId(), points)) {
            throw new RuntimeException("freeze account points error,pointsId=" + activity.getPublisherId() + ",points" +
                    points);
        }
        // delete account
        operateHisService.createModify(PointsStatModule.PUBLISHER, activity.getPublisherId());
        // create new add Account Record
        String message = activity.getName() + (update ? " 增加投放积分" : " 创建活动冻结积分");
        accountRecordService.create(new AccountRecord(activity.getPublisherId() , activity.getId() , points ,
                AccountRecordType.DEDUCT , message));
        //delete this Account in cache
        memcachedClient.delete(CacheConstants.ACCOUNT + activity.getPublisherId());
        return true;
    }

    /**
     * 活动返还积分
     * 
     * @param activity
     */
    @Transactional(value = "points", readOnly = false)
    public boolean returnPoints(Activity activity) {
        int publisherId = activity.getPublisherId();

        if (accountDao.returnPoints(publisherId, activity.getTotalPoints(), activity.getUsedPoints())) {
            String key = CacheConstants.ACCOUNT + publisherId;
            memcachedClient.delete(key);
        } else {
            throw new RuntimeException("return Points error,publisherId=" + publisherId + ",totalPoints=" + 
                    activity.getTotalPoints() + ",usedPoints=" + activity.getUsedPoints());
        }
        // 返还记录
        if (activity.getAvailablePoints() > 0) {
            AccountRecord accountRecord =
                    new AccountRecord(publisherId , activity.getId() , activity.getAvailablePoints() ,
                            AccountRecordType.RETURN , activity.getName() + " 活动结束返还积分");
            accountRecordService.create(accountRecord);
        }
        return true;
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean usePoints(int publisherId , int usedPoints) {
        if (!accountDao.usePoints(publisherId, usedPoints)) {
            throw new RuntimeException("use Points error,publisherId=" + publisherId + ",usedPoints=" + usedPoints);
        }
        String key = CacheConstants.ACCOUNT + publisherId;
        memcachedClient.delete(key);
        return true;
    }

    /**
     * 创建账户，供Admin在后台给站长创建账户调用
     * 
     * @param publisherId
     * @param pointName
     * @return
     */
    @Transactional(value = "points", readOnly = false)
    public int createAccount(int publisherId , String pointName) {
        if (!isExistsAccount(publisherId)) {
            Account account = new Account(publisherId);
            accountDao.create(account);
            operateHisService.createAdd(PointsStatModule.PUBLISHER, publisherId);
        }
        return publisherId;
    }

    /**
     * delete account, just for test.
     * 
     * @param publisherId
     * @return
     */
    @Transactional(value = "points", readOnly = false)
    public void deleteAccount(int publisherId) {
        accountDao.delete(publisherId);
        operateHisService.createDelete(PointsStatModule.PUBLISHER, publisherId);
        String key = CacheConstants.ACCOUNT + publisherId;
        memcachedClient.delete(key);
    }

    @Transactional(value = "points", readOnly = false)
    public void createAndCharge(int publisherId, AlipayRecord alipayRecord) {
        int recordId = chargePoints(publisherId, alipayRecord);
        alipayRecord.setRecordId(recordId);
        alipayRecord.setTradeStatus(TradeStatus.SUCCESS);
        alipayRecordService.save(alipayRecord);
    }
}
