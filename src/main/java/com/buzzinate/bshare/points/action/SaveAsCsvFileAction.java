package com.buzzinate.bshare.points.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * @author John Chen Jul 9, 2010 Copyright 2009-2010 Buzzinate Co. Ltd.
 *
 */
@Controller
@Scope("request")
public class SaveAsCsvFileAction extends ActionSupport implements ServletResponseAware {
    
    private static final long serialVersionUID = 5845903669440051128L;
    
    private HttpServletResponse response;
    private String csvData = "";
    
    @Override
    public void setServletResponse(HttpServletResponse response) {
        this.response = response;
    }
    public void setCsvData(String csvData) {
        this.csvData = csvData;
    }
    public String getCsvData() {
        return csvData;
    }
    
    public void saveAsCsvFile() {
        response.setContentType("application/csv");
        response.setHeader("Content-disposition", "attachment; filename=\"bShare_Data.csv\"");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        
        PrintWriter out;
        try {
            out = response.getWriter();
            out.println(csvData);
            out.flush();
            out.close();
        } catch (IOException e) {
            // error getting stream...
        }
    }
}