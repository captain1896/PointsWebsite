package com.buzzinate.bshare.points.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.AccountRecord;
import com.buzzinate.bshare.points.bean.AccountRecordParam;
import com.buzzinate.bshare.points.bean.enums.PointsStatModule;
import com.buzzinate.bshare.points.dao.AccountRecordDao;
import com.buzzinate.common.util.Pagination;

/**
 * 
 * 账户记录Service
 * 
 * @author magic
 *
 */
@Service
public class AccountRecordService {

    @Autowired
    private AccountRecordDao accountRecordDao;
    @Autowired
    private PointsOperateHisService operateHisService;
    
    /**
     * 根据过滤条件，获取符合条件的账户记录
     * 
     * @param accountRecordParam
     * @param pagination
     * @return
     */
    public List<AccountRecord> getAccountRecords(AccountRecordParam accountRecordParam, Pagination pagination) {
        return accountRecordDao.getAccountRecords(accountRecordParam, pagination);
    }
    
    public int create(AccountRecord accountRecord) {
        int recordId = accountRecordDao.create(accountRecord);
        operateHisService.createAdd(PointsStatModule.ACCOUNTRECORD, recordId);
        return recordId;
    }

    public AccountRecord read(int recordId) {
        return accountRecordDao.read(recordId);
    }

}
