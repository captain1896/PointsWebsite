<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.stats.activities"/> - <s:text name="bshare.points.publisher"/> - <s:text name="bshare.points.title"/></title>

<style>
    .module-platform-buttons { margin: -10px 0 0; }
    .module-platform-buttons button { font-size: 12px; }
    .module-platform-buttons .bButton-blue { cursor: default; }
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
	            <button class="bButton-blue" value="share" onclick="updatePlatformChart(this);"
	                style="padding: 3px 15px;">
	                <s:text name="bshare.points.stats.shares" />
	                <s:text name="bshare.points.stats.rank" />
	            </button>
	            <button class="bButton" value="clickback" onclick="updatePlatformChart(this);"
	            style="padding: 3px 15px;">
	                <s:text name="bshare.points.stats.burl.clicks" />
	                <s:text name="bshare.points.stats.rank" />
	            </button>
	            <!-- 
	            <button class="bButton" value=conversion onclick="updatePlatformChart(this);"
	            style="padding: 3px 15px;">
	                <s:text name="bshare.points.stats.conversion.rates" />
	                <s:text name="bshare.points.stats.rank" />
	            </button>
	             -->
	        </div>
	        <div class="clear spacer20"></div>
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
	    </div>
	</div>
</div>

<script type="text/javascript" charset="utf-8">
var jsonDataPlatfrom = "{}";
function updateStatsForm() {
    $("#updateStatsForm").attr("action", "activityStats");
    return true;
}
function updatePlatformChart(target) {
	if ($(target).hasClass("bButton-blue")) {
		return;
	}
	$(".module-platform-buttons").find(".bButton-blue").removeClass("bButton-blue").addClass("bButton");
	var value = $(target).val();
	var activityId = $("#activityId").val();
	$.getJSON('${points_cxt_path}/publisher/getPlatformChart?' + new Date().getTime(), 
			{sortBy: value, activityId: activityId, dateStart: getDateStart(), dateEnd: getDateEnd()}, function(results) {
          if (results.success) {
	          	// Update platforms chart here
	          	jsonDataPlatfrom = results.contents.jsonDataPlatfrom;
                if (jsonDataPlatfrom != null && jsonDataPlatfrom != "" && jsonDataPlatfrom != '{}') {
                    displayPlatformChart();
                } else {
                	$("#divChartPlatforms").empty();
                	$("#divChartPlatforms").append("<div style='padding-top:20px;text-align:center;'><div class='warningMessage div-rounded-5'><p>尚无数据</p></div></div>");
                }
	          	$(target).addClass("bButton-blue");
          } else {
        	    displayStatusMessage('<s:text name="bshare.points.common.error"/>', "error");
          }
    });
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
    }
}

$(document).ready(function () {
    $("#updateStatsForm").bind("submit", updateStatsForm);
    jsonDataPlatfrom = "${jsonDataPlatfrom}";
    if (jsonDataPlatfrom != null && jsonDataPlatfrom != "" && jsonDataPlatfrom != '{}') {
        displayPlatformChart();
    } else {
        $("#divChartPlatforms").empty();
        $("#divChartPlatforms").append("<div style='padding-top:20px;text-align:center;'><div class='warningMessage div-rounded-5'><p>尚无数据</p></div></div>");
    }
});
</script>
