package com.buzzinate.bshare.points.service;

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
import com.buzzinate.bshare.points.bean.Account;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.PointDetailParam;
import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.enums.ActivityType;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.common.util.DateTimeUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "/applicationContext-core.xml", "/applicationContext.xml" })
public class PointServiceTest {

    @Autowired
    private PointService pointService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private AccountService accountService;
    
    private Activity activity;
    private Account acccount;

    @Before
    public void setUp() throws Exception {
        int publisherId = 123;
        accountService.createAccount(publisherId, "test");
        accountService.chargePoints(publisherId, 1000);
        acccount = accountService.findAccount(publisherId);
        
        activity = new Activity(publisherId, "b70ecb49-4c28-4400-ba20-fa4a3a6d5bc9", "weibo.com", "微活动", "分享获取积分",
                DateTimeUtil.getCurrentDateDay(), DateTimeUtil.getCurrentDateDay(), 100, 50, ActivityType.NOSTART);

        List<PointRule> pointRules = new ArrayList<PointRule>();
        // 3 share, 5 points; share limit: 10 points
        pointRules.add(new PointRule(activity.getId(), PointsRuleType.SHARE, 3, 5));
        pointRules.add(new PointRule(activity.getId(), PointsRuleType.SHARELIMIT, 0, 10));

        // 1 clickback, 5 points; clickback limit: 10 points
        pointRules.add(new PointRule(activity.getId(), PointsRuleType.CLICKBACK, 1, 5));
        pointRules.add(new PointRule(activity.getId(), PointsRuleType.CLICKBACKLIMIT, 0, 10));
        activity.setPointRules(pointRules);

        activityService.save(activity);
    }

    @After
    public void tearDown() throws Exception {
        activityService.deleteActivityById(activity.getId());
        accountService.deleteAccount(acccount.getPublisherId());
    }

    @Test
    public void testProcess() throws Exception {
        PointDetailParam pointDetailParam = new PointDetailParam(999, PointsType.CLICKBACK, "sinaminiblog",
                activity.getPublisherUuid(), "weibo.com");

        pointService.process(pointDetailParam);
    }

}
