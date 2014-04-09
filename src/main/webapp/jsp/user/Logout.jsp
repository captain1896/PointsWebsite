<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<title><s:text name="bshare.points.logout"/></title>
<body>
	<script type="text/javascript" charset="utf-8" src="${renren_connect_api_url}"></script>
  	<script type="text/javascript" charset="utf-8">
    	XN_RequireFeatures(["EXNML"], function()
	    {
	      XN.Main.init("95265bb1554d40dbb6e4f76a1a67ad6c", "xd_receiver.html");
	    });
	</script>
</body>
</html>