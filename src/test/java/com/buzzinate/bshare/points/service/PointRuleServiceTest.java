package com.buzzinate.bshare.points.service;

import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.buzzinate.bshare.core.bean.enums.PointsType;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.PointDetailParam;
import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.bshare.points.cache.PointCache;
import com.buzzinate.common.util.DateTimeUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "/applicationContext-core.xml", "/applicationContext.xml" })
public class PointRuleServiceTest {

    @Autowired
    private ActivityRuleService ruleService;

    private Activity activity;
    private PointDetailParam clickbackPointDetailParam;
    private PointDetailParam sharePointDetailParam;
    private int publisherId;
    private int userId;

    @Autowired
    private PointCache pointCache;

    @Before
    public void setUp() throws Exception {
        publisherId = 1234;
        activity = new Activity(publisherId, "weibo.com", "微活动", "分享获取积分", DateTimeUtil.getYestoday(),
                DateTimeUtil.getCurrentDateDay(), 100, 50);

        List<PointRule> pointRules = new ArrayList<PointRule>();
        // 3 share, 5 points; share limit: 10 points
        pointRules.add(new PointRule(activity.getId(), PointsRuleType.SHARE, 3, 5));
        pointRules.add(new PointRule(activity.getId(), PointsRuleType.SHARELIMIT, 0, 10));
        
        // 1 clickback, 5 points; clickback limit: 10 points
        pointRules.add(new PointRule(activity.getId(), PointsRuleType.CLICKBACK, 1, 5));
        pointRules.add(new PointRule(activity.getId(), PointsRuleType.CLICKBACKLIMIT, 0, 10));
        activity.setPointRules(pointRules);

        userId = 9999;
        clickbackPointDetailParam = new PointDetailParam(userId, PointsType.CLICKBACK, "renren", "", "weibo.com");
        sharePointDetailParam = new PointDetailParam(userId, PointsType.SHARE, "renren", "", "weibo.com");
    }

    @After
    public void tearDown() throws Exception {
        pointCache.deleteCounterOfNotCalcPointsCache(userId, activity,
                PointsRuleType.valueOf(clickbackPointDetailParam.getType()));
        pointCache.deleteTodayTotalPointsCache(userId, activity,
                activity.getLimitPointRule(PointsRuleType.valueOf(clickbackPointDetailParam.getType()))
                        .getPointsRuleType());

        pointCache.deleteCounterOfNotCalcPointsCache(userId, activity,
                PointsRuleType.valueOf(sharePointDetailParam.getType()));
        pointCache
                .deleteTodayTotalPointsCache(userId, activity,
                        activity.getLimitPointRule(PointsRuleType.valueOf(sharePointDetailParam.getType()))
                                .getPointsRuleType());

    }


    @Test
    public void testGetPoints() {
        // 1 clickback, 5 points; clickback limit: 10 points
        testGetPoints(clickbackPointDetailParam);
        // 3 share, 5 points; share limit: 10 points
        testGetPoints(sharePointDetailParam);
    }
    
    public void testGetPoints(PointDetailParam pointDetailParam) {
        PointRule pointRule = activity.getPointRule(PointsRuleType.valueOf(pointDetailParam.getType()));
        PointRule limitPointRule = activity.getLimitPointRule(PointsRuleType.valueOf(pointDetailParam.getType()));
        
        // 计算可以得分的次数
        int canGetPointNum = limitPointRule.getPoints() / pointRule.getPoints();
        for (int i = 0; i < canGetPointNum; i++) {
            // 不得分的次数
            for (int j = 0; j < pointRule.getNum() - 1; j++) {
                assertEquals(0, ruleService.getPoints(pointDetailParam, activity));
            }
            // 分享/回流次数满足pointsRule要求, get points
            assertEquals(pointRule.getPoints(), ruleService.getPoints(pointDetailParam, activity));
        }
        
        // beyond limit
        assertEquals(0, ruleService.getPoints(pointDetailParam, activity));
    }
}
