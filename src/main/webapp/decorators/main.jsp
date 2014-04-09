<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ include file="/jsp/common/init.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
String path = request.getServletPath();

if(path != null && path.trim() != "") {
    pageContext.setAttribute("curPath", path.substring(1));
} else {
    pageContext.setAttribute("curPath", "index");
}
pageContext.setAttribute("curLang", request.getLocale().getLanguage());

String queryString = request.getQueryString();
if(queryString != null && queryString.trim() != "") {
    if (queryString.indexOf("request_locale=") != -1) {
        String[] params = queryString.split("&");
        String qsr = "";
        for (String s : params) {
            if (s.startsWith("request_locale=")) {
                continue;
            }
            qsr += s + "&";
        }
        pageContext.setAttribute("queryString", "?" + qsr);
    } else {
        pageContext.setAttribute("queryString", "?" + queryString + "&");
    }
} else {
    pageContext.setAttribute("queryString", "?");
}
pageContext.setAttribute("bShareWebsiteUuid",com.buzzinate.common.util.ConfigurationReader.getString("bshare.website.uuid"));
pageContext.setAttribute("bSharePointsUuid",com.buzzinate.common.util.ConfigurationReader.getString("bshare.points.uuid"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Language" content="${curLang}" />
    <meta name="description" content="<decorator:getProperty property="meta.description" default="" />" />
    <meta name="keywords" content="<decorator:getProperty property="meta.keywords" default="微积分, 分享获取积分, 积分兑换商品" />" />
    <meta name="author" content="Buzzinate" />

    <title><decorator:title default="${bshareDomain}"/></title>

    <!-- Be aware: This will be replaced in build script -->
    <link rel="stylesheet" href="${points_css_path}/bsharePoints.css" type="text/css" />
    <% if (((String)pageContext.getAttribute("curPath")).startsWith("admin/")) { %>
        <style>
            .container-center { width: auto; margin: 0 20px; }
        </style>
    <% } %>
    
    <link rel="icon" href="http://www.bshare.cn/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="http://www.bshare.cn/favicon.ico" type="image/x-icon" />
    
    <script type="text/javascript" charset="utf-8">
        var BSHARE_WEBSITE_HOST = "${main_cxt_path}/";
        var BSHARE_BUTTON_HOST = "${button_cxt_path}/";
        var BSHARE_STATIC_HOST = "${static_cxt_path}/"; // used by bshare-web-common.js, unitpngfix.js and editor_config.js (ueditor)
        var bookmarkletOff = false;
    </script>
    <script type="text/javascript" charset="utf-8" src="${jquerySrc}"></script>
    <script type="text/javascript" charset="utf-8" src="${jqueryToolsUiSrc}"></script>
    <script type="text/javascript" charset="utf-8" src="${jqueryToolsToolboxSrc}"></script>
	<script type="text/javascript" charset="utf-8" src="${jqueryToolsFormsSrc}"></script>
	<script type="text/javascript" charset="utf-8" src="${js_path}/libs/jquery.autocomplete.pack.js"></script>
    <script type="text/javascript" charset="utf-8" src="${js_path}/libs/jquery.bgiframe.min.js"></script>
    <!-- Be aware: This will be replaced in build script -->
    <script type="text/javascript" charset="utf-8" src="${js_path}/bshare-web-common.js"></script>
    <!--[if lt IE 7]>
    <script type="text/javascript" charset="utf-8" src="${js_path}/libs/unitpngfix.js"></script>
    <![endif]-->
</head>

<body>
    <div class="container-center">
        <noscript>
            <span style="color:red;"><strong><s:text name="bshare.points.no.js"/></strong></span>
            <div class="spacer10"></div>
        </noscript>
    </div>

    <% if (!pageContext.getAttribute("curPath").equals("login") &&
            !pageContext.getAttribute("curPath").equals("loginAction") &&
            !pageContext.getAttribute("curPath").equals("register") &&
            !pageContext.getAttribute("curPath").equals("publisherStatisticsEmbed") &&
            !pageContext.getAttribute("curPath").equals("registerAction")
        ) { %>
        <%@ include file="/jsp/common/topMenu.jsp"%>
    <% } %>
    
    <div class="container-content">
	    <decorator:body />
        <div class="clear spacer30"></div>
    </div>
    <div class="clear"></div>
    
    <%@ include file="/jsp/common/bottomMenu.jsp"%>
    
    <%@ include file="/jsp/common/status.jsp"%>
    <%@ include file="/jsp/common/notifications.jsp" %>
    
    <% if (!((String)pageContext.getAttribute("curPath")).startsWith("admin/")
            && !((String)pageContext.getAttribute("curPath")).startsWith("publisher/")
            && !((String)pageContext.getAttribute("curPath")).startsWith("user/")
            && !((String)pageContext.getAttribute("curPath")).startsWith("shop/activity")
    ) { %>
    <a id="qqservicetab" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=<s:text name="bshare.contactus.qq.num"/>&site=qq&menu=yes"></a>
    <a class="bshareDiv" href="${main_cxt_path}/share"></a><script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/button.js#uuid=${bSharePointsUuid}&amp;style=3&amp;fs=4&amp;textcolor=#fff&amp;bgcolor=#1e9ede&amp;text=分享到"></script>
    <script type="text/javascript" charset="utf-8">
    $(function() {
    	setTimeout(function(){
    		bShare.addEntry({
                summary:"我正在使用微积分，你也来试试吧！ 更多超值产品，尽在微积分",
                vUid:'<s:property value="%{#session.USER_ID}"/>' , vEmail:'<s:property value="%{#session.DISPLAY_NAME}"/>', vTag:'BSHARE'});
    	},0);
        
    });
    </script>
    <% } %>
    
    <!-- SCRIPTS -->
    <script type="text/javascript" charset="utf-8">
        $(function() {
            var paths = "${curPath}";
            var s = paths.replace(/\//ig, "-");
            var rel = $(".leftMenu-" + s).addClass("active").parent().parent().attr("id");
            $("div[rel=" + rel + "]").addClass("active");
            $(".leftMenuTitle-" + s).addClass("bLeftMenuTitleActive");
        });
    </script>

    <!-- SCRIPTS-END -->
</body>
</html>
