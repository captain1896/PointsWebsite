package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

/**
 * Exception handler object  to handle invalid input
 * @author james.chen
 * @since 2012-6-26
 */
public class ExceptionHandler implements Serializable {
  
    /**
     * 
     */
    private static final long serialVersionUID = -3239399033624572564L;
    private String title;
    private String errorInfo;
    private String backUrl;
    
    public ExceptionHandler() {

    }
    
    public ExceptionHandler(String title, String errorInfo, String backUrl) {
        this.title = title;
        this.errorInfo = errorInfo;
        this.backUrl = backUrl;
    }
    
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getErrorInfo() {
        return errorInfo;
    }
    public void setErrorInfo(String errorInfo) {
        this.errorInfo = errorInfo;
    }
    public String getBackUrl() {
        return backUrl;
    }
    public void setBackUrl(String backUrl) {
        this.backUrl = backUrl;
    } 
}
