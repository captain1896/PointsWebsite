package com.buzzinate.bshare.points.processor;

import java.io.Serializable;

import com.buzzinate.bshare.points.PointsEventHandleServices;
import com.rabbitmq.client.QueueingConsumer.Delivery;

/**
 * 
 * @author Martin
 *
 */

public class UuidActivityEventProcessor extends PointsEventBaseProcessor implements Serializable {

    private static final long serialVersionUID = 7956396877461074672L;

    private String processorName = "get uuid activity processor";
    
    @Override
    protected void process(Delivery delivery) throws Exception {
        pointService.processUuidActivity(delivery.getBody());
    }
    
    @Override
    protected String getProcessorName() {
        return processorName;
    }

    @Override
    protected String getQueueName() {
        return PointsEventHandleServices.UUID_ACTIVITY_QUEUE_NAME;
    }
    
}
