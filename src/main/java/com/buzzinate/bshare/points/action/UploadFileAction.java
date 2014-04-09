package com.buzzinate.bshare.points.action;

import java.io.File;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.buzzinate.bshare.user.service.LoginHelper;
import com.buzzinate.common.util.ConfigurationReader;
import com.buzzinate.common.util.ImageZipUtil;
import com.buzzinate.common.util.JsonResults;
import com.buzzinate.common.util.string.StringUtil;
import com.buzzinate.common.util.string.UrlUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.TextProvider;

/**
 * 
 * @author Martin
 * 
 */
@Controller
@Scope("request")
public class UploadFileAction extends ActionSupport {
    
    private static final long serialVersionUID = 3267255044279373966L;
    
    private static Log log = LogFactory.getLog(UploadFileAction.class);
    
    private static final String POINTS_PRODUCT = "points_product";
    private static final String POINTS_ACTIVITY = "points_activity";
    
    private static final int POINTS_PRODUCT_SOURCE_SIZE = 300;
    private static final int POINTS_PRODUCT_THUMBNAIL_SIZE = 150;
    private static final int POINTS_ACTIVITY_SOURCE_SIZE = 120;
    private static final int POINTS_ACTIVITY_THUMBNAIL_SIZE = 90;
    
    private static final String PATH = ConfigurationReader.getString("base.repository.path") + "/" + 
            ConfigurationReader.getString("bshare.points.image.path");
    private static final String WEB_PATH = ConfigurationReader.getString("base.repository.path.web") + "/" +
            ConfigurationReader.getString("bshare.points.image.path");
    
    
    // 50Kb
    private static final int MAX_IMAGE_SIZE = 51200;
    
    private JsonResults results;
    private TextProvider textProvider;
    private LoginHelper loginHelper;
    
    private String fileName;
    private String fileExtension;


    private String type;
    
    
    // for gallery, if user uploads another file, we need to delete the previous one.
    private String file2Del;

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    public void setFileExtension(String fileExtension) {
        this.fileExtension = fileExtension;
    }
    public void setFile2Del(String file2Del) {
        this.file2Del = file2Del;
    }
    public String getFile2Del() {
        return file2Del;
    }
    public void setLoginHelper(LoginHelper loginHelper) {
        this.loginHelper = loginHelper;
    }
    public void setTextProvider(TextProvider textProvider) {
        this.textProvider = textProvider;
    } 
    
    /**
     * JSON: uploads a gallery preview image
     * @return
     */
    public String ajaxGetImage() {
        results = new JsonResults();
        
        // permissions check
        if (!loginHelper.isLoggedIn()) {
            results.set(false, textProvider.getText("bshare.error.no.permission"));
            return JsonResults.JSON_RESULT_NAME;
        }
        
        // validation:
        if (fileName == null || fileName.isEmpty() || fileExtension == null || 
                fileExtension.isEmpty() || !UrlUtil.isImageFile(fileName)) {
            results.set(false, textProvider.getText("bshare.create.invalid.image.file"));
            return JsonResults.JSON_RESULT_NAME;
        }
        
        // get file:
        MultiPartRequestWrapper multipartRequest = (MultiPartRequestWrapper) ServletActionContext.getRequest();
        File[] files = multipartRequest.getFiles("tempFile");
        if (files.length <= 0) {
            results.set(false, textProvider.getText("bshare.create.upload.fail"));
            return JsonResults.JSON_RESULT_NAME;
        }
        // check for file size:
        File fileSrc = files[0];
        if (fileSrc.length() > MAX_IMAGE_SIZE) {
            results.set(false, textProvider.getText("bshare.create.image.too.large"));
            return JsonResults.JSON_RESULT_NAME;
        }
        
        String destFileName = StringUtil.get16ByteRandomString() + "." + StringUtils.lowerCase(fileExtension);
        String directory = StringUtils.left(destFileName, 1);
        
        String sourcePath = PATH + "source/" + directory + "/";
        String thumbnailPath = PATH + "thumbnail/" + directory + "/";
        File uploadSourcePath = new File(sourcePath);
        File uploadThumbnailPath = new File(thumbnailPath);
        // 如果该目录不存在,则创建之
        if (!uploadSourcePath.exists()) {
            uploadSourcePath.mkdirs();
        }
        if (!uploadThumbnailPath.exists()) {
            uploadThumbnailPath.mkdirs();
        }

        int sourceWidth = 0;
        int thumbnailWidth = 0;
        if (StringUtils.equals(type, POINTS_PRODUCT)) {
            sourceWidth = POINTS_PRODUCT_SOURCE_SIZE;
            thumbnailWidth = POINTS_PRODUCT_THUMBNAIL_SIZE;
        } else {
            sourceWidth = POINTS_ACTIVITY_SOURCE_SIZE;
            thumbnailWidth = POINTS_ACTIVITY_THUMBNAIL_SIZE;
        }
        ImageZipUtil.zipImageFile(fileSrc, new File(sourcePath + destFileName), sourceWidth, sourceWidth, 1.0f);
        ImageZipUtil.zipImageFile(fileSrc, new File(thumbnailPath + destFileName), thumbnailWidth, thumbnailWidth, 1.0f);
        String imgUrl = WEB_PATH + "source/" + directory + "/" + destFileName;
        results.addContent("url", imgUrl);
        results.addContent("filename", destFileName);
        return JsonResults.JSON_RESULT_NAME;
    }
    
    public JsonResults getResults() {
        return results;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}