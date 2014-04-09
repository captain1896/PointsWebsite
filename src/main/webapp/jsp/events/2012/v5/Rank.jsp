<%@ include file="/jsp/common/init.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	pageContext.setAttribute("bSharePointsUuid",
			com.buzzinate.common.util.ConfigurationReader
					.getString("bshare.points.uuid"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Language" content="${curLang}" />
	<meta name="description" content="分享送积分 好礼享不停只要您在活动期间进行分享便可获得积分兑换成各种礼物" />
	<meta name="keywords" content="v5, 微积分, 分享, 好礼, 分享送积分 好礼享不停" />
	<meta name="author" content="Buzzinate" />
	<title>分享送积分 好礼享不停 - <s:text name="bshare.points.title" /></title>
	
	<link rel="stylesheet" href="${points_css_path}/bsharePoints.css" type="text/css" />
	<style type="text/css">
.container-nav { background: #0097d2; }
.container-logo { display: none; }

.container { background: #ffe068; }
.container-rank { width: 980px; }
.wrapper-intro { background: url(${points_image_path}/events/v5/bkg-body-rank.jpg) no-repeat; height: 366px; }
.wrapper-rank { background: #fff; padding: 0 30px 30px; border-radius: 0 0 10px 10px; font-size: 14px; }
.wrapper-rank tr { height: 58px; line-height: 58px; }

.bButton-join { display: block; width: 160px; text-align: center; font-size: 16px; font-weight: bold; 
    margin: 0 auto; padding: 5px 0; }
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
	            <span style="color: red;"><strong><s:text
	                        name="bshare.no.js" /></strong></span>
	            <div class="spacer10"></div>
	        </noscript>
	    </div>
	    
	    <%@ include file="/jsp/common/topMenu.jsp"%>
	    
	    <div class="clear"></div>
	    <div class="container-center container-rank">
            <div class="wrapper-intro">
                <div class="clear"></div>
            </div>
	        <div class="wrapper-rank">
	            <table class="bTable">
                    <s:iterator value="#request.activities" var="activity" status="status">
                    <tr>
                        <td style="width: 30%;">
                            <a title="${activity.publisherName}" class="bLinkDark" 
                                href="${activity.publisherSite}">${activity.publisherName}</a>
                        </td>
                        <td style="text-align: center;">
                            <a title="${activity.publisherSite}" class="bLinkDark" 
                                href="${activity.publisherSite}">${activity.publisherSite}</a>
                        </td>
                        <td style="text-align: center;">
                            <s:text name="bshare.points.number.format">
                                <s:param value="#activity.usedPoints"></s:param></s:text>
                        </td>
                    </tr>
                    </s:iterator>
	            </table>
	            <div class="spacer30"></div>
	            <a class="bButton-blue bButton-join" href="${points_cxt_path}/events/2012/v5/2c">返回活动页面</a>
	            <div class="clear"></div>
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
		title : '分享送积分 好礼享不停',
		summary : '小小的分享，有精彩的回报',
		vUid : '<s:property value="%{#session.USER_ID}"/>',
		vEmail : '<s:property value="%{#session.DISPLAY_NAME}"/>',
		vTag : 'WEIJIFEN'
	});
});
</script>
</body>
</html>
