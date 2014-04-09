package com.buzzinate.bshare.points.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.buzzinate.bshare.points.bean.Account;
import com.buzzinate.bshare.points.bean.Activity;
import com.buzzinate.bshare.points.exception.AccountOutOfBalanceException;

/**
 * 
 * @author Magic
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "/applicationContext-core.xml", "/applicationContext.xml" })
public class AccountServiceTest {

    @Autowired
    private AccountService accountService;

    private int publisherId = 123456789;
    private String pointName = "test活动";
    
    @Before
    public void setUp() throws Exception {
        accountService.createAccount(publisherId, pointName);
    }

    @After
    public void tearDown() throws Exception {
        accountService.deleteAccount(publisherId);
    }

    @Test
    public void testFindAccount() {
        Account account = accountService.findAccount(publisherId);
        assertEquals(publisherId, account.getPublisherId());
        
    }

    @Test
    public void testChargePoints() {
        Account account = accountService.findAccount(publisherId);

        int chargePoints = 1000;
        accountService.chargePoints(publisherId, chargePoints);
        
        Account newAccount = accountService.findAccount(publisherId);
        assertEquals(account.getCurrentPoints() + chargePoints, newAccount.getCurrentPoints());
        assertEquals(account.getAvailablePoints() + chargePoints, newAccount.getAvailablePoints());
        assertEquals(account.getTotalCharge() + chargePoints, newAccount.getTotalCharge());
        assertEquals(account.getTotalUsed(), newAccount.getTotalUsed());
    }

    @Test
    public void testDeductPoints() throws Exception {
        Account account = accountService.findAccount(publisherId);

        Activity activity = new Activity();
        activity.setId(1);
        activity.setPublisherId(publisherId);
        
        int deductPoints = 1000;
        accountService.chargePoints(publisherId, deductPoints);
        accountService.deductPoints(activity, deductPoints, false);
        
        Account newAccount = accountService.findAccount(publisherId);
        assertEquals(account.getCurrentPoints(), newAccount.getCurrentPoints());
        assertEquals(account.getAvailablePoints(), newAccount.getAvailablePoints());
        assertEquals(account.getTotalUsed() + deductPoints, newAccount.getTotalUsed());
        assertEquals(account.getTotalCharge() + deductPoints, newAccount.getTotalCharge());
    }
    
    @Test
    public void testDeductPointsOutOfBalance() {
        Account account = accountService.findAccount(publisherId);
        Activity activity = new Activity();
        activity.setId(1);
        activity.setPublisherId(publisherId);

        accountService.deductPoints(activity, account.getAvailablePoints() + 1, false);

        fail("account out of balance");
    }

    @Test
    public void testReturnPoints() {
        Account account = accountService.findAccount(publisherId);

        Activity activity = new Activity();
        activity.setId(1);
        activity.setPublisherId(publisherId);
        
        int returnPoints = 1000;
        accountService.returnPoints(activity);
        
        Account newAccount = accountService.findAccount(publisherId);
        assertEquals(account.getCurrentPoints() + returnPoints, newAccount.getCurrentPoints());
        assertEquals(account.getAvailablePoints() + returnPoints, newAccount.getAvailablePoints());
        assertEquals(account.getTotalCharge() + returnPoints, newAccount.getTotalCharge());
        assertEquals(account.getTotalUsed(), newAccount.getTotalUsed());
    }

}
