<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.stats.contrast"/> - <s:text name="bshare.points.publisher"/> - <s:text name="bshare.points.title"/></title>

<style>
    #selectedActivityList { list-style: none; display: block; overflow: hidden; background-color: #fff; padding: 0 10px; margin: 10px 0 0 83px; width: 340px; }
    #selectedActivityList li { width: 330px; border: 1px solid #d0d0d0; padding: 5px; margin: 10px 0; }
    #selectedActivityList .activity-name { width: 310px; display: inline-block; *display: inline; zoom: 1; color: #333; }
    #selectedActivityList .closer { cursor: pointer; color: #e1e1e1; }
    #selectedActivityList .closer:hover { color: #999; }
</style>

<div class="container-center">
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right">
	    <%@ include file="/jsp/common/statsComm.jsp" %>
	    <div class="module-white-grey module-backend container-stats-effection">
		    <div style="padding: 0 20px;">
	        <div class="module-label div-rounded-bottom-5 text-blue left heading4" style="margin-top: 0px;">
		            <s:text name="bshare.points.stats.burl.clicks" /> /
		            <s:text name="bshare.points.stats.shares" /> -- <s:text name="bshare.points.stats.percentage"/>
		        </div>
	        <div class="clear spacer10"></div>
	        <div style="height:200px;">
	            <s:if test="%{#request.jsonDataConversion != null && #request.jsonDataConversion != '' && #request.jsonDataConversion != '{}'}">
	                <div id="divChartConversion" style="height:100%;width:100%">
	                    <div style="text-align:center;padding:10px 0;">
	                    <img title="<s:text name="bshare.points.loading"/>..." 
	                        alt="<s:text name="bshare.points.loading"/>..." 
	                        src="${image_path}/ajaxLoad.gif"/>&nbsp;<s:text name="bshare.points.loading"/>...
	                    </div>
	                </div>
	            </s:if>
	            <s:else>
	                <div style="padding-top: 20px; text-align: center;"><div class="warningMessage div-rounded-5"><p><s:text name="bshare.points.stats.none"/></p></div></div>
	            </s:else>
	        </div>
	        <div class="clear spacer20"></div>
	    	</div>
	    </div>
	</div>
</div>

<script type="text/javascript" charset="utf-8">

var embedOptionsConversion = { id:'pointsChartConversion', src:ofcSource,version:[9,0], wmode:'opaque', expressInstall:expInsSource};
var flashConfigurationConversion = { "id":"pointsChartConversion", "get-data":"getOfcDataConversion", "save_image_message":saveImageMsg, "loading":loadingMsg };
function getOfcDataConversion() {
    return unescapeJson("${jsonDataConversion}").replace(/'/g, "\"");
}
function updateStatsForm() {
    var activities = [];
    $("#selectedActivityList").find("li").each(function() {
    	activities.push($(this).attr("id"));
    });
    $("input[name=activities]").val(activities.join("|"));
    $("#updateStatsForm").attr("action", "activityContrast");
    return true;
}
function addActivity() {
	if ($(this).hasClass("bButton")) {
        return;
    }
    var value = $("#activityId").val();
    if (value == "0") {
        $("#selectedActivityList").empty();
        $("#activityId").find("option:not([value=0])").each(function() {
            insertActivity({
                id: $(this).val(),
                name: $(this).text()
            });
        });
    } else {
        insertActivity({
            id: $("#activityId").val(),
            name: $("#activityId").find("option:selected").text()
        });
    }
    $("#bButtonAdd").attr("disable", true).removeClass("bButton-blue").addClass("bButton").css({"cursor": "default"});
}
function changeActivity() {
	var value = $(this).val();
    if ($("li[id=" + value + "]").length > 0 || ($("#selectedActivityList").find("li").length == $("#activityId").find("option").length - 1)) {
        $("#bButtonAdd").attr("disable", true).removeClass("bButton-blue").addClass("bButton").css({"cursor": "default"});
    } else {
        $("#bButtonAdd").attr("disable", false).removeClass("bButton").addClass("bButton-blue").css({"cursor": "pointer"});
    }
}
function removeActivity(target) {
	$(target).closest("li").remove();
	$("#activityId").trigger("change");
}
function insertActivity(activity) {
    var li = '<li id="' + activity.id + '"><span class="activity-name">' + unescapeScript(activity.name) + '</span><span class="closer right" onclick="removeActivity(this);">X</span></li>';
    $(li).appendTo($("#selectedActivityList"));
}
function initSelectedActivityList() {
    $("#activityId").val("0");
    var defaultActivities = $("input[name=activities]").val();
    var activities = !!defaultActivities ? defaultActivities.split("|") : [];
	for (var i = 0; i < activities.length; ++i) {
        insertActivity(activities[i]);
    }
}
$(function(){
    <s:if test="%{#request.jsonDataConversion != null && #request.jsonDataConversion != '' && #request.jsonDataConversion != '{}'}">
        flashembed("divChartConversion", embedOptionsConversion, flashConfigurationConversion);
    </s:if>
});

$(document).ready(function () {
    $("#updateStatsForm").bind("submit", updateStatsForm);
    
    initSelectedActivityList();
	
	$("#activityId").bind("change", changeActivity);
    $("#bButtonAdd").bind("click", addActivity);
    
    
});


</script>
