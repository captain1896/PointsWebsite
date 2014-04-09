package com.buzzinate.bshare.points.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.AlipayRecord;
import com.buzzinate.bshare.points.bean.enums.PointsStatModule;
import com.buzzinate.bshare.points.dao.AlipayRecordDao;

/**
 * Alipay record manager service
 * 
 * @author martin
 *
 */
@Service
public class AlipayRecordService implements Serializable {
    
    private static final long serialVersionUID = 6900059769541777569L;
    
    //private static Log log = LogFactory.getLog(AlipayRecordService.class);
    
    @Autowired
    private AlipayRecordDao alipayRecordDao;
    
    @Autowired
    private PointsOperateHisService operateHisService;

    @Transactional(value = "points", readOnly = false)
    public void save(AlipayRecord alipayRecord) {
        alipayRecordDao.saveOrUpdate(alipayRecord);
        //create alipay log record
        operateHisService.createModify(PointsStatModule.ALIPAY, alipayRecord.getId());
    }

    public AlipayRecord read(int paymentOrderInfoId) {
        return alipayRecordDao.read(paymentOrderInfoId);
    }

    public AlipayRecord getOrderInfo(String orderNo) {
        Map<String, Object> matchers = new HashMap<String, Object>();
        matchers.put("tradeNo", orderNo);
        List<AlipayRecord> records = alipayRecordDao.query(matchers);
        if (records != null && records.size() > 0) {
            return records.get(0);
        }
        return null;
    }
    
}
