package com.buzzinate.bshare.points.service.exchange;

import java.io.StringReader;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.buzzinate.bshare.points.bean.Order;
import com.buzzinate.bshare.points.bean.enums.OrderStatus;
import com.buzzinate.bshare.points.service.OrderService;
import com.buzzinate.bshare.points.util.AlipayApiUtil;
import com.buzzinate.common.util.ConfigurationReader;

/**
 * the PointsExchange interface for TaoBao
 * @author james.chen
 * @since 2012-7-3
 */
public class PointsExchangeTaoBao extends AbstractPointsExchange {
    
    public static final String SERVICE_QUERY = ConfigurationReader.getString("bshare.points.tao.querylog");
    public static final String SERVICE_ADD = ConfigurationReader.getString("bshare.points.tao.addpoint");
    public static final String RESULT_FLAG = "//alipay/";
    
    public PointsExchangeTaoBao(OrderService orderService) {
        this.orderService = orderService;
    }
    @Override
    public long getPointsNumByAccountName(String accountName) {
        parameters.put("service", SERVICE_QUERY);
        parameters.put("out_biz_no", accountName);
        return super.getPointsNumByAccountName(accountName);
    }
    @Override
    public String addPointsByAccountName(String accountName , int pointsNum , String outBizNo) {
        parameters.put("service", SERVICE_ADD);
        return super.addPointsByAccountName(accountName, pointsNum, outBizNo);
    }
    
    @Override
    public Object handle(String result , String orderNo) {
        SAXReader saxReader = new SAXReader();
        Document document;
        try {
            document = saxReader.read(new StringReader(result));
        } catch (Exception e) {
            throw new RuntimeException("parse document error" + e.getMessage());
        }
        Order order = null;
        Element rootElement = document.getRootElement();
        // get success flag
        if (SERVICE_ADD.equals(parameters.get("service"))) {
            order = orderService.getOrderByNo(orderNo);
            if (order == null) {
                throw new RuntimeException("handle failed,error orderNo" + orderNo);
            }
            if (AlipayApiUtil.API_SUCCESS.equals(getText(rootElement, "is_success"))) {
                order.setOrderStatus(OrderStatus.COMPLETED);
                order.setOutPointsTradNo(getText(rootElement, "biz_no"));
                orderService.saveOrder(order);
                return getText(rootElement, "biz_no");
            } else {
                orderService.reverseOrder(order, getText(rootElement, "error"));
                return getText(rootElement, "error");
            }
        } else {
            if (AlipayApiUtil.API_SUCCESS.equals(getText(rootElement, "is_success"))) {
                return getText(rootElement, "biz_no");
            } else {
                throw new RuntimeException("handle failed,error,orderNo" + orderNo + ",result" + result);
            }
        }
    }
    
    private String getText(Element rootElement , String name) {
        Element element = (Element) rootElement.selectSingleNode(RESULT_FLAG + name);
        return element == null ? "" : element.getTextTrim();
    }
}
