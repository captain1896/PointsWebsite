<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.user.record.points"/> - <s:text name="bshare.points.user"/> - <s:text name="bshare.points.title"/></title>

<div class="container-center">
	<div class="container-right">
	    <div class="module-white-grey module-backend">
	        <div class="clear spacer20"></div>
	        <div class="div-gradient-linear-light text-blue" style="font-weight: bold; padding: 10px 20px;">
	            <s:text name="bshare.points.user.record.points" />
	        </div>
	        <div class="clear spacer20"></div>
	        <table class="bTable">
	            <tr>
	                <th><s:text name="bshare.points.record.date" /></th>
	                <th style="text-align:right;" ><s:text name="bshare.points.point" /></th>
	                <th style="text-align:center;"><s:text name="bshare.points.user.point.type" /></th>
	                <th style="text-align:center;"><s:text name="bshare.points.user.status.type" /></th>
	            </tr>
	            <s:if test="%{#request.pointRecords.size() > 0}">
	            <s:iterator value="#request.pointRecords" var="record" status="count">
	                <tr<s:if test="%{#count.even}"> class="second"</s:if>>
	                    <td>${record.dateTime}</td>
	                    <td style="text-align:right;">${record.points}</td>
	                    <td style="text-align:center;"><s:text name="bshare.points.activity.point.type.%{#record.pointsType}"/></td>
	                    <td style="text-align:center;"><s:text name="bshare.points.activity.status.type.%{#record.statusType}"/></td>
	                </tr>
	            </s:iterator>
	            </s:if>
	            <s:else>
	                <tr>
                        <td style="color:red;font-weight:bold;text-align:center;padding:20px 0;background:#ffd9d9 !important;"
                           colspan="4"><s:text name="bshare.points.stats.none" /></td>
                    </tr>
	            </s:else>
	        </table>
	        <div class="clear spacer20"></div>
	    </div>
	</div>
</div>

<script type="text/javascript" charset="utf-8">
$(document).ready(function () {

});
</script>
