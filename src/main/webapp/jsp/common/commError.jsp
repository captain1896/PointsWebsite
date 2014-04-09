<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<style>
    #errorDiv { position: fixed; _position: absolute; }
    .icon-sad { height: 22px; width: 22px; display: inline-block; *display: inline; zoom: 1; margin: 0 5px; background: url(${points_image_path}/icons/sad.gif) no-repeat; }
    
    #subActivityList { margin-top: 5px; height: 230px; width: auto; border: none; overflow: hidden; }
    #subActivityList .list-activity li { border: 1px solid #dadada; float: left; margin-right: 4px; padding: 5px 8px; width: 265px;  *width: 260px;
       background: #fff; margin-bottom: 10px; }
    #subActivityList .wrapper-header, #errorDiv .wrapper-header2 { display: none; }
    #subActivityList .list-activity { padding: 0; }
</style>

<div id="errorDiv" class="bOverlay">
    <a class="close" href="javascript:;">X</a>
    <div class="body">
	    <p>
	        <span class="icon-sad"></span>
	        <span id="pointserror"></span>
	    </p>
	    <div id="activityDiv">
	        <div class="spacer20 clear"></div>
	        <p><span class="left">推荐活动：</span><a class="bLinkBlue keyword right" href="${points_cxt_path}/shop/activities" target="_blank">更多</a></p>
	        <div class="clear"></div>
	        <div id="subActivityList" class="container-activities">
	            <%@ include file="/jsp/common/commActivities.jsp"%>
	        </div>
	    </div>
	    <div class="clear"></div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
function initErrorDiv() {
    $("#errorDiv").overlay({
        top: '30%',
        mask: {
            color: '#e9e9e9',
            loadSpeed: 200,
            opacity: 0.5
        },
        closeOnClick: false,
        onLoad: function(e) {
            
        },
        onBeforeClose: function(e) {
            hideStatusMessage();
        }
    });
    
    $("#subActivityList .activity-summary").hide();
    $("#subActivityList .card-activity").show();
    
    $(".close").click(function () {
        $(this).closest(".bOverlay").hide();
    });
}

$(function () {
    initErrorDiv();
});
</script>
