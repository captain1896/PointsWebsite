<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.stats.user"/> - <s:text name="bshare.points.publisher"/> - <s:text name="bshare.points.title"/></title>

<div class="container-center">
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right">
	    <%@ include file="/jsp/common/statsComm.jsp" %>
	    <div class="module-white-grey module-backend">
	        <div class="module-label div-rounded-bottom-5 text-blue heading4 left" style="margin-top: -1px;">
	            <s:text name="bshare.points.stats.user" /><s:text name="bshare.points.stats.rank" />
	        </div>
	        <div class="clear spacer20"></div>
	        <table class="bTable">
	            <colgroup>
                    <col style="width: 20%;" />
                    <col style="width: 20%;" />
                    <col style="width: 15%;" />
                    <col style="width: 15%;" />
                    <col style="width: 15%;" />
                    <col style="width: 15%;" />
                </colgroup>
	            <tr>
	                <th><s:text name="bshare.points.stats.user.uuid" /></th>
	                <th><s:text name="bshare.points.stats.user.email" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.stats.shares" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.stats.burl.clicks" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.stats.conversion.rates" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.stats.user.action" /></th>
	            </tr>
	            <s:if test="%{#request.users.size() > 0}">
		            <s:iterator value="#request.users" var="user" status="count">
			            <tr<s:if test="%{#count.even}"> class="second"</s:if>>
			                <td><a class="bLinkU" href="${user.link}">${user.uuid}</a></td>
			                <td title="${user.email}, ${user.shares}, ${user.clicks}, ${user.conversion}">${user.email}</td><td>${user.shares}</td><td>${user.clicks}</td><td>${user.conversion}</td>
			                <td><a class="bLinkU" href="${user.details}"><s:text name="bshare.points.view.details"/></a></td>
			            </tr>
	                </s:iterator>
                </s:if>
                <s:else>
                     <tr>
                        <td style="color:red;font-weight:bold;text-align:center;padding:20px 0;background:#ffd9d9 !important;"
                           colspan="6"><s:text name="bshare.points.stats.none" /></td>
                    </tr>
                </s:else>
	        </table>
	        <div class="clear spacer20"></div>
	    </div>
	</div>
</div>

<script type="text/javascript" charset="utf-8">
function updateStatsForm() {
	$("#updateStatsForm").attr("action", "userStats");
    return true;
}

$(document).ready(function () {
    $("#updateStatsForm").bind("submit", updateStatsForm);
	
});
</script>
