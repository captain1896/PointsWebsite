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
.container-intro { width: 980px; }
.container-intro img { padding-left: 30px; }
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
	    
	    <div class="clear"></div>
        <div class="container-center container-intro">
	        <div class="spacer30"></div>
	        <p class="heading2 text-orange">1、   进入<a class="bLinkBlue" target="_blank" 
	            href="http://www.bshare.cn/help/installAction">http://www.bshare.cn/help/installAction</a>页面，注册或登录&nbsp;bShare；</p>
	        <div class="spacer20"></div>
	        <img src="${points_image_path}/events/v5/intro1.jpg" />
	        <div class="spacer30"></div>
	        <p class="heading2 text-orange">2、  登录后，点击“<span class="text-blue">bShare Plus</span>”按钮，显示出一段代码；</p>
	        <div class="spacer20"></div>
	        <img src="${points_image_path}/events/v5/intro2.jpg" />
	        <div class="spacer30"></div>
	        <p class="heading2 text-orange">3、  点击复制代码，将代码并安装到网站需要显示分享按钮的地方即可；</p>
	        <div class="spacer20"></div>
	        <img src="${points_image_path}/events/v5/intro3.jpg" />
	        <div class="spacer30"></div>
	        <p class="heading2 text-orange">4. 将bshare帐号、企业logo、链接等邮件<a class="bLinkBlue" target="_blank" href="mailto:events@buzzinate.com" 
	                title="events@buzzinate.com">events@buzzinate.com</a>，申请开始活动</p>
	        <div class="spacer50"></div>
	        <p class="heading1 text-orange" style="text-align: center; font-size: 32px;">完成</p>
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
