package com.buzzinate.bshare.points.db;

import java.util.Properties;

import org.aopalliance.intercept.MethodInvocation;
import org.hibernate.SessionFactory;
import org.springframework.aop.support.AopUtils;
import org.springframework.orm.hibernate3.SessionHolder;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.interceptor.TransactionAttribute;
import org.springframework.transaction.interceptor.TransactionAttributeSource;
import org.springframework.transaction.interceptor.TransactionInterceptor;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import com.buzzinate.bshare.points.db.MasterSlaveRoutingDataSource.DataSourceType;

public class MasterSlaveTransactionInterceptor extends TransactionInterceptor  {

    private static final long serialVersionUID = -2941460234104394272L;
    private SessionFactory sessionFactory;

    public MasterSlaveTransactionInterceptor() {
        super();
    }

    public MasterSlaveTransactionInterceptor(PlatformTransactionManager ptm,
            Properties attributes) {
        super(ptm, attributes);
    }

    public MasterSlaveTransactionInterceptor(PlatformTransactionManager ptm,
            TransactionAttributeSource tas) {
        super(ptm, tas);
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public Object invoke(final MethodInvocation invocation) throws Throwable {
        // Work out the target class: may be <code>null</code>.
        // The TransactionAttributeSource should be passed the target class
        // as well as the method, which may be from an interface.
        Class< ? > targetClass = invocation.getThis() != null ? 
                AopUtils.getTargetClass(invocation.getThis()) : null;

        // If the transaction attribute is null, the method is non-transactional.
        final TransactionAttribute txAttr = getTransactionAttributeSource()
                .getTransactionAttribute(invocation.getMethod(), targetClass);
        final PlatformTransactionManager tm = determineTransactionManager(txAttr);
        final String joinpointIdentification = methodIdentification(
                invocation.getMethod(), targetClass);
        
        SessionHolder sessionHolder =
            (SessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);
        if (sessionHolder == null || sessionHolder.getTransaction() == null) {
            // new transaction
            if (txAttr.getQualifier().equals("points")) { 
                MasterSlaveRoutingDataSource.setDataSourceType(
                        (txAttr == null || !txAttr.isReadOnly()) ? DataSourceType.MASTER_POINTS : 
                            DataSourceType.SLAVE_POINTS);
            } else {
                MasterSlaveRoutingDataSource.setDataSourceType(
                        (txAttr == null || !txAttr.isReadOnly()) ? DataSourceType.MASTER : DataSourceType.SLAVE);
            }
        }
        
        // Standard transaction demarcation with getTransaction and commit/rollback calls.
        TransactionInfo txInfo = createTransactionIfNecessary(tm, txAttr, joinpointIdentification);
        
        Object retVal = null;
        try {
            // This is an around advice: Invoke the next interceptor in the chain.
            // This will normally result in a target object being invoked.
            retVal = invocation.proceed();
        } catch (Throwable ex) {
            // target invocation exception
            completeTransactionAfterThrowing(txInfo, ex);
            throw ex;
        } finally {
            cleanupTransactionInfo(txInfo);
        }
        commitTransactionAfterReturning(txInfo);
        return retVal;
    }
}
