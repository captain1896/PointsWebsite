package com.buzzinate.bshare.points.processor;

import java.io.ByteArrayInputStream;
import java.io.ObjectInput;
import java.io.ObjectInputStream;
import java.io.Serializable;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.buzzinate.bshare.points.PointsEventHandleServices;
import com.rabbitmq.client.QueueingConsumer.Delivery;

/**
 * 
 * @author Martin
 *
 */

public class PointsEventProcessor extends PointsEventBaseProcessor implements Serializable {
    
    private static final long serialVersionUID = -1707507847985474746L;
    
    private static Log log = LogFactory.getLog(PointsEventProcessor.class);
    
    private String processorName = "Points processor";
    
    @Override
    protected void process(Delivery delivery) throws Exception {
        ObjectInput in = new ObjectInputStream(new ByteArrayInputStream(delivery.getBody()));
        int event = in.readInt();
        if (event == PointsEventHandleServices.EVENT_OLYMPIC) {
            boolean isStart = in.readBoolean();
            String uuid = in.readUTF();
            log.info("Process Olympic uuid=" + uuid + ", isStart=" + isStart);
            pointService.processOlympic(uuid, isStart);
            log.info("Process Olympic success!");
            
        } else if (event == PointsEventHandleServices.EVENT_MERGE_POINTS) {
            int userId = in.readInt();
            int userId2 = in.readInt();
            log.info("Merge user points from id=" + userId + " to id=" + userId2);
            pointService.processMergePoints(userId, userId2);
            log.info("Merge user points success!");
        }
    }
    
    @Override
    protected String getProcessorName() {
        return processorName;
    }

    @Override
    protected String getQueueName() {
        return PointsEventHandleServices.POINTS_QUEUE_NAME;
    }
}
