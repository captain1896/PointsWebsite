package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.PointsOperateHis;
import com.buzzinate.common.dao.PointsDaoBase;
/**
 * PointsOperateHis Dao 
 * handle the Data access object from database
 * @author james.chen
 * @since 2012-6-25
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class PointsOperateHisDao extends PointsDaoBase<PointsOperateHis, Integer> implements Serializable {

    private static final long serialVersionUID = -758732337863623129L;

    public PointsOperateHisDao() {
        super(PointsOperateHis.class , "id");
    }
    
    public List<PointsOperateHis> getOperateHis() {
        Query query  = getSession().createQuery("from PointsOperateHis");
        return (List<PointsOperateHis>) query.list();
    }

}
