<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
// Set HTTP Status Code to 404
response.setStatus(HttpServletResponse.SC_NOT_FOUND);
%>
<title><s:text name="bshare.points.top.404"/> - <s:text name="bshare.points.title"/></title>

<div class="container-center">
<div class="module-white-grey module-full div-shadow-5" style="border:1px red solid;padding:5px;">
	<div class="left"><img src="${image_path}/404.jpg"/></div>
	<div class="left" style="padding-left:20px;width:640px;">
	    <div class="spacer10"></div>
		<span style="color:black;font-weight:bold;font-size:100px;font-family:Arial,宋体,sans-serif;">404</span>&nbsp;&nbsp;
		<span class="heading1" style="color:black;font-size:40px;vertical-align:top;padding-top:10px;line-height:80px;">
			<s:text name="bshare.points.top.404"/>
		</span>
		<div class="spacer30"></div><div class="spacer10"></div>
		<p>
			<s:text name="bshare.points.404.msg1"/>
			<s:text name="bshare.points.404.msg2"/>
		</p>
		<div class="spacer10"></div>
		<p>
		    <a class="bLinkU" title="feedback@${bshareDomain}" href="mailto:feedback@${bshareDomain}">feedback@${bshareDomain}</a>
		</p>
		<div class="spacer30"></div>
		
		<div class="heading2"><s:text name="bshare.points.thank.you"/></div>
		
		<div class="spacer30"></div>
		
		<p>
			<sec:authorize ifAnyGranted="ROLE_ANONYMOUS">
				<a class="bLinkU" title="<s:text name="bshare.points.register"/>" href="${points_cxt_path}/register"><s:text name="bshare.points.register"/></a>
				<br/>
				<a class="bLinkU" title="<s:text name="bshare.points.login"/>" href="${points_cxt_path}/login"><s:text name="bshare.points.login"/></a>
			</sec:authorize>
		</p>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
</div>