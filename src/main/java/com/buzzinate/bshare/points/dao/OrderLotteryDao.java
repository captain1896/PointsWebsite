package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.OrderLottery;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * @author james.chen
 * @since 2012-7-20
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class OrderLotteryDao extends PointsDaoBase<OrderLottery, Integer> implements Serializable {

    private static final long serialVersionUID = 4958685373954578759L;

    public List<OrderLottery> getOrderLotterysProduct(int productId) {
        Criteria criter = getSession().createCriteria(OrderLottery.class);
        if (productId > 0) {
            criter.add(Restrictions.eq("productId", productId));
        }
        return (List<OrderLottery>) criter.list();
    }
    // order Lottery No
    public boolean orderLotteryNo(int productId , int orderId) {
        Query query = getSession().getNamedQuery("OrderLottery.orderLotteryNo");
        query.setInteger("productId", productId);
        query.setInteger("orderId", orderId);
        return query.executeUpdate() > 0;
    }
}
