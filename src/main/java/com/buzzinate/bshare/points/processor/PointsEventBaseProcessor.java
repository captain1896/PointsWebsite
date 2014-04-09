package com.buzzinate.bshare.points.processor;

import java.io.Serializable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.buzzinate.bshare.points.service.PointService;
import com.buzzinate.common.util.ConfigurationReader;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.QueueingConsumer;

/**
 * 积分Event处理基础类
 * 
 * @author Martin
 *
 */
public abstract class PointsEventBaseProcessor implements Serializable {
    
    private static final long serialVersionUID = 4467392675450513159L;
    
    private static Log log = LogFactory.getLog(PointsEventBaseProcessor.class);
        
    protected ExecutorService executorService;
    
    @Autowired
    protected PointService pointService;
    
    public void start() {
        executorService = Executors.newSingleThreadExecutor();
        executorService.execute(new Runnable() {
            @Override
            public void run() {
                Connection handlerConn = null;
                Channel handlerChannel = null;
                try {
                    
                    ConnectionFactory factory = new ConnectionFactory();
                    factory.setHost(ConfigurationReader.getString("bshare.setting.rabbitmq.host"));
                    handlerConn = factory.newConnection();
                    handlerChannel = handlerConn.createChannel();
                    handlerChannel.queueDeclare(getQueueName(), true, false, false, null);
                    
                    QueueingConsumer consumer = new QueueingConsumer(handlerChannel);
                    handlerChannel.basicConsume(getQueueName(), true, consumer);
                    
                    log.info(getProcessorName() + "event handler started!");

                    while (true) {
                        QueueingConsumer.Delivery delivery;
                        try {
                            delivery = consumer.nextDelivery();
                        } catch (InterruptedException ie) {
                            break;
                        }

                        log.info("Start process.");
                        try {
                            process(delivery);
                        } catch (Exception e) {
                            log.error("Got Expcetion: ", e);
                        }
                        log.info("Finish process.");
                    }
                } catch (Exception e) {
                    log.error("Got Expcetion: " + e);
                }
            }


        });
    }

    public void stop() {
        if (executorService != null) {
            executorService.shutdown();
        }
        log.info("Shut down the event processor");
    }
    
    protected abstract String getProcessorName();

    protected abstract String getQueueName();

    protected abstract void process(QueueingConsumer.Delivery delivery) throws Exception;
    
}
