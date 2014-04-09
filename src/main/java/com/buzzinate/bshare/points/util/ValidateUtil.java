package com.buzzinate.bshare.points.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.util.HtmlUtils;

/**
 * to check whether whether is validate content
 * @author james.chen
 * @since 2012-6-25
 */
public final class ValidateUtil {
    
    private static final String UICONTENTREX = "^[0-9A-Za-z_ \\u0100-\\uFFFF\\.\\,\\-@]+$";
    
    private ValidateUtil() {
    }
    
    /**
     * validate the content from UI
     * e.g <script> return false
     *     script return true
     * @param content
     * @return
     */
    public static boolean isValidContent(String content) {
        Pattern pattern = Pattern.compile(UICONTENTREX);
        Matcher matcher = pattern.matcher(content);
        return matcher.matches();
    }
    
    /** escape the content
     * @param content
     * @param largeLen
     * @return
     */
    public static String escapeContent(String content , int largeLen) {
        
        return HtmlUtils.htmlEscape(StringUtils.substring(HtmlUtils.htmlUnescape(content), 0, largeLen));
    }
    
    public static String escapeContent(String content) {
        return escapeContent(content, 100);
    }
    
    public static String unescapeContent(String content) {
        return HtmlUtils.htmlUnescape(content);
    }
    
    public static String unescapeSpecail(String content) {
        String[] searchs = new String[] {"<script>", "</script>" };
        String[] replaces = new String[] {"&lt;script&gt;", "&lt;/script&gt;" };
        return StringUtils.replaceEach(HtmlUtils.htmlUnescape(content), searchs, replaces);
    }
}
