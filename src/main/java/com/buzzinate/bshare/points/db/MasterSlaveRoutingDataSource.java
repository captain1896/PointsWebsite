package com.buzzinate.bshare.points.db;

import java.io.Serializable;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * comments
 * @author comments
 */
public class MasterSlaveRoutingDataSource extends AbstractRoutingDataSource implements Serializable  {
    
    public static enum DataSourceType { MASTER, SLAVE, MASTER_POINTS, SLAVE_POINTS };
    
    private static final long serialVersionUID = -6050344099906428093L;
    
    private static ThreadLocal<DataSourceType> dataSourceType = new ThreadLocal<DataSourceType>() {
        @Override protected DataSourceType initialValue() {
            return DataSourceType.SLAVE_POINTS;
        }
    };  
    
    public static void setDataSourceType(DataSourceType t) {
        dataSourceType.set(t);
    }
    
    public static DataSourceType getDataSourceType() {
        return dataSourceType.get();
    }
    
    @Override
    protected Object determineCurrentLookupKey() {
        DataSourceType t = dataSourceType.get();
        return (t == null) ? DataSourceType.MASTER_POINTS.toString() : t.toString();
    }
}
