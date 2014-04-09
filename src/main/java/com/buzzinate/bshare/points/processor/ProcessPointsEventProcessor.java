package com.buzzinate.bshare.points.processor;

import java.io.Serializable;

import com.buzzinate.bshare.points.Points.PointsParams;
import com.buzzinate.bshare.points.PointsEventHandleServices;
import com.buzzinate.bshare.points.bean.PointDetailParam;
import com.rabbitmq.client.QueueingConsumer.Delivery;

/**
 * 分享获取积分的Event处理类
 * 
 * @author Martin
 *
 */
public class ProcessPointsEventProcessor extends PointsEventBaseProcessor implements Serializable {
    
    private static final long serialVersionUID = -7440153517932059613L;
    
    private String processorName = "Points processor";
    
    @Override
    protected void process(Delivery delivery) throws Exception {
        PointsParams pp = PointsParams.parseFrom(delivery.getBody());
        PointDetailParam pdp = new PointDetailParam(pp);
        pointService.process(pdp);
    }
    
    @Override
    protected String getProcessorName() {
        return processorName;
    }

    @Override
    protected String getQueueName() {
        return PointsEventHandleServices.PROCESS_POINTS_QUEUE_NAME;
    }
}
