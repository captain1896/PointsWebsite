package com.buzzinate.bshare.points.service;

import java.io.Serializable;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.core.bean.enums.PointsType;
import com.buzzinate.bshare.points.bean.ActivityLimitRule;
import com.buzzinate.bshare.points.bean.ActivityStatNo;
import com.buzzinate.bshare.points.bean.enums.ActivityStatType;
import com.buzzinate.bshare.points.dao.ActivityStatDao;

/**
 * @author james.chen
 * @since 2012-8-24
 */
@Service
public class ActivityStatService implements Serializable {

    private static final long serialVersionUID = 2982971061562294943L;
    private static Log log = LogFactory.getLog(ActivityStatService.class);

    @Autowired
    private ActivityStatDao statDao;
    
    /**store StatObject
     * @param statNo
     */
    public int createStat(ActivityStatNo statNo) {
        ActivityStatNo exists = statDao.getByActivityNo(statNo);
        if (exists.getActivityId() > 0) {
            return exists.getId();
        } else {
            return statDao.create(statNo);
        }
    }

    public void updateStat(ActivityStatNo statNo , int limitNo) {
        int id = createStat(statNo);
        log.info("start to stat activity real update3");
        if (!statDao.updateStatNoById(id, limitNo)) {
            throw new RuntimeException("updateStat error,activityId" + statNo + ",limitNO=" + limitNo);
        }
    }
    
    public void updateStatActivity(int userId , ActivityStatType statType , ActivityLimitRule limitRule) {
        log.info("start to stat activity");
        if (limitRule == null) {
            log.info("start to stat activity no rule");
            return;
        }
        log.info("start to stat activity real update");
        ActivityStatNo statNo = new ActivityStatNo(limitRule.getActivityId() , userId , statType , 0);
        if (limitRule.getLimitNo(statType.getCode()) > 0) {
            log.info("start to stat activity real update2");
            updateStat(statNo, limitRule.getLimitNo(statType.getCode()));
        }
    }
    
    public long getTypeTotalNo(int activityId , int recordId , PointsType type) {
        if (type == null)
            return 0;
        return getTotalNo(activityId, recordId, ActivityStatType.get(type.getCode()));
    }
    
    public long getTotalNo(int activityId , int recordId , ActivityStatType statType) {
        return statDao.getTotalNo(new ActivityStatNo(activityId , recordId , statType , 0));
    }
}
