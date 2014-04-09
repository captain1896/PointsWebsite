package com.buzzinate.bshare.points.service;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.PointsActivityStat;
import com.buzzinate.bshare.points.dao.PointsActivityStatDao;
/**
 * @author james.chen
 * @since 2012-7-23
 */
@Service
public class PointsActivityStatService implements Serializable {

    private static final long serialVersionUID = 292545228326320838L;

    @Autowired
    private PointsActivityStatDao statDao;
    
    public boolean statAccept(int activityId , int accept) {
        return statDao.statActivity(new PointsActivityStat(activityId , accept , 0 , 0));
    }
    
    public boolean statReject(int activityId , int reject) {
        return statDao.statActivity(new PointsActivityStat(activityId , 0 , reject , 0));
    }

    public boolean statFinish(int activityId , int finish) {
        return statDao.statActivity(new PointsActivityStat(activityId , 0 , 0 , finish));
    }
}
