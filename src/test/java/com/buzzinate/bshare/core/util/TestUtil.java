package com.buzzinate.bshare.core.util;


import java.sql.SQLException;

import javax.sql.DataSource;

import org.dbunit.DefaultDatabaseTester;
import org.dbunit.IDatabaseTester;
import org.dbunit.database.DatabaseDataSourceConnection;
import org.dbunit.database.IDatabaseConnection;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * 
 * @author martin
 *
 */
public final class TestUtil {

    private static ApplicationContext applicationContext;

    private static IDatabaseTester databaseTester;

    static {
        applicationContext = new ClassPathXmlApplicationContext(
                new String[] {"classpath:test_applicationContext.xml"});
        try {
            IDatabaseConnection conn = new DatabaseDataSourceConnection(
                    (DataSource) applicationContext.getBean("dataSource"));
            databaseTester = new DefaultDatabaseTester(conn);
        } catch (BeansException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("init applicationContext");
    }
    
    private TestUtil() { }

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    public static IDatabaseTester getDatabaseTester() {
        return databaseTester;
    }
}
