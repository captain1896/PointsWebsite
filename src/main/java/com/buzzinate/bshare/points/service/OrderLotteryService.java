package com.buzzinate.bshare.points.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.OrderLottery;
import com.buzzinate.bshare.points.dao.OrderLotteryDao;

/**
 * @author james.chen
 * @since 2012-7-20
 */
@Service
public class OrderLotteryService {

    @Autowired
    private OrderLotteryDao lotteryDao;
    // get lottery Order list.
    public List<OrderLottery> getLotterys(int productId) {
        return lotteryDao.getOrderLotterysProduct(productId);
    }
    
    public int createLottery(OrderLottery lottery) {
        return lotteryDao.create(lottery);
    }
    
    public boolean orderLotteryNo(int productId , int orderId) {
        if (!lotteryDao.orderLotteryNo(productId, orderId)) {
            throw new RuntimeException("lottery order error:productId=" + productId + ",orderId=" + orderId);
        }
        return true;
    }
}
