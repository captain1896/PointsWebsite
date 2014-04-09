package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.AccountRecord;
import com.buzzinate.bshare.points.bean.AccountRecordParam;
import com.buzzinate.bshare.points.bean.enums.AccountRecordType;
import com.buzzinate.common.dao.PointsDaoBase;
import com.buzzinate.common.util.Pagination;

/**
 * Account record Dao
 * 
 * @author martin
 *
 */
@Repository
@SuppressWarnings("unchecked")
@Transactional(value = "points", readOnly = true)
public class AccountRecordDao extends PointsDaoBase<AccountRecord, Integer> implements Serializable {
    
    private static final long serialVersionUID = 1522375643577186596L;

    public AccountRecordDao() {
        super(AccountRecord.class, "id");
    }
    
    public List<AccountRecord> getAccountRecords(AccountRecordParam accountRecordParam, Pagination pagination) {
        String queryName = "accountRecord.getRecords";
        AccountRecordType accountRecordType = accountRecordParam.getAccountRecordType();
        if (accountRecordType != null) {
            queryName += "ByType";
        }
        Query query = getSession().getNamedQuery(queryName);
        query.setInteger("publisherId", accountRecordParam.getUserId());
        query.setDate("startDate", accountRecordParam.getStartDate());
        query.setDate("endDate", accountRecordParam.getEndDate());
        if (accountRecordType != null) {
            query.setInteger("type", accountRecordType.getCode());
        }
        
        if (pagination != null) {
            query.setFirstResult(pagination.getOffset());
            query.setMaxResults(pagination.getPageSize());
        }
        return (List<AccountRecord>) query.list();
    }
    
}
