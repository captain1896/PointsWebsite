package com.buzzinate.bshare.points.service.exchange;

import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.lang.StringUtils;

import com.buzzinate.bshare.points.service.OrderService;
import com.buzzinate.bshare.points.util.AlipayApiUtil;

/**
 * handle the PointsExchange process.
 * @author james.chen
 * @since 2012-7-3
 */
public abstract class AbstractPointsExchange implements PointsExchange {
    
    public static final String USER_NOT_EXIST = "USER_NOT_EXIST";
    
    protected OrderService orderService;
    
    protected Map<String, String> parameters;

    public AbstractPointsExchange() {
        parameters = getParameters();
    }
    
    public long getPointsNumByAccountName(String accountName) {
        String content;
        try {
            content = AlipayApiUtil.sendRequest(parameters);
        } catch (Exception e) {
            throw new RuntimeException("doGet error:" + e.getMessage());
        }
        String result = handle(content, "").toString();
        return StringUtils.isBlank(result) ? 0 : Long.valueOf(result);
    }

    public String addPointsByAccountName(String accountName , int pointsNum , String outBizNo) {
        //add new parameter
        parameters.put("amount", String.valueOf(pointsNum));
        parameters.put("logon_id", accountName);
        parameters.put("out_biz_no", outBizNo);
        String content;
        try {
            content = AlipayApiUtil.sendRequest(parameters);
        } catch (Exception e) {
            throw new RuntimeException("doGet error:" + e.getMessage());
        }
        //handle return result.
        return handle(content, outBizNo).toString();
    }
    
    protected Map<String, String> getParameters() {
        return new TreeMap<String, String>();
    }

    public void setParameters(Map<String, String> parameters) {
        this.parameters = parameters;
    }
    
    protected Object handle(String result , String orderNo) {
        return new Object();
    }
    
}
