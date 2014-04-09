<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<meta name="description" content="请仔细阅读微积分平台的免责条款 " />
<title><s:text name="bshare.points.service"/> - <s:text name="bshare.points.title"/></title>

<style>
    .container-terms { margin: 10px 0 30px; padding: 30px 0; color: #666; font-size: 12px; }
    .wrapper-text { padding:0 40px; }
	.numberleft { width: 5%; }
	.numberright { width: 95%; }
	* html .numberleft { width: 2%; }
	* html .numberright { width: 97%; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/terms"><s:text name="bshare.points.service"/></a>
	</div>
	<div class="spacer20 clear"></div>
	
	<div class="module-white-grey div-shadow-5 container-terms">
	    <div class="wrapper-terms">
	        <%@ include file="/jsp/common/commTerms.jsp" %>
	    </div>
	    <div class="spacer20 clear"></div>
	</div>
</div>