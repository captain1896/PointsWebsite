<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.top.error"/> - <s:text name="bshare.points.title"/></title>

<div class="container-center">
<div class="module-white-grey module-full div-shadow-5" style="border:1px red solid;padding:5px;">
	<div class="left"><img src="${image_path}/error.jpg"/></div>
	<div class="left" style="padding-left:20px;width:640px;">
	    <div class="spacer10"></div>
		<span class="heading1" style="color:black;font-size:40px;vertical-align:top;padding-top:10px;">
			<s:text name="bshare.points.error.title"/>
		</span>
		<div class="spacer30"></div><div class="spacer10"></div>
		<p>
			<s:text name="bshare.points.error.msg1"/>
		</p>
		
		<div class="spacer10"></div>
	
		<s:if test="%{#request.exception.class == @com.buzzinate.exceptions.BaseRuntimeException@class }">
			<div style="color:#F00;">
				<s:property value="%{#request.exception.message}" escape="false" />
			</div>
			<div class="spacer10"></div>
		</s:if>
		
		<s:text name="bshare.points.error.msg2"/>
		<div class="spacer10"></div>
		
		<!-- <a class="bLinkU" title="<s:text name="bshare.points.error.report"/>" href="${points_cxt_path}/errorReport"><s:text name="bshare.points.error.report"/></a> -->
		<div class="spacer5"></div>
		<a class="bLinkU" title="feedback@${bshareDomain}" href="mailto:feedback@${bshareDomain}">feedback@${bshareDomain}</a>
		
		<div class="spacer30"></div>
		
		<div class="heading2"><s:text name="bshare.points.thank.you"/></div>
		
		<div class="spacer30"></div>
		
		<p>
			<sec:authorize ifAnyGranted="ROLE_ANONYMOUS">
				<a class="bLinkU" title="<s:text name="register"/>" href="${points_cxt_path}/register"><s:text name="register"/></a>
				<br/>
				<a class="bLinkU" title="<s:text name="bshare.points.top.login"/>" href="${points_cxt_path}/login"><s:text name="bshare.points.top.login"/></a>
			</sec:authorize>
		</p>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
</div>