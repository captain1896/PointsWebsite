<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<meta name="description" content="请仔细阅读微积分平台的帮助页面" />
<title>站长用户服务 - 帮助 - <s:text name="bshare.points.title"/></title>

<style>
.module-backend p { line-height: 200%; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
        <span>&gt;</span>
        <a class="bLinkDark" href="${points_cxt_path}/help">帮助</a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/help/pService">站长用户服务</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<%@ include file="/jsp/common/leftHelpMenu.jsp" %>
	
	<div class="container-right module-white-grey module-backend">
        <div class="clear spacer20"></div>
        <p class="heading3 text-blue">站长用户 -- 发点及烧点服务</p>
        <div class="clear spacer15"></div>
        <p>微积分是bShare为帮助站长用低成本提升用户黏着度，提高用户参与度，鼓励用进行分享、注册等行为的一个网上积分服务平台。在这里，我们帮助您用发放积分的方式，激励用户与网站的互动。</p>
        <div class="clear spacer10"></div>
        <p>微积分也为网站提供<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/shop/category/all">积分商城</a>，您可以成为烧点商，让用户使用积分兑换您网站的服务与商品，我们协助您将您的网站通过微积分，推广给其他用户！</p>
            
        <div class="clear spacer50"></div>
        <a class="bLinkBlue right" href="${points_cxt_path}/apply/publisher" target="_blank">立即加入微积分，马上行动！</a>
        <div class="clear spacer50"></div>
    </div>
	<div class="clear"></div>
</div>