<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/jsp/common/init.jsp"%>

<style type="text/css">
    .main-bottom-menu { width: 100%; background-color: #0097d2; overflow: hidden; font-size: 12px; }
    .web-base-links { text-align: center; color: #fff; }
    .web-base-links a { padding: 12px 0; margin: 0 5px; text-align: center; text-decoration: none; color: #fff; }
    .main-bottom-copyright { color: #fff; }
</style>

<div class="main-bottom-menu">
    <div class="container-center">
        <div class="spacer20"></div>
        <div class="web-base-links">
	        <a href="${points_cxt_path}/terms" target="_blank"><s:text name="bshare.points.service"/></a>
	        <span class="hspacer10" style="color:#fff;">|</span>
	        <a href="${points_cxt_path}/privacy" target="_blank"><s:text name="bshare.points.privacy.title"/></a>
	        <span class="hspacer10" style="color:#fff;">|</span>
	        <a href="${main_cxt_path}/career" target="_blank"><s:text name="bshare.points.recruit"/></a>
        </div>
        <div class="spacer20"></div>
	    <div style="text-align:center;font-size:10px;">
	        <span><a target="_blank" title="<s:text name="bshare.icp"/>" class="bLink text-white" style="text-decoration:none;" href="http://www.miibeian.gov.cn/"><s:text name="bshare.icp"/></a></span>
            <div class="clear spacer2"></div>
	        <span class="main-bottom-copyright">&copy; 2009-<%=java.util.Calendar.getInstance().get(Calendar.YEAR)%> <s:text name="bshare.points.copyright"/></span>
	        <div class="clear"></div>
	    </div>
	    <div class="clear spacer15"></div>
	    <div style="text-align: center;">
	        <a target="_blank" href="http://www.sgs.gov.cn/lz/licenseLink.do?method=licenceView&entyId=20120703161312773"><img src="${image_path}/sgs_license.gif" border=0 /></a>
	    </div>
    </div>
    <div class="right" style="margin:-11px 15px 0 0;"><a target="_blank" title="Buzzinate" href="http://www.buzzinate.com/"><img alt="a buzzinate company" title="Buzzinate" src="${image_path}/buzzinate-company-white.png"/></a></div>
    <div class="clear spacer50"></div>
</div>

<div class="clear"></div>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-33657368-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>