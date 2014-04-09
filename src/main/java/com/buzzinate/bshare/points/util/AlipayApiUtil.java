package com.buzzinate.bshare.points.util;

import java.io.IOException;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.buzzinate.common.http.SimpleHttp;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.string.UrlUtil;

/**
 * alipay api util class
 * 
 * 辅助构造一些通用参数，及发送API请求
 * 
 * @author magic
 *
 */
public final class AlipayApiUtil {

    // Alipay API Base URL
    public static final String BASE_URL = ConfigurationReader.getString("bshare.points.tao.baseurl");
    // Partner ID
    public static final String PARTNER_ID = ConfigurationReader.getString("bshare.points.tao.partnerid");
    // Security Code
    public static final String SECURITY_CODE = ConfigurationReader.getString("bshare.points.tao.securitycode");
    // default sign type
    public static final String SIGN_TYPE = "MD5";
    // default charset
    public static final String DEFAULT_CHARSET = "utf-8";
    
    public static final String API_SUCCESS = "T";
    public static final String API_FAIL = "F";

    private static Log log = LogFactory.getLog(AlipayApiUtil.class);
    
    private AlipayApiUtil() {
    }
    
    /**
     * 给Alipay发送API请求
     * 
     * @param parameters    请求的参数
     * 
     * @return  返回请求的结果；如果发送http失败，返回运行时异常
     */
    public static String sendRequest(Map<String, String> parameters) {
        String requestUrl = getApiRequestUrl(parameters);
        SimpleHttp http = new SimpleHttp();
        try {
            return http.doGet(requestUrl);
        } catch (IOException e) {
            log.error("http request: " + requestUrl, e);
            throw new RuntimeException("send request error : " + e.getMessage());
        }
    }
    
    /**
     * 根据参数列表，构造Alipay的请求URL
     * 
     * @param parameters    请求的参数；注意一些通用参数就不需要设置了，方法会自动添加上
     * 
     * 通用参数包括：sign, sign_type, partner, _input_charset
     * 
     * @return
     */
    public static String getApiRequestUrl(Map<String, String> parameters) {
        parameters.put("_input_charset", DEFAULT_CHARSET);
        parameters.put("partner", PARTNER_ID);
        
        // 计算sign值
        String sign = UrlUtil.getMD5Sign(parameters, SECURITY_CODE);
        parameters.put("sign_type", SIGN_TYPE);
        parameters.put("sign", sign);

        return UrlUtil.appendParamsToUrl(BASE_URL, parameters);
    }

}
