package com.buzzinate.bshare.points.dao;


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
import com.buzzinate.bshare.points.bean.PointRecord;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "/applicationContext-core.xml", "/applicationContext.xml" })
public class PointRecordDaoTest {

    @Autowired
    private PointRecordDao pointRecordDao;
    
    private List<PointRecord> expectedRecords = new ArrayList<PointRecord>();
    private int userId = 9999;
    private int activityId = 1;
    
    @Before
    public void setUp() throws Exception {
        
        PointRecord pointRecord1 = new PointRecord(userId, activityId, 10, PointsType.SHARE);
        pointRecordDao.create(pointRecord1);
        expectedRecords.add(pointRecord1);
        
        PointRecord pointRecord2 = new PointRecord(userId, activityId, 15, PointsType.SHARE);
        pointRecordDao.create(pointRecord2);
        expectedRecords.add(pointRecord2);
    }

    @After
    public void tearDown() throws Exception {
        for (PointRecord pointRecord : expectedRecords) {
            pointRecordDao.delete(pointRecord.getId());
        }
    }

    @Test
    public void testGetPointRecords() {
        List<PointRecord> actualPointRecords = pointRecordDao.getPointRecords(userId);
        assertEquals(expectedRecords.size(), actualPointRecords.size());
        
        // order by time desc
        for (int i = 0, size = expectedRecords.size(); i < size; i++) {
            assertEquals(expectedRecords.get(i), actualPointRecords.get(size - 1 - i));
        }
    }


    public void testGetPointRecordsByActivityId() {
        List<PointRecord> actualPointRecords = pointRecordDao.getPointRecordsByActivityId(activityId);
        assertEquals(expectedRecords.size(), actualPointRecords.size());
        
        // order by time desc
        for (int i = 0, size = expectedRecords.size(); i < size; i++) {
            assertEquals(expectedRecords.get(i), actualPointRecords.get(size - 1 - i));
        }
    }
}
