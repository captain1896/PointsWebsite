<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<meta name="description" content="请仔细阅读微积分平台的帮助页面" />
<title>普通用户使用说明 - 帮助 - <s:text name="bshare.points.title"/></title>

<style>
.module-backend p { line-height: 200%; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
        <span>&gt;</span>
        <a class="bLinkDark" href="${points_cxt_path}/help">帮助</a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/help/eRule">普通用户使用说明</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<%@ include file="/jsp/common/leftHelpMenu.jsp" %>
	
	<div class="container-right module-white-grey module-backend">
        <div class="clear spacer20"></div>
        <p class="heading3 text-blue">普通用户如何使用微积分</p>
        <div class="clear spacer15"></div>
        <p>如果您是普通用户，您仅需要进入<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/shop/activities">积分商城</a>，选择您愿意参加的活动并进行分享，当您将内容分享到指定的平台（新浪微博、腾讯微博、QQ空间、sohu微博、网易微博、人人网、开心网、天涯微博），并为活动网站带来流量时，您就可以获取积分。</p>
        <div class="clear spacer10"></div>
        <p>若您已经拥有了微积分，您可以点击<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/shop/category/all">这里</a>查看您的可用微积分，并兑换心仪的商品。同时，微积分已经和集分宝等积分平台打通，您可以以相应的汇率兑换成您所需要的其他积分。</p>
            
        <div class="clear spacer50"></div>
        <a class="bLinkBlue right" href="${points_cxt_path}/shop/category/all" target="_blank">立即进入微积分商城，马上行动</a>
        <div class="clear spacer50"></div>
    </div>
	<div class="clear"></div>
</div>