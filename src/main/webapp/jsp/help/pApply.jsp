<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title>发点商资格申请 - <s:text name="bshare.points.publisher"/> - <s:text name="bshare.points.title"/></title>

<style>
    .container-text { padding: 30px 40px; color: #666; min-height: 400px; *height: 400px; }
    .wrapper-terms { border: 1px solid #dadada; background: #f9f9f9; height: 300px; overflow-x: hidden; overflow-y: scroll; font-size: 12px; }
    .wrapper-button { text-align: center; }
    .bButton-blue { padding: 5px 40px; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
        <span>&gt;</span>
        <a class="bLinkDark" href="${points_cxt_path}/help">帮助</a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/apply/publisher">发点商资格申请</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<div class="container-text module-white-grey div-shadow-5">
	    <sec:authorize ifNotGranted="ROLE_USER">
            <p>微积分是基于bShare体系的积分系统，因此请您先进行bShare站长的<a class="bLinkBlue" href="${points_cxt_path}/login" target="_blank">登录/注册</a>。</p>
        </sec:authorize>
        <sec:authorize ifAnyGranted="ROLE_USER" ifNotGranted="ROLE_PUBLISHER">
            <p>微积分是基于bShare体系的积分系统，您还不是bShare的网站站长，请点击<a class="bLinkBlue" href="${main_cxt_path}/userProfile" target="_blank">这里</a>升级为网站的站长。</p>
        </sec:authorize>
        <sec:authorize ifAnyGranted="ROLE_PUBLISHER" ifNotGranted="ROLE_POINTS_PUBLISHER">
            <p>微积分是基于bShare体系的积分系统，您已经是bShare的站长，您可以直接申请成为我们的发点商，请阅读并确认以下服务条款及免责声明后进行提交。</p><div class="spacer30 clear"></div>
            <div class="wrapper-terms">
                <%@ include file="/jsp/common/commTerms.jsp" %>
            </div>
            <div class="spacer30 clear"></div>
            <div class="wrapper-button"><a class="bButton-blue" href="${points_cxt_path}/user/applypointspublisher">同意并提交</a></div>
        </sec:authorize>
        <sec:authorize ifAnyGranted="ROLE_POINTS_PUBLISHER">
            <p>您已经是微积分发点商啦，欢迎使用微积分。</p>
        </sec:authorize>
	    <div class="spacer20 clear"></div>
	</div>
</div>