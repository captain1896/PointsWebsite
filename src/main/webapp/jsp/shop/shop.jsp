<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
pageContext.setAttribute("bSharePointsUuid", com.buzzinate.common.util.ConfigurationReader.getString("bshare.points.uuid"));
%>

<title><s:text name="bshare.points.title"/></title>

<style>
    .container-full { background: #d9d9d9; padding: 20px 0; display: block; width: 100%; overflow: hidden; }
    #bannerDiv { height: 300px; width: 640px; hidden; border: 1px solid #fff; position: relative; background: transparent; }
    #activityList { height: 300px; width: 320px; border: 1px solid #ddd; 
        background: url(${points_image_path}/bkg-grey-white.gif) repeat-x #fff; }
    #activityList .wrapper-header { background: none; height: 30px; margin-left: 20px; margin-top: 0; width: auto; font-size: 14px; color: #1e9ede; }
    #activityList .list-activity { padding: 5px 10px; height: 240px; overflow: hidden; }
        
    .container-exchanges { display: block; z-index: 100; }
    .container-exchanges .wrapper-header { font-size: 12px; }
    .wrapper-exchange { margin: 0 15px 20px 0; padding: 15px; width: 29%; background-color: #fff; border: 1px solid #e0e0e0; 
        position: relative; box-shadow: 0 0 10px #ddd; }
    .wrapper-exchange.last { margin-right: 0; }
    .pLabel-new { position: absolute; left: -2px; *left: -17px; top: -4px; display: block; width: 54px; height: 54px;
        background: url(${points_image_path}/icons/product-label.png) no-repeat; }
    .exchange-image { border: 1px solid #dadada; width: 150px; height: 150px; display: inline-block;*display: inline; zoom: 1;margin-right: 15px; }
    .exchange-image img { display: block; margin: 0 auto; }
    .card-exchange { zoom: 1; overflow: hidden; height: 150px; position: relative; }
    .card-exchange a { text-decoration: none; }
    .exchange-title { height: 48px; line-height: 24px; display: block; overflow: hidden; word-wrap: break-word; }
    .exchange-summary { color: #555; font-size: 12px; height: 45px; line-height: 15px; display: block; overflow: hidden; word-wrap: break-word; }
    .exchange-points { font-size: 12px !important; }
    .exchange-button { padding: 6px 40px; font-size: 12px; }
    .exchange-like { position: absolute; bottom: 15px; right: 10px; }
    
    .container-category { padding: 20px 20px 10px; }
    .wrapper-category { height: 30px; line-height: 30px; width: 120px; color: #666; }
</style>
    
<div class="container-full">
    <div class="container-center">
		<div id="bannerDiv" class="container-banner left">
		    <%@ include file="/jsp/common/commBanner.jsp"%>
		</div>
		<div id="activityList" class="container-activities right">
		    <%@ include file="/jsp/common/commActivities.jsp"%>
		</div>
    </div>
</div>
<div class="clear"></div>

<div class="container-center">
    <div class="spacer20 clear"></div>
	<sec:authorize ifNotGranted="ROLE_ADMIN">
	<%@ include file="/jsp/common/commPointExchange.jsp"%>
	</sec:authorize>
	
	<div class="container-category">
	    <s:iterator value="#request.categories" var="category" status="status">
	       <a class="wrapper-category heading4 inlineBlock bLinkDark" href="${points_cxt_path}/shop/category/${category.nameEn}">${category.name}（${category.prodNum}）</a>
	    </s:iterator>
	    <div class="clear"></div>
	</div>
	<div class="clear"></div>
	
	<div class="container-exchanges">
	    <s:iterator value="#request.exchanges" var="exchange" status="status">
	    <div class="wrapper-exchange left<s:if test="%{#status.count % 3 == 0}"> last</s:if>">
	        <s:if test="%{#exchange.isNew}">
	            <span class="pLabel-new"></span>
	        </s:if>
	        <a class="exchange-image left" href="${points_cxt_path}/shop/product/${exchange.id}" target="_blank" title="${exchange.name}"><img src="${exchange.thumbnail}" /></a>
	        <div class="card-exchange">
	            <a href="${points_cxt_path}/shop/product/${exchange.id}" target="_blank" class="exchange-title bLinkBlue heading3" title="${exchange.name}">${exchange.name}</a>
	            <div class="spacer15"></div>
	            <a href="${points_cxt_path}/shop/product/${exchange.id}" target="_blank" class="exchange-summary bLinkDark" title="${exchange.desc}">${exchange.desc}</a>
	            <div class="spacer5"></div>
	            <p class="exchange-points heading4"><s:text name="bshare.points.need.points"><s:param value="%{#exchange.currentPoints}"/></s:text></p>
	        </div>
	        <div class="clear spacer10"></div>
            <p style="font-size:12px;color:#666;height:16px;overflow:hidden;">奖品提供：<a class="bLinkBlue" href="${exchange.merchant.homeURLPrefix}" target="_blank">${exchange.merchant.name}</a></p>
            <div class="clear"></div>
	    </div>
	    </s:iterator>
	    <div class="spacer5 clear"></div>
	    <div class="wrapper-header">
	        <a class="bLinkBlue keyword right" href="${points_cxt_path}/shop/category/all" target="_blank"><s:text name="bshare.shop.product.more"/><span class="icon-more"></span></a>
	    </div>
	    <div class="clear"></div>
	</div>
</div>

<!-- 
<script type="text/javascript" charset="utf-8">
bShareOpt = {
   uuid: "${bSharePointsUuid}",
   template: "1" 
};
</script>
<script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/bshareLike.js#&color=blue"></script>
<script type="text/javascript" charset="utf-8">
function initLikeButtons() {
	<s:iterator value="#request.exchanges" var="exchange" status="status">
	bShareLike.addEntry({
		url: "${points_cxt_path}/shop/product/${exchange.id}",
		pic: "${exchange.pic}",
		title: "${exchange.name}"
	});
	</s:iterator>
}

$(document).ready(function () {
    initLikeButtons();
});
</script>
-->
