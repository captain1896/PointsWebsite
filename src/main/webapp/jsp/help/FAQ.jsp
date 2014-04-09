<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<meta name="description" content="请仔细阅读微积分平台的帮助页面" />
<title>常见问题 - 帮助 - <s:text name="bshare.points.title"/></title>

<style>
.separator { border-bottom: 1px dashed #dadada; margin: 15px 0; }
.module-backend p { line-height: 200%; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
        <span>&gt;</span>
        <a class="bLinkDark" href="${points_cxt_path}/help">帮助</a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/help/faq">常见问题</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<%@ include file="/jsp/common/leftHelpMenu.jsp" %>
	
	<div class="container-right module-white-grey module-backend">
        <div class="clear spacer20"></div>
        <p class="heading3 text-blue">微积分是否收费？</p>
        <div class="clear spacer15"></div>
        <p>对普通用户而言，微积分是一款完全免费的产品，您不需支付任何的费用。</p>
        <p>对发点商而言，微积分仅收取12%的服务费。<%-- 如果您希望免费参加我们的微积分计划，也可以点击<a class="bLinkBlue" target="_blank"
            href="${main_cxt_path}/olympic">这里</a>参与我们的任务，获取bShare赠送给您的微积分。--%></p>
        <div class="clear spacer10"></div>
        <p>对烧点商而言，微积分将根据合作的形式来决定是否收取费用。作为商品和服务提供商，您在提供商品之后，需要承担商品运输、客服等相应的服务。如果您有商品推荐、商品导入等额外的需求，请点击<a class="bLinkBlue"
            href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" target="_blank">这里</a>与我们联系。</p>
        <div class="clear spacer1 separator"></div>
        
        <p class="heading3 text-blue">微积分适用哪些平台...</p>
        <div class="clear spacer15"></div>
        <p>微积分目前支持以下平台：新浪微博、腾讯微博、QQ空间、搜狐微博、网易微博、人人网、开心网、天涯微博。</p>
        <div class="clear spacer1 separator"></div>
        
        <p class="heading3 text-blue">为什么我参加了活动却没有获得积分？</p>
        <div class="clear spacer15"></div>
        <p>如果您参与了活动却没有获得积分，有以下几种可能：</p>
        <div class="clear spacer10"></div>
        <p>1、   活动是否未开始或已过期。请先查看您所参加的活动是否在有效的时间段内，具体规则请点击<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/user/activityRecords">这里</a>查看您所参加的活动</p>
        <div class="clear spacer10"></div>
        <p>2、   活动所投放的积分已经发放完毕。具体规则请点击<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/user/activityRecords">这里</a>查看您所参加的活动</p>
        <div class="clear spacer10"></div>
        <p>3、    您还未带来足够的回流。由于每5次回流才可以获取一次积分奖励，若您带来的回流还不足5次的话将无法获取奖励。具体规则请点击<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/user/activityRecords">这里</a>查看您所参加的活动</p>
        <div class="clear spacer10"></div>
        <p>4、  您今天已经获取了本活动的积分上限。为避免恶意刷分的行为，我们设置了单日获取积分上限次数为20次的限制。具体规则请点击<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/user/activityRecords">这里</a>查看您所参加的活动</p>
        <div class="clear spacer10"></div>
        <p>5、  若以上问题都不能回答您的问题，请点击<a class="bLinkBlue"
            href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" target="_blank">这里</a>反馈您所遇到的问题。</p>
        <div class="clear spacer20"></div>
        
        <p class="heading3 text-blue">我发放的积分是否可能被恶意套取</p>
        <div class="clear spacer15"></div>
        <p>为保障站长利益，微积分在积分的发放时会对用户的行为进行过滤，我们确保只有真实有效的5次回流后才会对该用户进行奖励，并且每个用户，每天在一个网站可以获得奖励的总次数不超过20次。</p>
        <div class="clear spacer1 separator"></div>
            
        <div class="clear spacer50"></div>
        <a class="bLinkBlue right" href="${points_cxt_path}/apply/publisher" target="_blank">立即加入微积分，马上行动！</a>
        <div class="clear spacer50"></div>
    </div>
	<div class="clear"></div>
</div>