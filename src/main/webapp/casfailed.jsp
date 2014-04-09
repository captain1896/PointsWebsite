<%@ page import="org.springframework.security.core.AuthenticationException" %>
<%@ page import="org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
<title>连接错误</title>
</head>
<body>
非常抱歉，连接时发生了错误。请重新连接。<br/>

<% 
response.setHeader("Cache-Control","no-cache");
response.setHeader( "Connection", "close" );
String refer = request.getHeader("Referer");
if (refer != null) {
    response.sendRedirect(refer);
} else {
    response.sendRedirect(com.buzzinate.common.util.ConfigurationReader.getString("bshare.auth.client") + "/login");
}

%>

</body>
</html>
