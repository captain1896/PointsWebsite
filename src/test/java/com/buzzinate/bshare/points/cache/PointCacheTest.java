package com.buzzinate.bshare.points.cache;

import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.common.util.DateTimeUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "/applicationContext-core.xml", "/applicationContext.xml" })
public class PointCacheTest {

    @Autowired
    private PointCache pointCache;
    
    private int userId = 123; 
    private Activity activity = new Activity(userId, "weibo.com", "微活动", "分享获取积分", DateTimeUtil.getYestoday(),
            DateTimeUtil.getCurrentDateDay(), 100, 50);
    private PointsRuleType pointType = PointsRuleType.SHARE;
    

    @Before
    public void setUp() throws Exception {
    }

    @After
    public void tearDown() throws Exception {
        pointCache.deleteCounterOfNotCalcPointsCache(userId, activity, pointType);
        pointCache.deleteTodayTotalPointsCache(userId, activity, pointType);
    }
    
    @Test
    public void testGetAndSetTodayTotalPoints() {
        
        long todayTotalPoints = pointCache.getTodayTotalPoints(userId, activity, pointType);
        int points = 100;
        long actualPoints = pointCache.incrTodayTotalPoints(userId, activity, pointType, points);
        
        if (todayTotalPoints < 0) {
            assertEquals(points, actualPoints);
        } else {
            assertEquals(points + todayTotalPoints, actualPoints);   
        }
    }

    @Test
    public void testGetAndSetCounterOfNotCalcPoints() {
        long todayTotalPoints = pointCache.getCounterOfNotCalcPoints(userId, activity, pointType);
        int points = 100;

        //  first incr
        long actualPoints = pointCache.incrCounterOfNotCalcPoints(userId, activity, pointType, points);
        if (todayTotalPoints < 0) {
            assertEquals(points, actualPoints);
        } else {
            assertEquals(points + todayTotalPoints, actualPoints);
        }
        
        //  second incr
        actualPoints = pointCache.incrCounterOfNotCalcPoints(userId, activity, pointType, points);
        if (todayTotalPoints < 0) {
            assertEquals(2 * points, actualPoints);
        } else {
            assertEquals(2 * points + todayTotalPoints, actualPoints);   
        }
        
        // third decr
        actualPoints = pointCache.decrCounterOfNotCalcPoints(userId, activity, pointType, points);
        if (todayTotalPoints < 0) {
            assertEquals(points, actualPoints);
        } else {
            assertEquals(points + todayTotalPoints, actualPoints);
        }
    }


}
