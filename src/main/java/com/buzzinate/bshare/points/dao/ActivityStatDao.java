package com.buzzinate.bshare.points.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.ActivityStatNo;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * @author james.chen
 * @since 2012-8-24
 */
@Repository
@Transactional(value = "points", readOnly = true)
public class ActivityStatDao extends PointsDaoBase<ActivityStatNo, Integer> {

    public ActivityStatDao() {
        super(ActivityStatNo.class, "id");
    }
    @Transactional(value = "points", readOnly = false)
    public void createStatNo(ActivityStatNo statNo) {
        Query query = getSession().getNamedQuery("ActivityStatNo.insertStat");
        query.setInteger("activityId", statNo.getActivityId());
        query.setInteger("recordId", statNo.getRecordId());
        query.setInteger("statType", statNo.getStatType().getCode());
        query.setInteger("totalNo", statNo.getTotalNo());
        query.executeUpdate();
    }
    @Transactional(value = "points", readOnly = false)
    public boolean updateStatNo(ActivityStatNo statNo , int limitNo) {
        Query query = getSession().getNamedQuery("ActivityStatNo.ircounterNo");
        query.setInteger("activityId", statNo.getActivityId());
        query.setInteger("recordId", statNo.getRecordId());
        query.setInteger("statType", statNo.getStatType().getCode());
        query.setInteger("limitNo", limitNo);
        return query.executeUpdate() > 0;
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean updateStatNoById(int id , int limitNo) {
        Query query = getSession().getNamedQuery("ActivityStatNo.ircounterNoById");
        query.setInteger("id", id);
        query.setInteger("limitNo", limitNo);
        return query.executeUpdate() > 0;
    }
    
    public long getTotalNo(ActivityStatNo statNo) {
        ActivityStatNo exists = getByActivityNo(statNo);
        return exists.getTotalNo();
    }
    
    @SuppressWarnings("unchecked")
    public ActivityStatNo getByActivityNo(ActivityStatNo statNo) {
        Criteria criteria = getSession().createCriteria(ActivityStatNo.class);
        criteria.add(Restrictions.eq("activityId", statNo.getActivityId()));
        criteria.add(Restrictions.eq("recordId", statNo.getRecordId()));
        criteria.add(Restrictions.eq("statType", statNo.getStatType()));
        criteria.add(Restrictions.eq("currentDate", statNo.getCurrentDate()));
        List<ActivityStatNo> result = (List<ActivityStatNo>) criteria.list();
        return result.size() > 0 ? result.get(0) : new ActivityStatNo();
    }
}
