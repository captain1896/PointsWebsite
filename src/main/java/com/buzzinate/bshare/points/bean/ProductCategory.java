package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.Date;

import com.buzzinate.bshare.points.bean.enums.CategoryStatus;

/**product category
 * @author james.chen
 * @since 2012-6-4
 */
public class ProductCategory implements Serializable {
    
    public static final ProductCategory ALL = new ProductCategory(-1 , "所有类别" , "all");
    public static final int LOTTERY_COUPON = 14;
    private static final long serialVersionUID = 4196864908183436674L;
    //product Category primary key
    private int id;
    //product category code
    private String code;
    //parent id of product category
    private int parentId;
    //product category name
    private String name;
    //category english name
    private String nameEn;
    //insert time
    private Date insertTime;
    //product status
    private CategoryStatus status;
    //product Number
    private long prodNum;
    
    
    public ProductCategory() {
    }
    
    public ProductCategory(int id, String name, String nameEn) {
        this.id = id;
        this.nameEn = nameEn;
        this.name = name;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public Date getInsertTime() {
        return insertTime;
    }

    public void setInsertTime(Date insertTime) {
        this.insertTime = insertTime;
    }

    public long getProdNum() {
        return prodNum;
    }

    public void setProdNum(long prodNum) {
        this.prodNum = prodNum;
    }

    public CategoryStatus getStatus() {
        return status;
    }

    public void setStatus(CategoryStatus status) {
        this.status = status;
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }    
}
