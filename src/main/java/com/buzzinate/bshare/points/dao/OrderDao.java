package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.Order;
import com.buzzinate.bshare.points.bean.enums.OrderStatus;
import com.buzzinate.common.dao.PointsDaoBase;
/**
 * points Order Dao to handle order operation
 * @author james.chen
 * @since 2012-6-12
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class OrderDao extends PointsDaoBase<Order, Integer> implements Serializable {

    private static final long serialVersionUID = -2364772897533126483L;
    
    
    public OrderDao() {
        super(Order.class , "id");
    }
    
    public List<Order> getOrders() {
        Query query = getSession().getNamedQuery("Order.getOrders");
        return (List<Order>) query.list();
    }
    
    //get order by UserId
    public List<Order> getOrdersByUserId(int userId) {
        Query query = getSession().getNamedQuery("Order.getOrdersByUserId");
        query.setInteger("userId", userId);
        return (List<Order>) query.list();
    }
    //get orders by product Id 
    public List<Order> getOrdersByProductId(int productId) {
        Query query = getSession().getNamedQuery("Order.getOrdersByProductId");
        query.setInteger("productId", productId);
        return (List<Order>) query.list();
    }
    //get Oder by orderNo
    public Order getOrderByNo(String orderNo) {
        Criteria criter = getSession().createCriteria(Order.class);
        criter.add(Restrictions.eq("orderNo", orderNo));
        Object result = criter.uniqueResult();
        return result == null ? new Order() : (Order) result;
    }
    
    //update order status
    @Transactional(value = "points", readOnly = false)
    public boolean updateOrderStatus(int id , OrderStatus orderStatus) {
        Query query = getSession().getNamedQuery("Order.updateStatus");
        query.setParameter("orderStatus", orderStatus);
        query.setInteger("id", id);
        return query.executeUpdate() > 0;
    }
    @Transactional(value = "points", readOnly = false)
    public boolean updateOrderStatusByOrderNo(String orderNo, OrderStatus orderStatus) {
        Query query = getSession().getNamedQuery("Order.updateStatusByOrderNo");
        query.setParameter("orderStatus", orderStatus);
        query.setString("orderNo", orderNo);
        return query.executeUpdate() > 0;
    }
    @Transactional(value = "points", readOnly = false)
    public boolean updateOrderLotteryNo(int orderId) {
        Query query = getSession().getNamedQuery("order.updateLotteryNo");
        query.setParameter("orderId", orderId);
        return query.executeUpdate() > 0;
    }
    @Transactional(value = "points", readOnly = false)
    public boolean updateUserId(int sourceId, int targetId) {
        Query query = getSession().getNamedQuery("order.updateUserId");
        query.setInteger("sourceId", sourceId);
        query.setInteger("targetId", targetId);
        return query.executeUpdate() > 0;
    }
    
}
