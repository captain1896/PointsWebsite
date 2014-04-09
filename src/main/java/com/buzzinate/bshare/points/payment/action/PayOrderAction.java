package com.buzzinate.bshare.points.payment.action;

import static com.buzzinate.payment.PayConfig.PAYMENT_FAIL;
import static com.buzzinate.payment.PayConfig.PAYMENT_SUCCEED;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.bean.AlipayRecord;
import com.buzzinate.bshare.points.bean.enums.TradeStatus;
import com.buzzinate.bshare.points.service.AccountService;
import com.buzzinate.bshare.points.service.AlipayRecordService;
import com.buzzinate.bshare.user.bean.User;
import com.buzzinate.bshare.user.service.LoginHelper;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.string.StringUtil;
import com.buzzinate.payment.OrdernoGenerator;
import com.buzzinate.payment.PayConfig;
import com.buzzinate.payment.alipay.config.AlipayConfig;
import com.buzzinate.payment.alipay.util.AlipayBase;
import com.buzzinate.payment.alipay.util.AlipayNotify;
import com.buzzinate.payment.alipay.util.AlipayService;
import com.buzzinate.payment.bean.PaymentOrderInfo;
import com.buzzinate.payment.service.PayOrderService;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Martin
 */
@Controller
public class PayOrderAction extends ActionSupport implements SessionAware,
        ServletRequestAware {

    private static final long serialVersionUID = -8576195730548063047L;

    private static final Log LOG = LogFactory.getLog(PayOrderAction.class);

    private static final int POUNDAGE_RATE = ConfigurationReader.getInt("bshare.points.poundage.rate", 12);
    
    private static DecimalFormat format = new DecimalFormat("########0.00");
    
    @Autowired
    private PayOrderService payOrderService;
    @Autowired
    private LoginHelper loginHelper;
    @Autowired
    private AlipayRecordService alipayRecordService;
//    @Autowired
//    private AccountRecordService accountRecordService;
    @Autowired
    private AccountService accountService;
    
    private HttpServletRequest request;
    private Map<String, Object> session;

    private int amount;
    private int recordId;
    private int points;

    private int id;

    private String paymentUrl;
    
    public int getRecordId() {
        return recordId;
    }
    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }
    public int getAmount() {
        return amount;
    }
    public void setAmount(int amount) {
        this.amount = amount;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getId() {
        return id;
    }
    public String getPaymentUrl() {
        return paymentUrl;
    }
    public void setPaymentUrl(String paymentUrl) {
        this.paymentUrl = paymentUrl;
    }
    public int getPoints() {
        return points;
    }
    public void setPoints(int points) {
        this.points = points;
    }

    /**
     * @return
     */
    public String generateOrderInfo() {
        User user = loginHelper.getUser();
        if (user == null) {
            // this shouldnt happen, the security filter will catch non-logged
            // in users.
            return Action.ERROR;
        }
        AlipayRecord alipayRecord = getOrderInfo(user);
        alipayRecordService.save(alipayRecord);
        request.setAttribute("orderNo", alipayRecord.getTradeNo());
        request.setAttribute("orderInfo", alipayRecord);
        return Action.SUCCESS;
    }

    public String loadOrderInfo() {
        User user = loginHelper.getUser();
        if (user == null) {
            // this shouldnt happen, the security filter will catch non-logged
            // in users.
            return Action.ERROR;
        }

        PaymentOrderInfo p = this.payOrderService.read(id);
        if (p == null) {
            this.addActionError(getText("bshare.shopping.cart.invalid.order.id"));
            return Action.ERROR;
        }
        if (p.getUserId() != user.getUserID()) {
            this.addActionError(getText("bshare.shopping.cart.invalid.user"));
            return Action.ERROR;
        }
        request.setAttribute("orderNo", p.getOrderNo());
        request.setAttribute("paymentOrderInfo", p);
        return Action.SUCCESS;
    }

    /**
     * Loads the current user's completed order history...
     * 
     * @return
     */
    public String loadOrderHistory() {
        int userId = loginHelper.getUserID();
        List<PaymentOrderInfo> poiList = payOrderService
                .getPaymentOrderInfoByUserId(userId, PayConfig.PAYMENT_SUCCEED);
        // Collections.reverse(poiList);

        request.setAttribute("poiList", poiList);
        return Action.SUCCESS;
    }

    /**
     * Checkout the user payment.
     * 
     * @return
     */
    public String checkout() {
        String paymentOrderInfoIdStr = request
                .getParameter("paymentOrderInfoId");
        String paygateId = request.getParameter("paygateId");

        int paymentOrderInfoId = 0;
        try {
            paymentOrderInfoId = Integer.parseInt(paymentOrderInfoIdStr);
        } catch (Exception e) {
            // invalid id given... was probably hacked
            request.setAttribute("paymentOrderInfo", new PaymentOrderInfo());
            addActionError(getText("bshare.shopping.cart.invalid.order.id"));
            return Action.ERROR;
        }

        int iPaygateId = PayConfig.PAYGATE_ALIPAY;
        try {
            iPaygateId = Integer.parseInt(paygateId);
        } catch (Exception e) {
            LOG.error("error ignore");
            // ignore for now... every order will be alipay.
        }

        AlipayRecord alipayRecord = alipayRecordService.read(paymentOrderInfoId);
        if (alipayRecord == null) {
            request.setAttribute("paymentOrderInfo", new PaymentOrderInfo());
            addActionError(getText("bshare.shopping.cart.invalid.order.id"));
            return Action.ERROR;
        }

        if (PayConfig.PAYGATE_ALIPAY == iPaygateId) {
            this.paymentUrl = alipayURL(alipayRecord);
            return "redirect";
        }

        // invalid payment gateway...
        request.setAttribute("paymentOrderInfo", alipayRecord);
        addActionError(getText("bshare.shopping.cart.invalid.payment.gateway"));
        return Action.ERROR;
    }

    private String alipayURL(AlipayRecord alipayRecord) {

        String inputCharset = AlipayConfig.CHAR_SET;
        String signType = AlipayConfig.SIGN_TYPE;
        String sellerEmail = AlipayConfig.SELLER_EMAIL;
        String partner = AlipayConfig.PARTNER_ID;
        String key = AlipayConfig.KEY;

        String showUrl = AlipayConfig.SHOW_URL;
        String notifyUrl = AlipayConfig.POINTS_NOTIFY_URL;
        String returnUrl = AlipayConfig.POINTS_RETURN_URL;

        String antiphishing = AlipayConfig.ANTIPHISHING;

        // /////////////////////////////////////////////////////////////////////////////////
        // 订单名称，显示在支付宝收银台里的“商品名称”里，显示在支付宝的交易管理的“商品名称”的列表里。
        String subject = getText("bshare.points.name");
        // 订单描述、订单详细、订单备注，显示在支付宝收银台里的“商品描述”里
        String body = subject;

        // 以下参数是需要通过下单时的订单数据传入进来获得
        // 必填参数
        // 请与贵网站订单系统中的唯一订单号匹配
        String outTradeNoIsOurOrderNo = alipayRecord.getTradeNo();
        // 订单总金额，显示在支付宝收银台里的“应付总额”里
        String totalFee = format.format(alipayRecord.getAmount() / 100.0);

        // 扩展功能参数——网银提前
        // 默认支付方式，四个值可选：bankPay(网银);
        // cartoon(卡通); directPay(余额);
        // CASH(网点支付)
        String paymethod = "directPay";
     // 默认网银代号，代号列表见http://club.alipay.com/read.php?tid=8681379
        String defaultbank = ""; 

        // 扩展功能参数——防钓鱼
     // 防钓鱼时间戳，初始值
        String encryptKey = ""; 
     // 客户端的IP地址，初始值
        String exterInvokeIp = ""; 
        if (antiphishing.equals("1")) {
            try {
                encryptKey = AlipayBase.queryTimestamp(partner);
            } catch (MalformedURLException e) {
                LOG.error(e);
            } catch (DocumentException e) {
                LOG.error(e);
            } catch (IOException e) {
                LOG.error(e);
            }
         // 获取客户端的IP地址，建议：编写获取客户端IP地址的程序
            exterInvokeIp = ""; 
        }

        // 扩展功能参数——其他
     // 自定义参数，可存放任何内容（除=、&等特殊字符外），不会显示在页面上
        String extraCommonParam = ""; 
     // 默认买家支付宝账号
        String buyerEmail = "";

        // 扩展功能参数——分润(若要使用，请按照注释要求的格式赋值)
     // 提成类型，该值为固定值：10，不需要修改
        String royaltyType = ""; 
        String royaltyParameters = "";

        // 扩展功能参数——自定义超时(若要使用，请按照注释要求的格式赋值)
        // 该功能默认不开通，需联系客户经理咨询
        // 超时时间，不填默认是15天。八个值可选：1h(1小时),2h(2小时),3h(3小时),1d(1天),3d(3天),7d(7天),15d(15天),1c(当天)
        String itBPay = "";

        // ///////////////////////////////////////////////////////////////////////////////////////////////////

        // build redirect
        String paygateUrl = AlipayService.createUrl(partner, sellerEmail,
                returnUrl, notifyUrl, showUrl, outTradeNoIsOurOrderNo, subject,
                body, totalFee, paymethod, defaultbank, encryptKey,
                exterInvokeIp, extraCommonParam, buyerEmail, royaltyType,
                royaltyParameters, itBPay, inputCharset, key, signType);

        return paygateUrl;
    }

    /**
     * 从request中获取数据，封装PaymentOrderInfo 对象.
     * 
     * @param user
     *            the user info.
     * @return
     */
    private AlipayRecord getOrderInfo(User user) {
        AlipayRecord value = new AlipayRecord();
        Date date = new Date();
        value.setPoints(points);
        value.setAmount(new BigDecimal(points * (POUNDAGE_RATE + 100)).setScale(0, BigDecimal.ROUND_HALF_UP)
                .intValue());
        value.setPoundage(POUNDAGE_RATE);
        value.setCreateTime(date);
        value.setPaymentTime(date);
        value.setTradeNo(OrdernoGenerator.generateOrderNo());
        value.setRecordId(recordId);
        value.setTradeStatus(TradeStatus.WAITPAY);

        // the page view will use it atttibute's value.
        request.setAttribute("orderNo", value.getTradeNo());
        request.setAttribute("paymentOrderInfo", value);

        return value;
    }

    /**
     * From Alipay return trade tag and other we need informations.
     * 
     * @return
     */
    public String returnURL() {
        String key = AlipayConfig.KEY;
        // 获取支付宝GET过来反馈信息
        Map<String, String> keysAndValues = getValuesFromAlipay();

        // 判断responsetTxt是否为ture，生成的签名结果mysign与获得的签名结果sign是否一致
        // responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
        // mysign与sign不等，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
        String mysign = AlipayNotify.getMysign(keysAndValues, key);
        String responseTxt = AlipayNotify.verify(request
                .getParameter("notify_id"));
        String sign = request.getParameter("sign");
        // 获取支付宝的通知返回参数
     // 支付宝交易号
        String tradeNo = request.getParameter("trade_no"); 
     // 获取订单号
        String orderNo = request.getParameter("out_trade_no"); 
        // 交易状态
        String tradeStatus = request.getParameter("trade_status");

        debug(keysAndValues, mysign, responseTxt, sign);

        if (mysign.equals(sign) && responseTxt.equals("true")) {

            if (tradeStatus.equals("TRADE_FINISHED") || tradeStatus.equals("TRADE_SUCCESS")) {
                // 为了保证不被重复调用，或重复执行数据库更新程序，请判断该笔交易状态是否是订单未处理状态
                // 根据订单号更新订单，把订单状态处理成交易成功
                updateOrderInfo(orderNo, tradeNo, PAYMENT_SUCCEED);
                return Action.SUCCESS;
            } else {
                updateOrderInfo(orderNo, tradeNo, PAYMENT_FAIL);
                return tipErrorInfo();
            }
        } else {
            return tipErrorInfo();
        }
    }

    private String tipErrorInfo() {
        this.addActionError(getText("bshare.payment.failure.error.message"));
        return Action.ERROR;
    }


    /**
     * Get the values from Alipay.
     * 
     * @return
     */
    @SuppressWarnings("rawtypes")
    private Map<String, String> getValuesFromAlipay() {
        Map<String, String> keysAndValues = new HashMap<String, String>();
        Map requestParams = request.getParameterMap();
        for (Iterator iterator = requestParams.keySet().iterator(); iterator.hasNext();) {
            String name = (String) iterator.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
            }
            if ("subject".equals(name) || "body".equals(name)) {
                valueStr = StringUtil.convertLatin2Utf8(valueStr);
            }
            keysAndValues.put(name, valueStr);
        }
        return keysAndValues;
    }

    /**
     * 更新订单信息，并发送email通知用户
     * 
     * @param orderNo
     *            the order info number.
     * @param outTradeNo
     *            from paygate's trade no.
     * @param paymentStatus 
     */
    private void updateOrderInfo(String orderNo, String outTradeNo, int paymentStatus) {
        AlipayRecord alipayRecord = alipayRecordService.getOrderInfo(orderNo);
        if (alipayRecord == null) {
            // 没找到相应的订单，记录到日志中，以备查询.
            LOG.warn("系统中没找到订单号:[" + orderNo + "]相应的订单!");
            return;
        }
        
        if (paymentStatus == PAYMENT_SUCCEED) {
        	accountService.createAndCharge(loginHelper.getUserId(), alipayRecord);
        }
    }

    /**
     * Just for debug.
     * 
     * @param params
     * @param mysign
     * @param responseTxt
     * @param sign
     */
    private void debug(Map<String, String> params, String mysign,
            String responseTxt, String sign) {
        // 调试支付宝返回结果,写入日志
        if (LOG.isDebugEnabled()) {
            final StringBuilder str = new StringBuilder();
            str.append("responseTxt=").append(responseTxt).append("\n ");
            str.append("return_url_log:sign=").append(sign).append("&mysign=")
                    .append(mysign).append("\n ");
            str.append("return回来的参数：").append(
                    AlipayBase.createLinkString(params));

            LOG.debug(str);
        }
    }


    @Override
    public void setServletRequest(HttpServletRequest requestR) {
        this.request = requestR;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    public Map<String, Object> getSession() {
        return session;
    }

}