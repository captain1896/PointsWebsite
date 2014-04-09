<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${title}</title>
<script type="text/javascript" charset="utf-8">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript" charset="utf-8">
try {
var pageTracker = _gat._getTracker("${googleAnalyticsId}");
pageTracker._setDomainName("${bshareWwwDomain}");
pageTracker._trackPageview();
} catch(err) {}</script>
</head>
<body>
<script type="text/javascript" charset="utf-8">
try {
    if (window.opener) {
    	window.opener.location.reload();
    	window.opener = null;
    	window.open("", "_self");
    }
} catch(e){
    //alert(e);
}
window.close();
</script>
</body>
</html>