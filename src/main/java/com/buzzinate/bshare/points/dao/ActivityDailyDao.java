package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.common.dao.SimpleBaseDao;

/**
 * Analytics Dao
 * 
 * @author martin
 *
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class ActivityDailyDao extends SimpleBaseDao implements Serializable  {

    private static final long serialVersionUID = -2796735129696949617L;
    
    public List<Object[]> getStatisticByDay(List<byte[]> uuids, Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getStatisticByDay");
        query.setParameterList("uuids", uuids);
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }
    
    public List<Object[]> getStatisticByPlatform(List<byte[]> uuids, Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getStatisticByPlatform");
        query.setParameterList("uuids", uuids);
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }
    
    public List<Object[]> getStatisticByActivityId(List<byte[]> uuids, Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getStatisticByActivityId");
        query.setParameterList("uuids", uuids);
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }
    
    public List<Object[]> getDailyStatisticByActivityId(int activityId, Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getDailyStatisticByActivityId");
        query.setInteger("activityId", activityId);
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }

    public List<Object[]> getDailyStatisticByActivityIds(String[] ids, Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getDailyStatisticByActivityIds");
        query.setParameterList("ids", ids);
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }

    public List<Object[]> getPlatformStatisticByActivityId(int activityId, Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getPlatformStatisticByActivityId");
        query.setInteger("activityId", activityId);
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }

    public List<Object[]> getPlatformStatisticByUserId(List<byte[]> uuids, Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getPlatformStatisticByUserId");
        query.setParameterList("uuids", uuids);
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }

    public List<Object[]> getDailyStatistic(Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getDailyStatistic");
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }

    public List<Object[]> getPlatformStatistic(Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getPlatformStatistic");
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }

    public List<Object[]> getActivityStatistic(Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getActivityStatistic");
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return (List<Object[]>) query.list();
    }

    public List<Object[]> getActivityStatisticByIds(byte[] uuid, Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("ActivityDaily.getActivityStatisticByIds");
        query.setBinary("uuid", uuid);
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return query.list();
    }

}
