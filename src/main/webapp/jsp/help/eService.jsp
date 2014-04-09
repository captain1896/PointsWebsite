<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<meta name="description" content="请仔细阅读微积分平台的帮助页面" />
<title>积分商城服务 - 帮助 - <s:text name="bshare.points.title"/></title>

<style>
.module-backend p { line-height: 200%; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
        <span>&gt;</span>
        <a class="bLinkDark" href="${points_cxt_path}/help">帮助</a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/help/eService">积分商城服务</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<%@ include file="/jsp/common/leftHelpMenu.jsp" %>
	
	<div class="container-right module-white-grey module-backend">
        <div class="clear spacer20"></div>
        <p class="heading3 text-blue">普通用户 -- 积分商城服务</p>
        <div class="clear spacer15"></div>
        <p>若您是一个网站的访问者，您可以在微积分<a class="bLinkBlue" href="${points_cxt_path}/shop/activities" 
            target="_blank">赚取积分</a>，并将所赚取的积分在<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/shop/category/all">积分商城</a>，兑换成心仪的商品或服务。</p>
            
        <div class="clear spacer50"></div>
        <a class="bLinkBlue right" href="${points_cxt_path}/apply/publisher" target="_blank">立即加入微积分，马上行动！</a>
        <div class="clear spacer50"></div>
    </div>
	<div class="clear"></div>
</div>