package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.common.dao.PointsDaoBase;


/**
 * the detail interface to operate the pointProduct object
 * @author james.chen
 * @since 2012-6-11
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class PointsProductDao extends PointsDaoBase<PointsProduct, Integer> implements Serializable {

    private static final long serialVersionUID = -5424650399653206907L;

    public static final String MERCHANT_ID = "merchantId";
    
    public PointsProductDao() {
        super(PointsProduct.class , "id");
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean updateProductSell(int sellNum , int id) {
        Query query = getSession().getNamedQuery("PointsProduct.updateSellNum");
        query.setInteger("sells", sellNum);
        query.setInteger("id", id);
        return query.executeUpdate() > 0;
    }
    
    /**get ProductCategory with product number
     * @return
     */
    public Map<Integer, Long> getCategoryNum() {
        Map<Integer, Long> resultMap = new HashMap<Integer, Long>();
        Query query = getSession().getNamedQuery("PointsProduct.getCategoryNum");
        List<Object[]> list = query.list();
        for (Object[] objects : list) {
            resultMap.put((Integer) objects[0], (Long) objects[1]);
        }
        return resultMap;
    }
}
