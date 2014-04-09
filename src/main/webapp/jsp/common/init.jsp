<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<s:set var="repo_path" value="#application.REPOSITORY_PATH" />
<s:set var="cxt_path" value="#application.CTX_PATH" />
<s:set var="main_cxt_path" value="#application.MAIN_CTX_PATH" />
<s:set var="points_cxt_path" value="#application.POINTS_CTX_PATH" />
<s:set var="static_cxt_path" value="#application.STATIC_CTX_PATH" />
<s:set var="one_cxt_path" value="#application.ONE_CTX_PATH" />

<s:set var="frame_image_path" value="%{#application.STATIC_CTX_PATH + '/frame/images'}" />
<s:set var="frame_js_path" value="%{#application.STATIC_CTX_PATH + '/frame/js'}" />
<s:set var="image_path" value="%{#application.STATIC_CTX_PATH + '/images'}" />
<s:set var="js_path" value="%{#application.STATIC_CTX_PATH + '/js'}" />
<s:set var="css_path" value="%{#application.STATIC_CTX_PATH + '/css'}" />
<s:set var="points_image_path" value="%{#application.STATIC_CTX_PATH + '/points/images'}" />
<s:set var="points_js_path" value="%{#application.STATIC_CTX_PATH + '/points/js'}" />
<s:set var="points_css_path" value="%{#application.STATIC_CTX_PATH + '/points/css'}" />

<%
org.apache.struts2.ServletActionContext.getActionContext(request).put("isGlobalServer",com.buzzinate.common.util.ConfigurationReader.getBoolean("bshare.is.global.server"));

pageContext.setAttribute("bshareDomain",com.buzzinate.common.util.ConfigurationReader.getString("bshare.server.location"));
pageContext.setAttribute("bshareWwwDomain",com.buzzinate.common.util.ConfigurationReader.getString("bshare.server.address"));
pageContext.setAttribute("bshareStaticDomain",com.buzzinate.common.util.ConfigurationReader.getString("bshare.static.server.address"));
pageContext.setAttribute("googleAnalyticsId",com.buzzinate.common.util.ConfigurationReader.getString("bshare.google.analytics.id"));

pageContext.setAttribute("jquerySrc",com.buzzinate.common.util.ConfigurationReader.getString("bshare.jquery.1.7"));
pageContext.setAttribute("jqueryUiCssSrc",com.buzzinate.common.util.ConfigurationReader.getString("bshare.jquery.ui.css.1.8.2"));
pageContext.setAttribute("jqueryToolsFormsSrc",com.buzzinate.common.util.ConfigurationReader.getString("bshare.jquery.tools.forms.1.2.6"));
pageContext.setAttribute("jqueryToolsUiSrc",com.buzzinate.common.util.ConfigurationReader.getString("bshare.jquery.tools.ui.1.2.6"));
pageContext.setAttribute("jqueryToolsToolboxSrc",com.buzzinate.common.util.ConfigurationReader.getString("bshare.jquery.tools.toolbox.1.2.6"));
pageContext.setAttribute("bshareAuthServer",com.buzzinate.common.util.ConfigurationReader.getString("bshare.auth.server"));
%>