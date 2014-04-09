package com.buzzinate.bshare.points.dao;

import java.io.Serializable;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.PointsUser;
import com.buzzinate.common.dao.PointsDaoBase;
/**
 * pointUser Dao,the handler get data from point user table 
 * @author james.chen
 * @since 2012-6-12
 */
@Repository
@Transactional(value = "points", readOnly = true)
public class PointsUserDao extends PointsDaoBase<PointsUser, Integer> implements Serializable {

    private static final long serialVersionUID = 2875598978956663554L;

    public PointsUserDao() {
        super(PointsUser.class , "userId");
    }

    public PointsUser getPointsByUserId(int userId) {
        Query query = getSession().getNamedQuery("PointsUser.getPointsByUserId");
        query.setInteger("userId", userId);
        PointsUser pointsUser = (PointsUser) query.uniqueResult();
        return pointsUser == null ? new PointsUser(userId) : pointsUser;
    }
    
    public PointsUser getUserPoints(int userId) {
        Query query = getSession().getNamedQuery("PointsUser.getPointsByUserId");
        query.setInteger("userId", userId);
        return (PointsUser) query.uniqueResult();
    }
    
    //update PointsUser information.
    @Transactional(value = "points", readOnly = false)
    public boolean updatePointUserOrder(PointsUser pointsUser , int points) {
        Query query = getSession().getNamedQuery("PointsUser.updatePointUserOrder");
        query.setInteger("points", points);
        query.setInteger("userId", pointsUser.getUserId());
        return query.executeUpdate() > 0;
    }
    
    /**update PointUser Contact
     * @param pointsUser
     * @return
     */
    @Transactional(value = "points", readOnly = false)
    public boolean updatePointUserContact(PointsUser pointsUser) {
        Query query = getSession().getNamedQuery("PointsUser.insertOrUpdateUserContact");
        query.setString("name", pointsUser.getContactName());
        query.setString("state", pointsUser.getState());
        query.setString("city", pointsUser.getCity());
        query.setString("address", pointsUser.getContactAddress());
        query.setString("contactNo", pointsUser.getContactNo());
        query.setString("zipCode", pointsUser.getZipCode());
        query.setInteger("userId", pointsUser.getUserId());
        query.setInteger("points", 0);
        return query.executeUpdate() > 0;
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean addPoints(int particpantId, int points) {
        Query query = getSession().getNamedQuery("PointsUser.addPoints");
        query.setInteger("participantId", particpantId);
        query.setInteger("points", points);
        return query.executeUpdate() > 0;
    }

    public int getUserPointsByActivity(int userId, int activityId) {
        Query query = getSession().getNamedQuery("PointsUser.getUserPointsByActivity");
        query.setInteger("userId", userId);
        query.setInteger("activityId", activityId);
        return (Integer) query.uniqueResult();
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean updatePointUser(int sourceId, int targetId) {
        Query query = getSession().getNamedQuery("PointsUser.updatePointsUserId");
        query.setInteger("sourceId", sourceId);
        query.setInteger("targetId", targetId);
        return query.executeUpdate() > 0;
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean mergePoints(int targetId, int points) {
        Query query = getSession().getNamedQuery("PointsUser.mergePoints");
        query.setInteger("targetId", targetId);
        query.setInteger("points", points);
        return query.executeUpdate() > 0;
    }
    
    @Transactional(value = "points", readOnly = false)
    public boolean delete(int id) {
        Query query = getSession().getNamedQuery("PointsUser.delete");
        query.setInteger("id", id);
        return query.executeUpdate() > 0;
    }
}
