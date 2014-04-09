package com.buzzinate.bshare.points.service;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.buzzinate.bshare.points.bean.PointsOperateHis;
import com.buzzinate.bshare.points.bean.enums.OperateType;
import com.buzzinate.bshare.points.bean.enums.PointsStatModule;
import com.buzzinate.bshare.points.dao.PointsOperateHisDao;
import com.buzzinate.bshare.user.service.LoginHelper;

/**
 * PointsOperateHis Service, handle 
 * @author james.chen
 * @since 2012-6-25
 */
@Service
public class PointsOperateHisService implements Serializable {
    
    
    /**
     * 
     */
    private static final long serialVersionUID = 4024517767084097622L;
    
    private static Log log = LogFactory.getLog(PointsOperateHisService.class);
    
    @Autowired
    private PointsOperateHisDao pointsOperateHisDao;
    
    @Autowired
    private LoginHelper loginHelper;
    
    private void createHis(PointsStatModule statModule , OperateType operateType , int recordId) {
        int userId = 0;
        try {
            userId = loginHelper.getUserId();
            if (recordId == 0 || userId == 0) {
                return;
            }
            PointsOperateHis his = new PointsOperateHis(statModule , operateType , recordId , userId);
            pointsOperateHisDao.create(his);
        } catch (Exception e) {
            log.error(new StringBuilder("Create His Error:StatModule=").append(statModule).append(",operateType=")
                    .append(operateType).append(",recordId=").append(recordId).append(",userId=").append(userId), e);
        }
    }
    //create view record info
    public void createView(PointsStatModule statModule , int recordId) {
        createHis(statModule, OperateType.VIEW, recordId);
    }
    //create delete record log
    public void createDelete(PointsStatModule statModule , int recordId) {
        createHis(statModule, OperateType.DELETE, recordId);
    }

    // create add record log
    public void createAdd(PointsStatModule statModule , int recordId) {
        createHis(statModule, OperateType.ADD, recordId);
    }
    
    // create modify record log
    public void createModify(PointsStatModule statModule , int recordId) {
        createHis(statModule, OperateType.MODIFY, recordId);
    }
    
    public List<PointsOperateHis> listAll() {
        return pointsOperateHisDao.getOperateHis();
    }
}
