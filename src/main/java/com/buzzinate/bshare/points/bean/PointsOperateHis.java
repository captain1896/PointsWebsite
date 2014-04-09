package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.Date;

import com.buzzinate.bshare.points.bean.enums.OperateType;
import com.buzzinate.bshare.points.bean.enums.PointsStatModule;

/**PointsOperateHis Record
 * @author james.chen
 * @since 2012-6-25
 */
public class PointsOperateHis implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 5760127002984132047L;
    //primary key
    private int id;
    //points statistic module
    private PointsStatModule pointsModule;
    //operate type
    private OperateType operateType;
    //record id
    private int recordId;
    //user id
    private int userId;
    //insert time
    private Date insertTime;
    
    public PointsOperateHis() {

    }
    
    public PointsOperateHis(PointsStatModule module, OperateType type, int recordId, int userId) {
        this.pointsModule = module;
        this.operateType = type;
        this.insertTime = new Date();
        this.recordId = recordId;
        this.userId = userId;
    }
    
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public PointsStatModule getPointsModule() {
        return pointsModule;
    }
    public void setPointsModule(PointsStatModule pointsModule) {
        this.pointsModule = pointsModule;
    }
    public OperateType getOperateType() {
        return operateType;
    }
    public void setOperateType(OperateType operateType) {
        this.operateType = operateType;
    }
    public int getRecordId() {
        return recordId;
    }
    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public Date getInsertTime() {
        return insertTime;
    }
    public void setInsertTime(Date insertTime) {
        this.insertTime = insertTime;
    }
}
