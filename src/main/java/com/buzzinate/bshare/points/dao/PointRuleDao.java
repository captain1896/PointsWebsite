package com.buzzinate.bshare.points.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * Activity point rule Dao
 * 
 * @author martin
 *
 */
@Repository
@Transactional(value = "points", readOnly = true)
@SuppressWarnings("unchecked")
public class PointRuleDao extends PointsDaoBase<PointRule, Integer> implements Serializable {
    
    private static final long serialVersionUID = -3123925185887997178L;

    public PointRuleDao() {
        super(PointRule.class, "id");
    }

    public List<PointRule> getPointRuleByActivityId(int activityId) {
        Query query = getSession().getNamedQuery("PointRule.getPointRuleByActivityId");
        query.setInteger("activityId", activityId);
        return (List<PointRule>) query.list();
    }
    
    public PointRule getPointRuleByActivityIdType(int activityId , PointsRuleType ruleType) {
        Criteria crite = getSession().createCriteria(PointRule.class);
        crite.add(Restrictions.eq("activityId", activityId)).add(Restrictions.eq("pointsRuleType", ruleType));

        return (PointRule) crite.uniqueResult();
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean deletePointRules(int activityId) {
        Query query = getSession().getNamedQuery("PointRule.deletePointRules");
        query.setInteger("activityId", activityId);
        return query.executeUpdate() > 0;
    }
}
