package com.buzzinate.bshare.points.action.shop.order;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.bean.enums.LotteryCategory;
import com.buzzinate.bshare.points.bean.enums.OrderStatus;
import com.buzzinate.bshare.points.util.RandomUtils;


/**
 * @author james.chen
 * @since 2012-7-20
 */
@Controller
@Scope("request")
public class LotteryOrderAction extends AbstractOrderAction {

    private static final long serialVersionUID = -3244736600728835151L;

    /* (non-Javadoc)
     * @see com.buzzinate.bshare.points.action.shop.order.AbstractOrderAction#fillOthers()
     */
    public void fillOthers() {
        if (LotteryCategory.isLottery(product.getId()) && order != null && StringUtils.isBlank(order.getOtherInfo())) {
            //if OlympicLottery set lottery No
            if (LotteryCategory.valueof(product.getId()) == LotteryCategory.OlympicLottery) {
                order.setOtherInfo(RandomUtils.genOlympicLottery());
            }
        }
        if (order.getProdNum() <= 0) {
            order.setProdNum(1);
        }
        order.setOrderPoints((product == null ? 0 : product.getCurrentPoints()) * order.getProdNum());
        order.setOrderStatus(OrderStatus.COMPLETED);
    }
    
    //handle Lottery information
    @Override
    public void handlerOrder() {
        if (isLotteryCoupon()) {
            orderService.orderLottery(order, pointsUser, product);
        }
    }
    
    private boolean isLotteryCoupon() {
        return product == null ? false : product.isLottery();
    }
}
