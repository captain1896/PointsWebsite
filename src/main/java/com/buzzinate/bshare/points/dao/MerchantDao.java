package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.Merchant;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * Merchant manager Dao
 * 
 * @author martin
 *
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class MerchantDao extends PointsDaoBase<Merchant, Integer> implements Serializable {
    
    private static final long serialVersionUID = -2750307033563669546L;
    
    private static Log log = LogFactory.getLog(MerchantDao.class);
    
    public MerchantDao() {
        super(Merchant.class, "id");
    }

    public Merchant getMerchantByEmail(String email) {
        Query query =  getSession().getNamedQuery("merchant.getMerchantByEmail");
        query.setString("email", email);
        List<Merchant> list = query.list();
        if (list.size() > 0) {
            return list.get(0);
        }
        return null;
    }

    public List<Merchant> getAll() {
        Query query = getSession().getNamedQuery("merchant.getAll");
        return query.list();
    }
}
