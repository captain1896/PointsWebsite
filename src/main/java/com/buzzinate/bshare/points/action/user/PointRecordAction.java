package com.buzzinate.bshare.points.action.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.points.action.BaseAction;
import com.buzzinate.bshare.points.bean.PointRecord;
import com.buzzinate.bshare.points.service.PointRecordService;

/**
 * 
 * 获取积分详情列表
 * 
 * @author magic
 *
 */
@Controller
@Scope("request")
public class PointRecordAction extends BaseAction {

    private static final long serialVersionUID = 6520201852339048541L;

    @Autowired
    private PointRecordService pointRecordService;
    
    private List<PointRecord> pointRecords;
    
    public String execute() throws Exception {
        int userId = loginHelper.getUserId();
        
        pointRecords = pointRecordService.getPointRecords(userId);
        
        return SUCCESS;
    }

    public List<PointRecord> getPointRecords() {
        return pointRecords;
    }

    public void setPointRecords(List<PointRecord> pointRecords) {
        this.pointRecords = pointRecords;
    }
}
