<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.stats.daily"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<div class="container-center">
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right">
	    <%@ include file="/jsp/common/statsComm.jsp" %>
	</div>
</div>

<script type="text/javascript" charset="utf-8">
function updateStatsForm() {
	$("#updateStatsForm").attr("action", "dailyStats");
    return true;
}

$(document).ready(function () {
    $("#updateStatsForm").bind("submit", updateStatsForm);
});
</script>
