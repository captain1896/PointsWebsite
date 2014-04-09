<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<title>${request.handler.title} - <s:text name="bshare.points.title"/></title>

<div class="container-center">
<div class="module-white-grey module-full div-shadow-5" style="border:1px red solid;">
	<div class="left"><img src="${image_path}/404.jpg"/></div>
	<div class="left" style="padding-left:20px;width:640px;">
		<div class="spacer30"></div>
		<span style="color:black;font-size:40px;vertical-align:top;padding-top:10px;line-height:80px;">
			${request.handler.errorInfo}
		</span>
		<div class="spacer30"></div>
		<p style="color:black;font-size:30px;vertical-align:top;padding-top:10px;line-height:80px;">
			<s:text name="bshare.shop.exception.time"/><a href="${points_cxt_path}/${request.handler.backUrl}"><s:text name="bshare.shop.exception.direct"/></a>
		</p>
		<div class="spacer30"></div>
		<div class="clear"></div>
		<div class="heading2"><s:text name="bshare.points.thank.you"/></div>
		<div class="spacer30"></div>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
</div>
</div>

<script type="text/javascript" charset="utf-8">
	var tid = setInterval(function(){
		var time = $("#time").html();
		$("#time").html(Number(time)-1);
		 if ((time-1) == 0) {
			 window.location='${points_cxt_path}/${request.handler.backUrl}';
		     clearInterval(tid);
		 }
		}, 1000);
</script>