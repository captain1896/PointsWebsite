package com.buzzinate.bshare.points.service.exchange;

import org.springframework.stereotype.Component;

import com.buzzinate.bshare.points.bean.enums.PointsCategory;
import com.buzzinate.bshare.points.service.OrderService;

/**
 * points Exchange Factory to product all kinds of Points change interface
 * @author james.chen
 * @since 2012-7-3
 */
@Component
public class PointsExchangeFactory {

    public PointsExchangeFactory() {

    }

    public PointsExchange getIntance(PointsCategory cate, OrderService orderService) {
        if (PointsCategory.TAOBAO == cate) {
            return new PointsExchangeTaoBao(orderService);
        }
        throw new RuntimeException("not suppore this Cateogry=" + cate);
    }
}
