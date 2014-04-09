package com.buzzinate.bshare.points.exception;

import com.buzzinate.common.exceptions.BaseException;

/**
 * 
 * @author Johnson Ma
 *
 */
public class RichiApiException extends BaseException {

    private static final long serialVersionUID = -2973827531682636802L;
    
    public RichiApiException() {
        super();
    }
    
    public RichiApiException(String reason) {
        super(reason);
    }
    
    public RichiApiException(String reason, Throwable cause) {
        super(reason, cause);
    }

}
