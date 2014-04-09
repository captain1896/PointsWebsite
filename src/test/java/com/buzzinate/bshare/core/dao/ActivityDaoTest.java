package com.buzzinate.bshare.core.dao;

import static com.buzzinate.bshare.core.util.TestUtilMysql.getApplicationContext;
import static com.buzzinate.bshare.core.util.TestUtilMysql.getDatabaseTester;

import java.util.ArrayList;
import java.util.List;

import org.dbunit.dataset.DefaultDataSet;
import org.dbunit.dataset.DefaultTable;
import org.dbunit.dataset.IDataSet;
import org.hibernate.SessionFactory;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.bean.PointRule;
import com.buzzinate.bshare.points.bean.enums.ActivityType;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.bshare.points.dao.ActivityDao;
import com.buzzinate.common.util.DateTimeUtil;
import com.buzzinate.common.util.string.StringUtil;

/**
 * Activity Dao test
 * 
 * @author martin
 *
 */
@Test(groups = { "dao", "mysql" })
public class ActivityDaoTest {

    private ActivityDao activityDao;

    @BeforeClass
    public void init() throws Exception {
        activityDao = new ActivityDao();
        activityDao.setSessionFactory((SessionFactory) getApplicationContext().getBean("sessionFactory"));
    }

    @BeforeMethod
    public void setUp() throws Exception {
        IDataSet dataSet = new DefaultDataSet(new DefaultTable("richi_activity"));
        getDatabaseTester().setDataSet(dataSet);
        getDatabaseTester().onSetup();

        SessionFactory sessionFactory = (SessionFactory) getApplicationContext().getBean("sessionFactory");
        sessionFactory.getCurrentSession().beginTransaction();
    }

    @AfterMethod
    public void end() throws Exception {
        SessionFactory sessionFactory = (SessionFactory) getApplicationContext().getBean("sessionFactory");
        sessionFactory.getCurrentSession().getTransaction().commit();
        getDatabaseTester().onTearDown();
    }

    @Test
    public void create() throws Exception {
        Activity a = new Activity();
        a.setName("测试活动1");
        a.setDescription("测试活动1描述");
        a.setPublisherId(1);
        a.setStartDate(DateTimeUtil.getYestoday());
        a.setEndDate(DateTimeUtil.getCurrentDateDay());
        a.setTotalPoints(1000);
        a.setActivityType(ActivityType.NOSTART);
        a.setUsedPoints(200);
        a.setUuid(StringUtil.hash(""));
        List<PointRule> pointRules = new ArrayList<PointRule>();
        PointRule pr = new PointRule();
        pr.setPoints(100);
        pr.setPointsRuleType(PointsRuleType.CLICKBACK);
        pointRules.add(pr);
        a.setPointRules(pointRules);
        activityDao.saveOrUpdate(a);
    }
}
