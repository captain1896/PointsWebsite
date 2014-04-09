package com.buzzinate.bshare.points.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.safehaus.uuid.UUID;

import com.buzzinate.bshare.points.bean.enums.ActivityCategory;
import com.buzzinate.bshare.points.bean.enums.ActivityType;
import com.buzzinate.bshare.points.bean.enums.PointsRuleType;
import com.buzzinate.bshare.points.util.ValidateUtil;
import com.buzzinate.common.bean.Entity;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.DateTimeUtil;
import com.buzzinate.common.util.string.StringUtil;
import com.buzzinate.common.util.string.UrlUtil;

/**
 * Activity info
 * 
 * @author martin
 * 
 */
public class Activity implements Entity<Integer>, Serializable {

    private static final long serialVersionUID = -2808749559286138387L;
    
    private static final String WEB_PATH = ConfigurationReader.getString("base.repository.path.web") + "/" +
            ConfigurationReader.getString("bshare.points.image.path");
    
    private static final String PIC_URL = ConfigurationReader.getString("bshare.points.activity.noimage");
    private static final String THUMBNAIL_PIC_URL = ConfigurationReader
            .getString("bshare.points.activity.thumbnail.noimage");

    private int id;
    private int publisherId;
    private byte[] uuid;
    private String name;
    private String pic;
    private String url;
    private String description;
    private Date startDate;
    private Date endDate;
    private int totalPoints;
    private int usedPoints;
    private ActivityType activityType;
    private String activityInfo;
    private String publisherName;
    private String publisherSite;
    
    private ActivityCategory activityCate = ActivityCategory.NORMAL;
    
    private List<PointRule> pointRules;
    private ActivityLimitRule activityLimitRule;
    
    // 增加投放的积分，非数据库字段
    private int increasePoints;
    
    private boolean isUsed;

    public Activity() {
    }

    public Activity(int publisherId, String domain, String name, String description, Date startDate, Date endDate,
            int totalPoints, int usedPoints) {
        this(publisherId , "" , domain , name , description , startDate , endDate , totalPoints , usedPoints ,
                ActivityType.START);
    }

    public Activity(int publisherId, String publisherUuid, String domain, String name, String description,
            Date startDate, Date endDate, int totalPoints, int usedPoints, ActivityType activityType) {
        super();
        this.publisherId = publisherId;
        this.setPublisherUuid(publisherUuid);
        setName(name);
        setDescription(description);
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalPoints = totalPoints;
        this.usedPoints = usedPoints;
        setActivityType(activityType);
        this.activityCate = ActivityCategory.NORMAL;
    }
    
    public Activity(int publisherId, String publisherUuid, String domain, String name, String description,
            Date startDate, Date endDate, int totalPoints, int usedPoints, ActivityType activityType,
            ActivityCategory cate) {
        this(publisherId , publisherUuid , domain , name , description , startDate , endDate , totalPoints ,
                usedPoints , ActivityType.START);
        this.activityCate = cate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public byte[] getUuid() {
        return uuid;
    }
    
    public String getUuidStr() {
        return UUID.valueOf(uuid).toString();
    }

    public void setUuid(byte[] uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = ValidateUtil.escapeContent(name);
    }
    
    public String getUnescapeName() {
        return ValidateUtil.unescapeContent(name);
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public void setStartDateStr(String startDateStr) {
        this.startDate = DateTimeUtil.convertDate(startDateStr);
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public void setEndDateStr(String endDateStr) {
        this.endDate = DateTimeUtil.convertDate(endDateStr);
    }

    public ActivityType getActivityType() {
        // NOSTART(1), START(2), STOP(3), EXPIRED(4);
        return isStart() ? ActivityType.START : activityType;
    }

    public void setActivityType(ActivityType activityType) {
        // 为开始状态都是通过时间来判断
        this.activityType = activityType;
    }
    
    public void setType(int type) {
        this.activityType = ActivityType.valueOf(type);
    }
    
    public int getType() {
        return this.activityType.getCode();
    }

    public List<PointRule> getPointRules() {
        return pointRules;
    }

    public void setPointRules(List<PointRule> pointRules) {
        this.pointRules = pointRules;
    }
    
    public void addPointsRule(PointRule rule) {
        if (pointRules == null) {
            pointRules = new ArrayList<PointRule>();
        }
        pointRules.add(rule);
    }

    public int getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(int totalPoints) {
        this.totalPoints = totalPoints;
    }

    public int getUsedPoints() {
        return usedPoints;
    }

    public void setUsedPoints(int usedPoints) {
        this.usedPoints = usedPoints;
    }

    public int getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(int publisherId) {
        this.publisherId = publisherId;
    }

    public String getPublisherUuid() {
        return StringUtil.byteArrayToUuid(uuid);
    }

    public void setPublisherUuid(String publisherUuid) {
        if (!StringUtils.isEmpty(publisherUuid)) {
            this.uuid = new UUID(publisherUuid).asByteArray();
        }
    }

    public String getStartDateStr() {
        return DateTimeUtil.formatDate(startDate);
    }

    public String getEndDateStr() {
        return DateTimeUtil.formatDate(endDate);
    }
    
    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }
    
    public String getUrlPrefix() {
        return UrlUtil.getFullUrlWithPrefix(url);
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
    
    public String getShortName() {
        if (name.length() > 15) {
            return StringUtils.substring(name, 0, 15) + "...";
        } 
        return name;
    }

    public String getShortDescription() {
        if (description.length() > 15) {
            return StringUtils.substring(name, 0, 15) + "...";
        }
        return description;
    }
    
    public String getPublisherName() {
        return publisherName;
    }

    public void setPublisherName(String publisherName) {
        this.publisherName = ValidateUtil.escapeContent(publisherName);
    }
    
    public String getPublisherSite() {
        return publisherSite;
    }
    
    public String getPublisherSitePrefix() {
        return UrlUtil.getFullUrlWithPrefix(publisherSite);
    }

    public void setPublisherSite(String publisherSite) {
        this.publisherSite = publisherSite;
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

    /**
     * 计算可用的积分
     * 
     * @return
     */
    public int getAvailablePoints() {
        return totalPoints - usedPoints;
    }

    /**
     * 根据shareType，返回对应的分享/回流上限规则，如果没有，则默认返回总上限规则
     * 
     * @param pointsRuleType
     * @return
     */
    public PointRule getLimitPointRule(PointsRuleType pointsRuleType) {
        PointsRuleType limitPointType = null;
        if (PointsRuleType.SHARE == pointsRuleType) {
            limitPointType = PointsRuleType.SHARELIMIT;
        } else {
            limitPointType = PointsRuleType.CLICKBACKLIMIT;
        }

        PointRule limitPointRule = getPointRule(limitPointType);
        if (limitPointRule == null) {
            limitPointRule = getPointRule(PointsRuleType.TOTALLIMIT);
        }
        return limitPointRule;
    }

    /**
     * 根据pointType，返回对应的分享/回流规则
     * 
     * @param pointType
     * @return
     */
    public PointRule getPointRule(PointsRuleType type) {
        if (type == null || pointRules == null) {
            return null;
        }

        for (PointRule pointRule : pointRules) {
            if (pointRule.getPointsRuleType() == type) {
                return pointRule;
            }
        }
        return null;
    }
    
    public int getMaxSharePoints() {
        PointRule pointRule = getPointRule(PointsRuleType.SHARE);
        if (pointRule != null) {
            return activityLimitRule.getShareLimitNo() * pointRule.getPoints();
        }
        return 0;
    }

    public int getMaxClickBackPoints() {
        PointRule pointRule = getPointRule(PointsRuleType.CLICKBACK);
        if (pointRule != null) {
            return activityLimitRule.getClickBackLimitNo() * pointRule.getPoints();
        }
        return 0;
    }
    
    /**get the left point
     * @return
     */
    public int getLeftPoints() {
        return this.getTotalPoints() - this.getUsedPoints();
    }
    
    public ActivityCategory getActivityCate() {
        return activityCate;
    }

    public void setActivityCate(ActivityCategory activityCate) {
        this.activityCate = activityCate;
    }

    public ActivityLimitRule getActivityLimitRule() {
        return activityLimitRule;
    }

    public void setActivityLimitRule(ActivityLimitRule activityLimitRule) {
        this.activityLimitRule = activityLimitRule;
    }
    
    public String getDomain() {
        if (activityLimitRule != null) {
            return activityLimitRule.getDomain();
        }
        return null;
    }
    public String getActivityInfo() {
        return activityInfo;
    }

    public void setActivityInfo(String activityInfo) {
        this.activityInfo = activityInfo;
    }

    public int getIncreasePoints() {
        return increasePoints;
    }

    public void setIncreasePoints(int increasePoints) {
        this.increasePoints = increasePoints;
    }

    public void setDomain(String domain) {
        if (activityLimitRule == null) {
            activityLimitRule = new ActivityLimitRule();
        }
        activityLimitRule.setDomain(domain);
    }
    
    public boolean isStartRange() {
        Date current = new Date();
        if (startDate == null && endDate == null) {
            return false;
        }
        return current.after(startDate) && current.before(DateUtils.addDays(this.endDate, 1));
    }

    /**to check the activity is start,
     * if start return true
     * else return false
     * @return
     */
    public boolean isStart() {
        return (ActivityType.START == this.activityType || ActivityType.NOSTART == this.activityType) && isStartRange();
    }
    
    public boolean isStop() {
        return ActivityType.STOP == getActivityType();
    }
    
    public boolean isDelete() {
        return activityCate == ActivityCategory.NORMAL && activityType != ActivityType.START && usedPoints == 0;
    }
    
    public boolean isEdit() {
        return activityCate == ActivityCategory.NORMAL && activityType != ActivityType.DELETE &&
                ActivityType.EXPIRED != activityType;
    }
    
    public boolean isFinish() {
        return ActivityType.EXPIRED != getActivityType();
    }
    
    public boolean isNeedFinish() {
        for (PointRule rule : pointRules) {
            if (rule.getPoints() <= getLeftPoints()) {
                return false;
            }
        }
        return true;
    }

    public boolean isUsed() {
        return isUsed;
    }

    public void setUsed(boolean used) {
        this.isUsed = used;
    }
}
