package com.buzzinate.bshare.points.dao;

import java.io.Serializable;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.AlipayRecord;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * Alipay record Dao
 * 
 * @author martin
 *
 */
@Repository
@Transactional(value = "points", readOnly = true)
public class AlipayRecordDao extends PointsDaoBase<AlipayRecord, Integer> implements Serializable {
    
    private static final long serialVersionUID = 3618242886439775316L;

    public AlipayRecordDao() {
        super(AlipayRecord.class, "id");
    }
}
