package com.buzzinate.bshare.points.service;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.bshare.points.dao.PointRuleDao;

/**
 * Activity point rule service
 * 
 * @author martin
 * 
 */
@Service
public class PointRuleService implements Serializable {

    private static final long serialVersionUID = 6900059769541777569L;


    @Autowired
    private PointRuleDao pointRuleDao;

    public List<PointRule> getPointRuleByActivityId(int activityId) {
        return pointRuleDao.getPointRuleByActivityId(activityId);
    }
    
    public PointRule getPointRuleByActivityIdType(int activityId , PointsRuleType ruleType) {
        return pointRuleDao.getPointRuleByActivityIdType(activityId, ruleType);
    }

    public void save(List<PointRule> pointRules, int activityId) {
        for (PointRule pr : pointRules) {
            pr.setActivityId(activityId);
            pointRuleDao.saveOrUpdate(pr);
        }
    }
    
    public void deletePointRulesByActivityId(int activityId) {
        pointRuleDao.deletePointRules(activityId);
    }
}
