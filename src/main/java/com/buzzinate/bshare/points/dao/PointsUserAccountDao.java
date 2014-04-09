package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.PointsUserAccount;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * PointsUserAccount ado handle PointsUser Service
 * @author james.chen
 * @since 2012-7-3
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class PointsUserAccountDao extends PointsDaoBase<PointsUserAccount, Integer> implements Serializable {

    private static final long serialVersionUID = 7942038288555462645L;

    public PointsUserAccountDao() {
        super(PointsUserAccount.class , "id");
    }
    
    public List<PointsUserAccount> getUserAccount(PointsUserAccount account) {
        Criteria userAccount = getSession().createCriteria(PointsUserAccount.class);
        if (account.getId() > 0) {
            userAccount.add(Restrictions.eq("userId", account.getUserId()));
        }
        if (account.getPointsCate() != null) {
            userAccount.add(Restrictions.eq("pointsCate", account.getPointsCate()));
        }
        if (StringUtils.isNotBlank(account.getAccountName())) {
            userAccount.add(Restrictions.eq("accountName", account.getAccountName()));
        }
        userAccount.addOrder(Order.desc("updateTime"));
        return userAccount.list();
    }
}
