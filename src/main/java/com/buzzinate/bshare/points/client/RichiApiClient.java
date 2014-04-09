package com.buzzinate.bshare.points.client;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import com.buzzinate.bshare.points.bean.PointAmount;
import com.buzzinate.bshare.points.exception.RichiApiException;
import com.buzzinate.common.http.SimpleHttp;
import com.buzzinate.common.util.string.StringUtil;
import com.buzzinate.common.util.string.UrlUtil;

/**
 * 
 * @author Johnson Ma
 *
 */
@Component
public class RichiApiClient {
    private static final int MERCHANTID = 15;
    private static final String POINT_ID = "89";
    private static final String MD5_KEY = "jhs8sd8df78gfdds51";
    private static final String TAG = "bshare";
    private static final int ISJSON = 1;
    private static final String GET_CREDIT_URL = "http://test.richi.com/api/GetCredit";
    private static final String DEPOSIT_URL = "http://test.richi.com/api/Deposit";
    private static final String SPEND_URL = "http://test.richi.com/api/Spend";
    private static final String TRANSHISTROY_URL = "http://test.richi.com/api/TransHistory";
    private static final String USERHISTROY_URL = "http://test.richi.com/api/UserHistory";
    private static final String LOGIN_URL = "http://test.richi.com/api/Login";
    
    private SimpleHttp simpleHttp = new SimpleHttp();
    
    /**
     * login on the richi system
     * @param userId
     * @param url
     * @param openIdList
     * @return
     * @throws RichiApiException
     */
    public String login(int userId, String url, String openIdList) throws RichiApiException {
        Map<String, String> parameters = new HashMap<String, String>();
        parameters.put("user_id", String.valueOf(userId));
        parameters.put("url", url);
        if (!StringUtils.isEmpty(openIdList)) {
            parameters.put("openid_list", openIdList);
        }
        String loginUrl = getLoginUrl(LOGIN_URL, parameters);
        try {
            return simpleHttp.doGet(loginUrl);
        } catch (IOException e) {
            throw new RichiApiException(e.getMessage());
        }
    }
    
    /**
     * get the credit amount of the user
     * @param userId
     * @param userName
     * @param openIdList
     * @return amount
     * @throws RichiApiException
     */
    public List<PointAmount> getCredit(int userId, String userName, String openIdList) 
        throws RichiApiException {
        
        Map<String, String> parameters = new HashMap<String, String>();
        parameters.put("point_id", POINT_ID);
        parameters.put("user_id", String.valueOf(userId));
        parameters.put("user_name", userName);
        if (!StringUtils.isEmpty(openIdList)) {
            parameters.put("openid_list", openIdList);
        }
        String url = getRequestUrl(GET_CREDIT_URL, parameters);
        try {
            String json = simpleHttp.doGet(url);
            JSONObject object = new JSONObject(json);

            if (!object.getString("status").equals("00")) {
                throw new RichiApiException(object.getString("msg"));
            }
            JSONObject array = object.getJSONObject("amount");
            List<PointAmount> list = new ArrayList<PointAmount>();
            for (int i = 0; i < array.length(); i++) {
                JSONObject o = array.getJSONObject(String.valueOf(i));
                PointAmount pa = new PointAmount();
                pa.setAmount(o.getString("amount"));
                list.add(pa);
            }
            return list;
        } catch (IOException e) {
            throw new RichiApiException(e.getMessage());
        } catch (JSONException e) {
            throw new RichiApiException(e.getMessage());
        }
    }
    
    /**
     * deposit specified amount for the user
     * @param userId
     * @param userName
     * @param amount
     * @param openIdList
     * @return deposit_no/amount
     * @throws RichiApiException
     */
    public String[] deposit(int userId, String userName, int amount, String openIdList) throws RichiApiException {
        Map<String, String> parameters = new HashMap<String, String>();
        parameters.put("point_id", POINT_ID);
        parameters.put("user_id", String.valueOf(userId));
        parameters.put("user_name", userName);
        parameters.put("amount", String.valueOf(amount));
        String url = getRequestUrl(DEPOSIT_URL, parameters);
        try {
            String json = simpleHttp.doGet(url);
            JSONObject object = new JSONObject(json);
            if (!object.getString("status").equals("00")) {
                throw new RichiApiException(object.getString("msg"));
            }
            String[] record = new String[2];
            record[0] = object.getString("deposit_no");
            record[1] = object.getString("amount");
            return record;
        } catch (IOException e) {
            throw new RichiApiException(e.getMessage());
        } catch (JSONException e) {
            throw new RichiApiException(e.getMessage());
        }
    }
    
    /**
     * deposit specified amount of the user
     * @param userId
     * @param userName
     * @param amount
     * @param openIdList
     * @return spend_no/amount
     * @throws RichiApiException
     */
    public String[] spend(int userId, String userName, int amount, String openIdList) throws RichiApiException {
        Map<String, String> parameters = new HashMap<String, String>();
        parameters.put("point_id", POINT_ID);
        parameters.put("user_id", String.valueOf(userId));
        parameters.put("user_name", userName);
        parameters.put("amount", String.valueOf(amount));
        String url = getRequestUrl(SPEND_URL, parameters);
        try {
            String json = simpleHttp.doGet(url);
            JSONObject object = new JSONObject(json);
            if (!object.getString("status").equals("00")) {
                throw new RichiApiException(object.getString("msg"));
            }
            String[] record = new String[2];
            record[0] = object.getString("spend_no");
            record[1] = object.getString("amount");
            return record;
        } catch (IOException e) {
            throw new RichiApiException(e.getMessage());
        } catch (JSONException e) {
            throw new RichiApiException(e.getMessage());
        }
    }
    
    /**
     * get the trans histroy of specified transNo
     * @param transNo
     * @return trans
     * @throws RichiApiException
     */
    public JSONObject getTransHistroy(String transNo) throws RichiApiException {
        Map<String, String> parameters = new HashMap<String, String>();
        parameters.put("point_id", POINT_ID);
        parameters.put("trans_no", transNo);
        String url = getRequestUrl(TRANSHISTROY_URL, parameters);
        try {
            String json = simpleHttp.doGet(url);
            JSONObject object = new JSONObject(json);
            if (!object.getString("status").equals("00")) {
                throw new RichiApiException(object.getString("msg"));
            }
            return object.getJSONObject("trans");
        } catch (IOException e) {
            throw new RichiApiException(e.getMessage());
        } catch (JSONException e) {
            throw new RichiApiException(e.getMessage());
        }
    }
    
    /**
     * get the trans histroy of the user
     * @param userId
     * @param userName
     * @param openIdList
     * @return trans
     * @throws RichiApiException
     */
    public JSONArray getUserHistroy(int userId, String userName, String openIdList) throws RichiApiException {
        Map<String, String> parameters = new HashMap<String, String>();
        parameters.put("point_id", POINT_ID);
        parameters.put("user_id", String.valueOf(userId));
        parameters.put("user_name", userName);
        if (!StringUtils.isEmpty(openIdList)) {
            parameters.put("openid_list", openIdList);
        }
        String url = getRequestUrl(USERHISTROY_URL, parameters);
        try {
            String json = simpleHttp.doGet(url);
            JSONObject object = new JSONObject(json);
            if (!object.getString("status").equals("00")) {
                throw new RichiApiException(object.getString("msg"));
            }
            return object.getJSONArray("trans");
        } catch (IOException e) {
            throw new RichiApiException(e.getMessage());
        } catch (JSONException e) {
            throw new RichiApiException(e.getMessage());
        }
    }
    
    private String getRequestUrl(String baseUrl, Map<String, String> parameters) {
        parameters.put("merchant_id", String.valueOf(MERCHANTID));
        parameters.put("tag", TAG);
        parameters.put("is_json", String.valueOf(ISJSON));
        return baseUrl + UrlUtil.constructParam(parameters);
    }
    
    private String getLoginUrl(String baseUrl, Map<String, String> parameters) {
        StringBuilder qs = new StringBuilder(); 
        qs.append(MD5_KEY).append('-').append(MERCHANTID).append('-')
                .append(parameters.get("user_id")).append('-')
                .append(parameters.get("url")).append('-');
        if (parameters.containsKey("openid_list")) {
            qs.append(parameters.get("openid_list")).append('-');
        }
        qs.append(TAG);
        String md5 = DigestUtils.md5Hex(StringUtil.urlEncode(qs.toString()));
        parameters.put("merchant_id", String.valueOf(MERCHANTID));
        parameters.put("tag", TAG);
        parameters.put("md5", md5);
        return baseUrl + UrlUtil.constructParam(parameters);
    }

}
