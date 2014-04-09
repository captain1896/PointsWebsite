<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%pageContext.setAttribute("bSharePointsUuid",com.buzzinate.common.util.ConfigurationReader.getString("bshare.points.uuid")); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Language" content="${curLang}" />
    <meta name="description" content="分享送积分 流量享不停只要您在活动期间进行分享便可获得积分兑换成各种礼物" />
    <meta name="keywords" content="v5, 微积分, 分享, 流量, 分享送积分 流量享不停" />
    <meta name="author" content="Buzzinate" />
    <title>分享送积分 流量享不停 - <s:text name="bshare.points.title"/></title>

    <link rel="stylesheet" href="${points_css_path}/bsharePoints.css" type="text/css" />
    <style type="text/css">
.container-nav { background: #0097d2; }
.container-logo { display: none; }

.container { background: #ffe068; }
.container-intro { padding: 30px; }
.bButton-download { font-size: 16px; font-weight: bold; padding: 5px 40px; }
.wrapper-footer { font-size: 12px; }
    </style>
    
    <link rel="icon" href="http://www.bshare.cn/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="http://www.bshare.cn/favicon.ico" type="image/x-icon" />
    
    <script type="text/javascript" charset="utf-8" src="${jquerySrc}"></script>
    <!--[if lt IE 7]>
    <script type="text/javascript" charset="utf-8">
        var BSHARE_STATIC_HOST = "${static_cxt_path}/";
    </script>
    <script type="text/javascript" charset="utf-8" src="${js_path}/libs/unitpngfix.js"></script>
    <![endif]-->
</head>

<body>
    <div class="container">
        <div class="container-center">
	        <noscript>
	            <span style="color: red;"><strong><s:text name="bshare.no.js"/></strong></span>
	            <div class="spacer10"></div>
	        </noscript>
	    </div>
	    
	    <%@ include file="/jsp/common/topMenu.jsp"%>
	    
	    <div class="spacer30"></div>
	    <div class="container-center">
	        <div class="module-white-grey container-intro">
	            <p class="heading2 text-orange">参与网站需要在首页展示活动公告，广告模板下载</p>
	            <div class="spacer30"></div>
	            <p>大小：&nbsp;330&nbsp;KB</p>
	            <div class="spacer30"></div>
	            <a class="bButton-orange bButton-download" href="${points_image_path}/events/v5/download/template.jpg" target="_blank">立即下载</a>
	            <div class="spacer30"></div>
	            <div class="spacer1" style="border-bottom: 1px dashed #dadada;"></div>
	            <div class="spacer30"></div>
	            <p>简介：</p>
	            <div class="clear spacer5"></div>
	            <p>通过用户在浏览电商网站的过程中的分享行为，为网站带来更多的浏览量，提高转化率。</p>
	        </div>
	        <div class="clear spacer30"></div>
	    
	        <div class="wrapper-footer">
	            <p>本次活动最终解释权归&nbsp;<a class="bLinkBlue" href="${points_cxt_path}" target="_blank">微积分</a>&nbsp;所有</p>
	        </div>
	        <div class="clear"></div>
	    </div>
	    <div class="clear spacer30"></div>
    </div>
    
    <%@ include file="/jsp/common/bottomMenu.jsp"%>

<a class="bshareDiv" href="${main_cxt_path}/share"></a><script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/button.js#uuid=${bSharePointsUuid}&amp;style=3&amp;fs=4&amp;textcolor=#fff&amp;bgcolor=#ff6600&amp;text=分享到"></script>
<script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/button.js#uuid=${bSharePointsUuid}&amp;style=-1"></script>
<script type="text/javascript" charset="utf-8">
$(function() {
    bShare.addEntry({
        title: '分享送积分 流量涨不停',
        summary: '参与活动，获取bShare赠送的2000积分，开启社会化电商的引流之旅吧！',
        vUid: '<s:property value="%{#session.USER_ID}"/>', 
        vEmail: '<s:property value="%{#session.DISPLAY_NAME}"/>', 
        vTag: 'WEIJIFEN'
    });
});
</script>
</body>
</html>