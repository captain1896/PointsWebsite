package com.buzzinate.bshare.points.task;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.service.ActivityService;
import com.buzzinate.common.task.SingleServerTask;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.DateTimeUtil;

/**
 * 处理活动过期，结束活动积分返还。
 * 
 * @author martin
 * 
 */
@Component
public class ProcessActivityTask extends SingleServerTask {

    private static Log log = LogFactory.getLog(ProcessActivityTask.class);

    @Autowired
    private ActivityService activityService;
    
    
    public ProcessActivityTask() {
        super(ConfigurationReader.getString("bshare.setting.default.task.host"));
    }


    @Override
    public void doJob() {
        
        Date yestoday = DateTimeUtil.getYestoday();
        // if process fail, add to this list
        List<Activity> finishRetry = new ArrayList<Activity>();
        List<Activity> activitys = activityService.getFinishActivityByDate(yestoday);
        for (Activity a : activitys) {
            boolean isFinish = activityService.processFinishActivity(a);
            if (!isFinish) {
                finishRetry.add(a);
            }
        }
        // reprocess fail finish activity
        for (Activity a : finishRetry) {
            boolean isFinish = activityService.processFinishActivity(a);
            if (!isFinish) {
                log.error("reprocess fail finish activity id:" + a.getId() + ", name:" + a.getName());
            }
        }
    }
}
