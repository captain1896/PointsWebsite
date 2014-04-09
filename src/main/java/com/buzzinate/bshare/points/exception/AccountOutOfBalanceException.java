package com.buzzinate.bshare.points.exception;

import com.buzzinate.common.exceptions.BaseException;

/**
 * 余额不足时抛出该异常
 * 
 * @author magic
 *
 */
public class AccountOutOfBalanceException extends BaseException {

    private static final long serialVersionUID = 1135974958826154569L;

    public AccountOutOfBalanceException() {
        super();
    }

    public AccountOutOfBalanceException(String reason) {
        super(reason);
    }

    public AccountOutOfBalanceException(String reason, Throwable cause) {
        super(reason, cause);
    }

}
