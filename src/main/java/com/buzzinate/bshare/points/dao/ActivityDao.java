package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.safehaus.uuid.UUID;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.ActivityLimitRule;
import com.buzzinate.bshare.points.bean.enums.ActivityCategory;
import com.buzzinate.bshare.points.bean.enums.ActivityType;
import com.buzzinate.common.dao.PointsDaoBase;
import com.buzzinate.common.util.Pagination;

/**
 * Activity manager Dao
 * 
 * @author martin
 *
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class ActivityDao extends PointsDaoBase<Activity, Integer> implements Serializable {
    
    private static final long serialVersionUID = 2902311255239640437L;

    public ActivityDao() {
        super(Activity.class, "id");
    }


    public List<Activity> getActivityByUserId(int userId) {
        Query query = getSession().getNamedQuery("Activity.getActivityByUserId");
        query.setInteger("publisherId", userId);
        return (List<Activity>) query.list();
    }
    
    public List<Activity> getActivityByUuid(String uuid) {
        Query query = getSession().getNamedQuery("Activity.getActivityByUuid");
        query.setBinary("uuid", new UUID(uuid).asByteArray());
        return (List<Activity>) query.list();
    }


    public List<Activity> getUnderWayActivityByUserId(int userId) {
        Query query = getSession().getNamedQuery("Activity.getUnderWayActivityByUserId");
        query.setInteger("publisherId", userId);
        return (List<Activity>) query.list();
    }


    public List<Activity> getNormalActivityByUserId(int userId) {
        Query query = getSession().getNamedQuery("Activity.getNormalActivityByUserId");
        query.setInteger("publisherId", userId);
        query.setInteger("activityType1", ActivityType.NOSTART.getCode());
        query.setInteger("activityType2", ActivityType.START.getCode());
        return (List<Activity>) query.list();
    }
    
    public List<Activity> getConfilctActivityByUuidIdAndTime(byte[] uuid , Date startDate , Date endDate) {
        Query query = getSession().getNamedQuery("Activity.checkCoflictActivityByUuIdAndTime");
        query.setBinary("uuid", uuid);
        query.setDate("startDate", startDate);
        query.setDate("endDate", endDate);
        return (List<Activity>) query.list();
    }


    public List<Activity> getFinishActivityByDate(Date day) {
        Query query = getSession().getNamedQuery("Activity.getFinishActivityByDate");
        query.setDate("day", day);
        query.setInteger("activityType", ActivityType.EXPIRED.getCode());
        return (List<Activity>) query.list();
    }
    
    /**
     * 获得域名下，当前正在进行的活动
     * 
     * @param uuid
     * @param domain
     * @return
     */
    public Activity getCurrentActivity(byte[] uuid) {
        Query query = getSession().getNamedQuery("Activity.getCurrentActivity");
        query.setBinary("uuid", uuid);
        List<Activity> activitys = (List<Activity>) query.list();
        if (activitys != null && activitys.size() > 0) {
            return activitys.get(0);
        }
        return null;
    }

    /**
     * 扣除活动积分
     * @param activityId
     * @param points
     * @return
     */
    @Transactional(value = "points", readOnly = false)
    public boolean decrActivityPoints(int activityId , int points) {
        Query query = getSession().getNamedQuery("Activity.decrActivityPoints");
        query.setInteger("activityId", activityId);
        query.setInteger("usedPoints", points);
        return query.executeUpdate() > 0;
    }


    public List<Activity> getActivityByDate(int userId, Date dateStart, Date dateEnd) {
        Query query = getSession().getNamedQuery("Activity.getActivityByDate");
        query.setInteger("publisherId", userId);
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return (List<Activity>) query.list();
    }
    //get Activity By publisherId uuid and start date and end date
    public List<Activity> getActivityByDateUuid(int userId , byte[] uuid , Date dateStart , Date dateEnd) {
        Query query = getSession().getNamedQuery("Activity.getActivityByDateAndUuid");
        query.setInteger("publisherId", userId);
        if (uuid.length > 0) {
            query.setBinary("uuid", uuid);
        } else {
            query.setString("uuid", "1");
        }
        query.setDate("dateStart", dateStart);
        query.setDate("dateEnd", dateEnd);
        return (List<Activity>) query.list();
    }
    
    public List<Activity> getActivityByCate(int userId , ActivityCategory cate , byte[] uuid , Date currentDate) {
        Query query = getSession().getNamedQuery("Activity.getActivityByCate");
        query.setInteger("publisherId", userId);
        if (uuid.length > 0) {
            query.setBinary("uuid", uuid);
        } else {
            query.setString("uuid", "1");
        }
        Date paramD = currentDate == null ? new Date() : currentDate;
        query.setDate("curDate", paramD);
        query.setParameter("activityCate", cate);
        return (List<Activity>) query.list();
    }

    @Transactional(value = "points", readOnly = false)
    public void updateInfo(Activity activity) {
        Query query = getSession().getNamedQuery("Activity.updateInfo");
        query.setString("domain", activity.getDomain());
        query.setString("name", activity.getName());
        query.setString("url", activity.getUrl());
        query.setString("pic", activity.getPic());
        query.setString("description", activity.getDescription());
        query.setString("activityInfo", activity.getActivityInfo());
        query.setDate("startDate", activity.getStartDate());
        query.setDate("endDate", activity.getEndDate());
        query.setInteger("status", activity.getActivityType().getCode());
        query.setInteger("totalPoints", activity.getTotalPoints());
        query.setString("publisher_name", activity.getPublisherName());
        query.setString("publisher_site", activity.getPublisherSite());
        query.setInteger("id", activity.getId());
        query.executeUpdate();
        
        query = getSession().getNamedQuery("ActivityLimitRule.updateInfo");
        ActivityLimitRule activityLimitRule = activity.getActivityLimitRule();
        query.setInteger("activity_id", activity.getId());
        query.setString("domain", activityLimitRule.getDomain());
        query.setInteger("share_limit_no", activityLimitRule.getShareLimitNo());
        query.setInteger("clickback_limit_no", activityLimitRule.getClickBackLimitNo());
        query.executeUpdate();
        
    }


    public List<Activity> getStartActivityByDate(Date day) {
        Query query = getSession().getNamedQuery("Activity.getStartActivityByDate");
        query.setDate("day", day);
        return (List<Activity>) query.list();
    }

    // main page the activity list
    public List<Activity> getNormalActivitys(int num) {
        Query query = getSession().getNamedQuery("Activity.getNormalActivitys");
        if (num > 0) {
            query.setMaxResults(num);
        }
        return (List<Activity>) query.list();
    }
    //get the Count for normal activities
    public long getCountNormalActivitys() {
        return getNameQueryCount("Activity.getCountNormalActivitys", null);
    }
    //get the Activities every page
    public List<Activity> getPaginationNormalActivitys(Pagination pagination) {
        return (List<Activity>) getNameQueryPagination("Activity.getNormalActivitys", null, pagination);
    }
    
    public List<Integer> getSpecialActivityId(int type) {
        Query query = getSession().getNamedQuery("Activity.getSpecialActivityIds");
        query.setInteger("type", type);
        return (List<Integer>) query.list();
    }
    
    public boolean isSpecialActivity(int activityId) {
        Query query = getSession().getNamedQuery("Activity.existsSPActivity");
        query.setInteger("activityId", activityId);
        return (Long) query.uniqueResult() > 0;
    }
}
