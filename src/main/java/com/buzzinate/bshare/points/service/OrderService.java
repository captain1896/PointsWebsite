package com.buzzinate.bshare.points.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.Order;
import com.buzzinate.bshare.points.bean.OrderLottery;
import com.buzzinate.bshare.points.bean.PointsProduct;
import com.buzzinate.bshare.points.bean.PointsUser;
import com.buzzinate.bshare.points.bean.enums.LotteryCategory;
import com.buzzinate.bshare.points.bean.enums.OrderStatus;
import com.buzzinate.bshare.points.bean.enums.PointsCategory;
import com.buzzinate.bshare.points.bean.enums.PointsStatModule;
import com.buzzinate.bshare.points.dao.OrderDao;
import com.buzzinate.bshare.points.service.exchange.PointsExchange;
import com.buzzinate.bshare.points.service.exchange.PointsExchangeFactory;
import com.buzzinate.bshare.points.util.RandomUtils;
import com.buzzinate.common.util.Pagination;
/**
 * the Order Service class
 * @author james.chen
 * @since 2012-6-12
 */
@Service
@SuppressWarnings("unchecked")
public class OrderService implements Serializable {
    
    private static final long serialVersionUID = 8480457705074034099L;
    
    private static Log log = LogFactory.getLog(OrderService.class);

    @Autowired
    private OrderDao orderDao;
    @Autowired
    private OrderLotteryService lotteryService;
    @Autowired
    private PointsUserService pointUserService;
    @Autowired
    private PointsProductService productService;
    @Autowired
    private PointsOperateHisService hisService;
    @Autowired
    private PointsExchangeFactory factory;

    //get pagination list
    public List<Order> getPaginationOrders(Pagination pagination , int orderStatus) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("orderStatus", OrderStatus.getCurrent(orderStatus));
        return fullOrder((List<Order>) orderDao.getNameQueryPagination("Order.getOrders", params, pagination));
    }
    //get total count
    public long getOrdersCount(int orderStatus) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("orderStatus", OrderStatus.getCurrent(orderStatus));
        return orderDao.getNameQueryCount("Order.getCountOrders", params);
    }

    private List<Order> fullOrder(List<Order> orders) {
        List<Order> results = new ArrayList<Order>();
        for (Order order : orders) {
            order.setProduct(productService.getProductById(order.getProductId()));
            results.add(order);
        }
        return results;
    }
    //get user order list
    public List<Order> getOrdersByUserId(int userId) {
        return fullOrder(orderDao.getOrdersByUserId(userId));
    }
    // get product order list
    public List<Order> getOrdersByProductId(int productId) {
        return fullOrder(orderDao.getOrdersByProductId(productId));
    }
    @Transactional(value = "points", readOnly = false)
    public void order(Order order , PointsUser pointsUser , PointsProduct product) {
        // --1 update pointUser info
        pointUserService.updatePointUser(pointsUser, order.getOrderPoints());
        // --2.update product info
        productService.updateProductSell(order.getProdNum(), order.getProductId());
        // --3 generate order transfer record
        orderDao.create(order);
        
    }

    @Transactional(value = "points", readOnly = false)
    public void orderLottery(Order order , PointsUser pointsUser , PointsProduct product) {
        // order product
        order(order, pointsUser, product);
        // generate lottery
        if (product.isLimit()) {
            // to check whether can order a lotteryNo
            // order LotterNo first
            lotteryService.orderLotteryNo(order.getProductId(), order.getId());
            // update order lotterNo
            orderDao.updateOrderLotteryNo(order.getId());
        } else {
            // if lottery No no limit
            lotteryService.createLottery(new OrderLottery(order));
        }
    }
    
    /**Order points
     * 1.generate order record
     * 2.exchange points with third points
     * 3.check Order again.
     * @param order
     * @param pointsUser
     * @param product
     */
    public Order orderPoints(Order order , PointsUser pointsUser , PointsProduct product) {
        order(order, pointsUser, product);
        exchangePoints(order);
        Order result = getOrderByNo(order.getOrderNo());
        return result;
    }
    
    //exchange points by points API
    public void exchangePoints(Order order) {
        if (PointsCategory.isPointsCategory(order.getProductId())) {
            PointsExchange exchange = factory.getIntance(PointsCategory.valueOf(order.getProductId()), this);
            exchange.addPointsByAccountName(order.getOtherInfo(), order.getProdNum(), order.getOrderNo());
        }
    }

    // this method will reverse Order by No
    @Transactional(value = "points", readOnly = false)
    public void reverseOrder(Order order , String reverseReason) {
        if (order == null || order.getId() == 0) {
            return;
        }
        // --1 reverse pointUser info
        pointUserService.updatePointUser(new PointsUser(order.getUserId()), -order.getOrderPoints());
        // --2.update product info
        productService.updateProductSell(-order.getProdNum(), order.getProductId());
        // update order
        order.setOrderStatus(OrderStatus.DELETED);
        order.setOutPointsTradNo(reverseReason);
        order.setProdNum(0);
        order.setOrderPoints(0);
        orderDao.update(order);
    }
    //update order status
    @Transactional(value = "points", readOnly = false)
    public boolean updateOrderStatus(int id , OrderStatus orderStatus) {
        boolean success = orderDao.updateOrderStatus(id, orderStatus);
        if (success) {
            hisService.createModify(PointsStatModule.ORDER, id);
        }
        return success;
    }
    
    public void saveOrder(Order order) {
        orderDao.saveOrUpdate(order);
    }

    public Order getOrderById(int id) {
        return orderDao.read(id);
    }
    
    public Order getOrderByNo(String orderNo) {
        return orderDao.getOrderByNo(orderNo);
    }
    //get Order by User Id of Pagination.
    public List<Order> getOrdersByUserIdPagination(int userId , Pagination pagination) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", userId);
        return fullOrder(orderDao.getNameQueryPagination("Order.getOrdersByUserIdPagination", params, pagination));
    }
    //get order count by user id of Pagination
    public long getOrdersByUserIdCount(int userId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", userId);
        return orderDao.getNameQueryCount("Order.getOrdersByUserIdCount", params);
    }
    public boolean updateUserId(int sourceId, int targetId) {
        return orderDao.updateUserId(sourceId, targetId);
    }
    
    public void fill(Order order) {
        order.setOrderNo(RandomUtils.genOrderNo());
        order.setOrderTime(new Date());
        order.setOrderStatus(OrderStatus.COMPLETED);
    }
    
    public void orderActivityInternal(Order order) {
        try {
            PointsProduct product = productService.get(order.getProductId());
            if (product == null || product.getId() <= 0) {
                throw new RuntimeException("ivalid product productId=" + order.getProductId());
            }
            PointsUser currentUser = pointUserService.getPointsByUserId(order.getUserId());
            if (currentUser == null || currentUser.getUserId() <= 0) {
                throw new RuntimeException("ivalid pointsUser userId=" + order.getUserId());
            }
            fill(order);
            if (product.isLottery()) {
                if (LotteryCategory.isLottery(product.getId())) {
                    order.setOtherInfo(RandomUtils.genOlympicLottery());
                }
                orderLottery(order, currentUser, product);
            }
        } catch (Exception e) {
            log.error("internal Order Activity error", e);
        }
    }
}
