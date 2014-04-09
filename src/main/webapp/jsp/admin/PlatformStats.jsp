<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.stats.platforms"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<style>
    .module-platform-buttons { margin: -10px 0 0; }
    .module-platform-buttons button { font-size: 12px; }
    .module-platform-buttons .bButton-blue { cursor: default; }
    .module-platform-buttons .bButton-blue:active { border: 1px solid #F89C2F; 
        background: #FF9D29; background: -webkit-gradient(linear, 0% 20%, 0% 90%, from(#FF9D29), to(#FF5C00)); background: -moz-linear-gradient(top, #FF9D29, #FF5C00); filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFFF9D29',EndColorStr='#FFFF5C00'); 
    }
</style>

<div class="container-center">
    <%@ include file="/jsp/common/leftMenu.jsp" %>
    
    <div class="container-right">
	    <%@ include file="/jsp/common/statsComm.jsp" %>
	    
	    <div class="module-white-grey module-backend">
	        <div class="clear spacer20"></div>
	        <div class="module-label div-rounded-bottom-5 text-blue left heading4"
	        style="margin-top: -21px;">
	            <s:text name="bshare.points.stats.platforms2" />
	        </div>
	        <div class="module-platform-buttons right">
	            <button class="bButton" value="share" onclick="updatePlatformChart(this);"
	            style="padding: 3px 15px;">
	                <s:text name="bshare.points.stats.shares" /><s:text name="bshare.points.stats.rank" />
	            </button>
	            <button class="bButton" value="clickback" onclick="updatePlatformChart(this);"
	            style="padding: 3px 15px;">
	                <s:text name="bshare.points.stats.burl.clicks" /><s:text name="bshare.points.stats.rank" />
	            </button>
	            <button class="bButton" value=conversion onclick="updatePlatformChart(this);"
	            style="padding: 3px 15px;">
	                <s:text name="bshare.points.stats.conversion.rates" /><s:text name="bshare.points.stats.rank" />
	            </button>
	        </div>
	        <div class="clear spacer20"></div>
	        <s:if test="%{#request.sortBy != 'conversion'}">
	        <div style="padding: 0 20px;">
	            <div class="clear spacer10"></div>
	            <div style="height:400px;">
	                <div id="divChartPlatforms" style="height:100%;width:100%">
	                    <div style="text-align:center;padding:10px 0;">
	                        <img title="<s:text name=" bshare.points.loading "/>..." alt="<s:text name="
	                        bshare.points.loading "/>..." src="${image_path}/ajaxLoad.gif" />&nbsp;
	                        <s:text name="bshare.points.loading" />...</div>
	                </div>
	            </div>
	            <div class="clear"></div>
	        </div>
	        <div class="clear spacer20"></div>
	        </s:if>
	        <table class="bTable">
	            <colgroup>
	                <col style="width: 25%;" />
	                <col style="width: 25%;" />
	                <col style="width: 25%;" />
	                <col style="width: 25%;" />
	            </colgroup>
	            <tr>
	                <th><s:text name="bshare.points.platform" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.stats.shares" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.stats.burl.clicks" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.stats.burl.clicks" /> / <s:text name="bshare.points.stats.shares" /></th>
	            </tr>
	            <s:if test="#request.platformStatsList.size > 0">
	            <s:iterator value="#request.platformStatsList" var="platformStatsInfo" status="count">
		            <tr<s:if test="%{#count.even}"> class="second"</s:if>>
			            <td title="<s:text name='buzzinate.platform.name.%{#platformStatsInfo.platformName}'/>">
			                <img style="vertical-align:bottom;margin-right:5px;" src="${frame_image_path}/logos/s4/${platformStatsInfo.platformName}.gif" />
		                    <s:text name="buzzinate.platform.name.%{#platformStatsInfo.platformName}" />
			            </td>
			            <td style="text-align:right;">
			                <s:text name="bshare.points.number.format"><s:param value="%{#platformStatsInfo.shareCount}" /></s:text>
			            </td>
			            <td style="text-align:right;">
			                <s:text name="bshare.points.number.format"><s:param value="%{#platformStatsInfo.clickbackCount}" /></s:text>
			            </td>
			            <td style="text-align:right;">${platformStatsInfo.shareToClickback}</td>
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
var currentPath = window.location.pathname;
var jsonDataPlatfrom = "{}";
function updateStatsForm() {
    $("#updateStatsForm").attr("action", "platformStats");
    return true;
}
function updatePlatformChart(target) {
    if ($(target).hasClass("bButton-blue")) {
        return;
    }
    $(".module-platform-buttons").find(".bButton-blue").removeClass("bButton-blue").addClass("bButton");
    var value = $(target).val();
    window.location.href = currentPath + '?dateStart=' + getDateStart() + '&dateEnd=' + getDateEnd() + '&sortBy=' + value;

}
function getOfcDataPlatforms() {
    return jsonDataPlatfrom.replace(/'/g, "\"");
}

function displayPlatformChart() {
    if (jsonDataPlatfrom != "" && jsonDataPlatfrom != "{}") {
        $("#divChartPlatforms").empty();
        var embedOptionsPlatforms = { id:'websiteChartPlatforms', src:ofcSource,version:[9,0], wmode:'opaque', expressInstall:expInsSource };
        var flashConfigurationPlatforms = { "id":"websiteChartPlatforms", "get-data":"getOfcDataPlatforms", "save_image_message":saveImageMsg, "loading":loadingMsg };
        flashembed("divChartPlatforms", embedOptionsPlatforms, flashConfigurationPlatforms);
    } else {
    	$("#divChartPlatforms").empty();
    	$("#divChartPlatforms").append("<div style='padding-top:20px;text-align:center;'><div class='warningMessage div-rounded-5'><p>尚无数据</p></div></div>");
    }
}

$(document).ready(function () {
    $(".bButton[value='${sortBy}']").removeClass("bButton").addClass("bButton-blue");
    $("#updateStatsForm").bind("submit", updateStatsForm);
    jsonDataPlatfrom = "${jsonDataPlatfrom}";
    displayPlatformChart();
});
</script>
