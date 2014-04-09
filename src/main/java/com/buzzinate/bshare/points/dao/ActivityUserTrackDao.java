package com.buzzinate.bshare.points.dao;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.buzzinate.bshare.points.bean.ActivityUserTrack;
import com.buzzinate.common.dao.PointsDaoBase;

/**
 * @author james.chen
 * @since 2012-8-24
 */
@Repository
@Transactional(value = "points", readOnly = true)
public class ActivityUserTrackDao extends PointsDaoBase<ActivityUserTrack, Integer> {

    public ActivityUserTrackDao() {
        super(ActivityUserTrack.class , "id");
    }
}
