<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.access.denied"/> - <s:text name="bshare.points.title"/></title>

<div class="container-center">
<div class="module-white-grey module-full div-shadow-5" style="border:1px red solid;padding:5px;">
	<div class="left"><img src="${image_path}/503.jpg"/></div>
	<div class="left" style="padding-left:20px;width:450px;">
	    <div class="spacer10"></div>
		<span class="heading1" style="color:black;font-size:40px;vertical-align:top;padding-top:10px;">
			<s:text name="bshare.points.access.denied.title"/>
		</span>
		<div class="spacer30"></div><div class="spacer10"></div>
		<p>
		    <s:text name="bshare.points.access.denied.body"/>
		</p>
		<p>
			<s:text name="bshare.points.thank.you"/>
		</p>
		
		<div class="spacer10"></div>
	
		<sec:authorize ifAnyGranted="ROLE_UNVERIFIED">
			<%response.sendRedirect(request.getContextPath()+"/verify");%>
		</sec:authorize>
		
		<div class="spacer10"></div>

		<a class="bLinkU" title="feedback@${bshareDomain}" href="mailto:feedback@${bshareDomain}">feedback@${bshareDomain}</a>
		
		<div class="spacer30"></div>
		
		<div class="heading2"><s:text name="bshare.points.thank.you"/></div>
		
		<div class="spacer20"></div>
		
		<p>
			<sec:authorize ifNotGranted="ROLE_ANONYMOUS">
				<a class="bLinkU" style="font-size:20px;color:red;font-weight:bold;" title="<s:text name="bshare.points.logout"/>" href="${points_cxt_path}/logout"><s:text name="bshare.points.logout"/></a>
			</sec:authorize>
			<sec:authorize ifAnyGranted="ROLE_ANONYMOUS">
				<a class="bLinkU" title="<s:text name="register"/>" href="${points_cxt_path}/register"><s:text name="register"/></a>
				<br/>
				<a class="bLinkU" title="<s:text name="bshare.points.top.login"/>" href="${points_cxt_path}/login"><s:text name="bshare.points.login"/></a>
			</sec:authorize>
		</p>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
</div>