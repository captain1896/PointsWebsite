package com.buzzinate.bshare.points.bean;

import java.io.Serializable;

/**
 * 
 * @author martin
 * 
 */
public class PointAmount implements Serializable {

    private static final long serialVersionUID = 7979047526219011142L;

    private String amount;

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

}
