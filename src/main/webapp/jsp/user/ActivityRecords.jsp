<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.user.record.activities"/> - <s:text name="bshare.points.user"/> - <s:text name="bshare.points.title"/></title>

<style>
    #activityList { background: #fff; float: none; width: auto; *width: 762px; border: 1px solid #dadada; }
    #activityList .list-activity li { border-top: none; float: left; margin-right: 4px; padding: 5px 8px; 
        width: 222px; *width: 218px; background: #fff; margin-bottom: 10px; }
    #activityList .list-activity { padding: 10px 0; }
    #activityList .activity-info { padding-left: 10px; }
</style>

<div class="container-center">
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right module-white-grey module-backend">
        <div class="div-gradient-linear-light text-blue heading3 div-rounded-bottom-5" style="padding: 10px 20px;border:1px solid #DDD;margin-top: -1px;">
            <s:text name="bshare.points.user.record.activities" />
        </div>
        <div class="clear spacer20"></div>
        
        <table class="bTable">
            <colgroup>
                <col style="width: 70%;" />
                <col style="width: 30%;" />
            </colgroup>
            <tr>
                <th><s:text name="bshare.points.activity.name" /></th>
                <th style="text-align:right;"><s:text name="bshare.points.point" /></th>
            </tr>
            <s:if test="#request.activityRecords.size > 0">
                <s:iterator value="#request.activityRecords" var="activity" status="status">
                    <tr<s:if test="%{#status.count % 2 == 1}"> class="second"</s:if>>
                        <td>${activity.activityName}</td>
                        <td style="text-align:right;">${activity.points}</td>
                    </tr>
                </s:iterator>
            </s:if>
            <s:else>
	            <td style="color:red;font-weight:bold;text-align:center;padding:20px 0;background:#ffd9d9 !important;"
                       colspan="2">您还没有参加活动。</td>
	        </s:else>
        </table>

        <div class="clear spacer30"></div>
        <div id="activityList" class="container-activities">
           <%@ include file="/jsp/common/commActivities.jsp"%>
           <div class="clear"></div>
        </div>
        <div class="clear spacer20"></div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
$(function() {
    $("#activityList .activity-summary").hide();
    $("#activityList .card-activity").show();
});
</script>
