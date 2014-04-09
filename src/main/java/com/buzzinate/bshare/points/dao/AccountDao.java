package com.buzzinate.bshare.points.dao;

import java.io.Serializable;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.Account;
import com.buzzinate.bshare.points.bean.enums.TradeStatus;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * Account manager Dao
 * 
 * @author martin
 *
 */
@Repository
@Transactional(value = "points", readOnly = true)
public class AccountDao extends PointsDaoBase<Account, Integer> implements Serializable {
    
    private static final long serialVersionUID = -7885657868854320870L;

    //private static Log log = LogFactory.getLog(AccountDao.class);
    
    public AccountDao() {
        super(Account.class, "publisherId");
    }
    
    /**
     * 账户充值
     * @param publisherId
     * @param points
     */
    @Transactional(value = "points", readOnly = false)
    public boolean charge(int publisherId , int points) {
        Query query = getSession().getNamedQuery("account.charge");
        query.setInteger("publisherId", publisherId);
        query.setInteger("points", points);
        return query.executeUpdate() > 0;
    }
    
    /**
     * 账户充值
     * @param publisherId
     * @param points
     */
    @Transactional(value = "points", readOnly = false)
    public boolean chargeWithTradNo(int publisherId , int points , String tradNo) {
        Query query = getSession().getNamedQuery("account.chargewithtradno");
        query.setInteger("publisherId", publisherId);
        query.setInteger("points", points);
        query.setString("tradeNo", tradNo);
        query.setParameter("tradStatus", TradeStatus.WAITPAY);
        return query.executeUpdate() > 0;
    }
    
    /**
     * 活动暂时冻结账户金额
     * @param publisherId
     * @param points
     */
    @Transactional(value = "points", readOnly = false)
    public boolean freeze(int publisherId , int points) {
        Query query = getSession().getNamedQuery("account.freezenPoints");
        query.setInteger("userId", publisherId);
        query.setInteger("points", points);
        return query.executeUpdate() > 0;
    }

    /**
     * 
     * @param publisherId
     * @param points
     * @return
     */
    @Transactional(value = "points", readOnly = false)
    public boolean returnPoints(int publisherId, int totalPoints, int usedPoints) {
        Query query = getSession().getNamedQuery("account.returnPoints");
        query.setInteger("publisherId", publisherId);
        query.setInteger("returnPoints", totalPoints - usedPoints);
        query.setInteger("usedPoints", usedPoints);
        return query.executeUpdate() > 0;
    }
    
    /**userpoints reset
     * @param publisherId
     * @param usedPoints
     * @return
     */
    @Transactional(value = "points", readOnly = false)
    public boolean usePoints(int publisherId , int usedPoints) {
        Query query = getSession().getNamedQuery("account.usedPoints");
        query.setInteger("publisherId", publisherId);
        query.setInteger("usedPoints", usedPoints);
        return query.executeUpdate() > 0;
    }
}
