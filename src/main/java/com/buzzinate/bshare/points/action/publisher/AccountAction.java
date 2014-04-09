package com.buzzinate.bshare.points.action.publisher;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.Account;
import com.buzzinate.bshare.points.bean.AccountRecord;
import com.buzzinate.bshare.points.bean.AccountRecordParam;
import com.buzzinate.bshare.points.bean.enums.AccountRecordType;
import com.buzzinate.bshare.points.service.AccountRecordService;
import com.buzzinate.bshare.points.service.AccountService;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.DateTimeUtil;
import com.buzzinate.common.util.JsonResults;
import com.opensymphony.xwork2.Action;

/**
 * 账户页面
 * 
 * @author magic
 *
 */
@Controller
@Scope("request")
public class AccountAction extends BaseAction {

    private static final long serialVersionUID = -2669290182630450529L;
    
    private static final double POUNDAGE = ConfigurationReader.getDouble("bshare.points.poundage", 1.12);

    @Autowired
    private AccountService accountService;
    @Autowired
    private AccountRecordService accountRecordService;
    
    private Account account;
    private List<AccountRecord> accountRecords;
    
    private String startDay;
    private String endDay;
    
    private JsonResults results;
    
    public String execute() throws Exception {
        if (!loginHelper.isLoginAsPointsPublisher()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        
        // 账户基本信息
        account = accountService.findAccount(getCurrentUserId());
        
        initDateRange();
        
        request.setAttribute("poundage", POUNDAGE);
        request.setAttribute("poundageValue", (int) ((POUNDAGE - 1) * 100));
        
        return SUCCESS;
    }
    
    /**
     * 查找账户的全部类型记录
     * @return
     */
    public String records() {
        if (!loginHelper.isLoginAsPointsPublisher()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        return getRecords(null);
    }
    
    /**
     * 查找账户的充值记录
     * 
     * @return
     */
    public String chargeRecords() {
        if (!loginHelper.isLoginAsPointsPublisher()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        return getRecords(AccountRecordType.CHARGE);
    }
    
    /**
     * 查找账户的消费记录
     * 
     * @return
     */
    public String usedRecords() {
        if (!loginHelper.isLoginAsPointsPublisher()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        return getRecords(AccountRecordType.DEDUCT);
    }
    
    /**
     * 根据条件查找账户记录
     * 
     * @param accountRecordType
     * @return
     */
    private String getRecords(AccountRecordType accountRecordType) {
        if (!loginHelper.isLoginAsPointsPublisher()) {
            addActionError(getText("bshare.points.permission.unauthorized"));
            return Action.ERROR;
        }
        if (startDay == null && endDay == null) {
            initDateRange();
        } 
        Date startDate = DateTimeUtil.convertDate(startDay);
        Date endDate = DateTimeUtil.convertDate(endDay);
        AccountRecordParam accountRecordParam = new AccountRecordParam(startDate, 
                DateTimeUtil.plusDays(endDate, 1), getCurrentUserId(), accountRecordType);
        accountRecords = accountRecordService.getAccountRecords(accountRecordParam, null);
        
        results = new JsonResults();
        results.addContent("accountRecords", accountRecords);
        
        return JsonResults.JSON_RESULT_NAME;
    }
    
    /**
     * 初始化开始和结束日期
     */
    private void initDateRange() {
        Date endDate = DateTimeUtil.getCurrentDate();
        Date startDate = DateTimeUtil.plusMonths(endDate, -1);
        
        startDay = DateTimeUtil.formatDate(startDate);
        endDay = DateTimeUtil.formatDate(endDate);
    }
    

    public Account getAccount() {
        return account;
    }

    public List<AccountRecord> getAccountRecords() {
        return accountRecords;
    }

    public String getStartDay() {
        return startDay;
    }

    public void setStartDay(String startDay) {
        this.startDay = startDay;
    }

    public String getEndDay() {
        return endDay;
    }

    public void setEndDay(String endDay) {
        this.endDay = endDay;
    }

    public JsonResults getResults() {
        return results;
    }

    public void setResults(JsonResults results) {
        this.results = results;
    }

}
