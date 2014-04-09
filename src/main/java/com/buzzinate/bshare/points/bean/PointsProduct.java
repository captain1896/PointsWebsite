package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.buzzinate.bshare.points.bean.enums.PointsCategory;
import com.buzzinate.bshare.points.bean.enums.ProductStatus;
import com.buzzinate.bshare.points.util.ValidateUtil;
import com.buzzinate.common.bean.Entity;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.string.UrlUtil;

/**
 * the object for all exchange product which supply the cooperators.
 * @author james.chen
 * @since 2012-6-4
 */
public class PointsProduct implements Entity<Integer>, Serializable {

    private static final long serialVersionUID = -998860452183286682L;
    
    private static DecimalFormat format = new DecimalFormat("########0.00");
    
    private static final String WEB_PATH = ConfigurationReader.getString("base.repository.path.web") + "/" +
            ConfigurationReader.getString("bshare.points.image.path");
    
    private static final String PIC_URL = ConfigurationReader.getString("bshare.points.product.noimage");
    private static final String THUMBNAIL_PIC_URL = ConfigurationReader
            .getString("bshare.points.product.thumbnail.noimage");
    
    //product sequence id
    private int id;
    //product name
    private String name;
    //product short description 
    private String desc;
    //product description URL which in cooperator's web site
    private String descUrl;
    //product category
    private int prodCate;
    //the pictures to describe this product
    private String pic;
    //product brand
    private String brand;
    //product tags
    private String tags;
    //the price of this product in social market
    private int priceMarket;
    //initial points for this product
    private int initialPoints;
    //current points for this product
    private int currentPoints;
    //the product supplier
    private int merchantId;
    //current existed number
    private int storeNum;
    //total sell number for this product
    private int sellNum;
    //insert time
    private Date insertTime;
    //product auto down time
    private Date expireDate;
    //product current status
    private ProductStatus productStatus;
    //category name
    private ProductCategory productCategory;
    //merchant name
    private Merchant merchant;
    
    private int auditBy;
    private Date auditTime;
    private Date updateTime;
    
    public Integer getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = ValidateUtil.escapeContent(name);
    }
    public String getDesc() {
        return desc;
    }
    public void setDesc(String desc) {
        this.desc = ValidateUtil.escapeContent(desc, 400);
    }
    public String getPic() {
        return pic;
    }
    public void setPic(String pic) {
        this.pic = pic;
    }
    
    public int getInitialPoints() {
        return initialPoints;
    }
    public void setInitialPoints(int initialPoints) {
        this.initialPoints = initialPoints;
    }
    public int getCurrentPoints() {
        return currentPoints;
    }
    public void setCurrentPoints(int currentPoints) {
        this.currentPoints = currentPoints;
    }
    public int getStoreNum() {
        return storeNum;
    }
    public void setStoreNum(int storeNum) {
        this.storeNum = storeNum;
    }
    public int getSellNum() {
        return sellNum;
    }
    public void setSellNum(int sellNum) {
        this.sellNum = sellNum;
    }
    public Date getInsertTime() {
        return insertTime;
    }
    public void setInsertTime(Date insertTime) {
        this.insertTime = insertTime;
    }
    public String getDescUrl() {
        return descUrl;
    }
    public String getDescUrlPrefix() {
        return StringUtils.isBlank(descUrl) ? "" : UrlUtil.getFullUrlWithPrefix(descUrl);
    }
    public void setDescUrl(String descUrl) {
        this.descUrl = descUrl;
    }
    public int getPriceMarket() {
        return priceMarket;
    }
    public void setPriceMarket(int priceMarket) {
        this.priceMarket = priceMarket;
    }
    
    public void setPriceMarketValue(String priceMarketValue) {
        this.priceMarket = (int) (Double.parseDouble(priceMarketValue) * 100);
    }
    
    public String getPriceMarketValue() {
        return format.format(priceMarket / 100.0); 
    }
    
    public int getProdCate() {
        return prodCate;
    }
    public void setProdCate(int prodCate) {
        this.prodCate = prodCate;
    }
    public int getMerchantId() {
        return merchantId;
    }
    public void setMerchantId(int merchantId) {
        this.merchantId = merchantId;
    }
    public Date getExpireDate() {
        return expireDate;
    }
    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }
    
    public ProductStatus getProductStatus() {
        return productStatus;
    }
    public void setProductStatus(ProductStatus productStatus) {
        this.productStatus = productStatus;
    }
    public void setProductStatusValue(int productStatusValue) {
        this.productStatus = ProductStatus.valueOf(productStatusValue);
    }
    public int getProductStatusValue() {
        return productStatus.getCode();
    }
    public String getBrand() {
        return brand;
    }
    public void setBrand(String brand) {
        this.brand = ValidateUtil.escapeContent(brand);
    }
    public String getTags() {
        return tags;
    }
    public void setTags(String tags) {
        this.tags = ValidateUtil.escapeContent(tags);
    }
    public Merchant getMerchant() {
        return merchant;
    }
    public void setMerchant(Merchant merchant) {
        this.merchant = merchant;
    }
    public ProductCategory getProductCategory() {
        return productCategory;
    }
    public void setProductCategory(ProductCategory productCategory) {
        this.productCategory = productCategory;
    }
    public String getThumbnail() {
        if (StringUtils.isEmpty(pic)) {
            return THUMBNAIL_PIC_URL;
        } else {
            return WEB_PATH + "thumbnail/" + StringUtils.left(pic, 1) + "/" + pic;
        }
    }
    public String getPicUrl() {
        if (StringUtils.isEmpty(pic)) {
            return PIC_URL;
        } else {
            return WEB_PATH + "source/" + StringUtils.left(pic, 1) + "/" + pic;
        }
    }
    
    public boolean isPoints() {
        return PointsCategory.isPointsCategory(id);
    }
    
    public boolean isLottery() {
        return ProductCategory.LOTTERY_COUPON == prodCate;
    }
    
    public boolean isNormal() {
        return !(isPoints() || isLottery());
    }
    
    public boolean isLimit() {
        return storeNum == -1 ? false : true;
    }
    
    public int getAuditBy() {
        return auditBy;
    }
    public void setAuditBy(int auditBy) {
        this.auditBy = auditBy;
    }
    public Date getAuditTime() {
        return auditTime;
    }
    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }
    
    public Date getUpdateTime() {
        return updateTime;
    }
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
    /**validate the points product whether is Active, or has Expired
     * inActive return true, pass expired date return true
     * else return false
     * @return
     */
    public boolean validate() {
        return (ProductStatus.INACTIVE.equals(this.productStatus) || (this.getExpireDate() != null && this
                .getExpireDate().compareTo(new Date()) <= 0)) && !PointsCategory.isPointsCategory(id);
    }
}
