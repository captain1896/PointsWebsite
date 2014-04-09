<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.activities"/> - <s:text name="bshare.points.publisher"/> - <s:text name="bshare.points.title"/></title>

<style>
    .bTable .activity-status { margin: 0 5px; }
 
    #errorDiv, #uuidDiv { width: 440px; }
    #errorDiv p, #uuidDiv p { margin: 20px 0; text-align: center; }
</style>

<%@ include file="/jsp/common/commError.jsp"%>
<%@ include file="/jsp/common/TopupDialog.jsp" %>
<div class="container-center">
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right">
	    <div class="module-white-grey module-backend">
	        <div class="clear spacer20"></div>
	        <a id="addActivity" class="bButton-blue right" style="padding: 5px 20px;"><s:text name="bshare.points.activity.action.add.full"/></a>
	        <div class="clear spacer10"></div>
	        <table class="bTable">
	            <colgroup>
                    <col style="width: 20%;" />
                    <col style="width: 15%;" />
                    <col style="width: 15%;" />
                    <col style="width: 12%;" />
                    <col style="width: 12%;" />
                    <col style="width: 8%;" />
                    <col style="width: 18%;" />
                </colgroup>
	            <tr>
	                <th class="activity-selector hidden">
	                    <input id="allSelectors" type="checkbox" onclick="return updateSelectors();" />
	                </th>
	                <th><s:text name="bshare.points.activity.name" /></th>
	                <th style="text-align: right;"><s:text name="bshare.points.activity.points.total" /></th>
	                <th style="text-align: right;"><s:text name="bshare.points.activity.points.used" /></th>
	                <th style="text-align: right;"><s:text name="bshare.points.activity.date.start" /></th>
	                <th style="text-align: right;"><s:text name="bshare.points.activity.date.end" /></th>
	                <th style="text-align: right;"><s:text name="bshare.points.status" /></th>
	                <th style="text-align: right;"><s:text name="bshare.points.operate" /></th>
	            </tr>
	            <s:if test="%{#request.activities.size() > 0}">
		            <s:iterator value="#request.activities" var="activity" status="count">
		                <tr<s:if test="%{#count.even}"> class="second"</s:if>>
		                    <td class="hidden"><input id="${activity.id}" class="activity-selector" type="hidden" /></td>
		                    <td title="${activity.name}(${activity.uuidStr})"><a href="${points_cxt_path}/shop/activity/${activity.id}" target="_blank" class="activity-status text-blue">${activity.name}</a></td>
		                    <td style="text-align: right;"><s:text name="bshare.points.number.format"><s:param value="#activity.totalPoints"></s:param></s:text></td>
		                    <td style="text-align: right;"><s:text name="bshare.points.number.format"><s:param value="#activity.usedPoints"></s:param></s:text></td>
		                    <td style="text-align: right;">${activity.startDateStr}</td>
		                    <td style="text-align: right;">${activity.endDateStr}</td>
		                    <td style="text-align: right;"><span id="activityStatus" class="activity-status">${activity.activityType.desc}</span></td>
		                    <td style="text-align: right;">
		                        <s:if test="%{#activity.delete}">
		                            <a id="activityDelete" class="activity-status text-red" href="${points_cxt_path}/publisher/activity/delete/${activity.id}"><s:text name="bshare.points.activity.action.delete"/></a>
		                        </s:if>
		                        <s:if test="%{#activity.finish}">
		                            <a id="activityDelete" class="activity-status text-red" href="${points_cxt_path}/publisher/activity/finish/${activity.id}"><s:text name="bshare.points.activity.status.closed"/></a>
		                        </s:if>
		                        <s:if test="%{#activity.edit}"> 
		                            <a id="activityEdit" style="margin-right:0;" class="activity-status text-blue" href="${points_cxt_path}/publisher/activity/edit/${activity.id}"><s:text name="bshare.points.activity.action.edit"/></a>
		                        </s:if>
		                    </td>
		                </tr>
		            </s:iterator>
		        </s:if>
		        <s:else>
                     <tr>
                        <td style="color:red;font-weight:bold;text-align:center;padding:20px 0;background:#ffd9d9 !important;"
                           colspan="7"><s:text name="bshare.points.stats.none" /></td>
                    </tr>
                </s:else>
	            <!-- ACTIVITIES TABLE END -->
	        </table>
	        <div class="clear spacer20"></div>
	    </div>
	</div>
</div>

<div id="uuidDiv" class="bOverlay">
    <a class="close" href="javascript:;">X</a>
    <div class="body">
        <div id="beforeUuid">
            <p>您还没有添加网站，请先到站长后台&nbsp;<a id="siteManager" class="bLinkBlue" href="javascript:;">添加网站</a>&nbsp;</p>
        </div>
        <div id="afterUuid" style="display: none;">
            <p>若您已经添加网站：</p>
            <p>
                <a class="bButton-blue" href="${points_cxt_path}/publisher/activity/add" style="padding: 5px 20px; width: 100px;">继续添加活动</a>
                <a class="bButton bButton-close" style="padding: 5px 20px; width: 100px; margin-left: 20px;">稍后再说</a>
            </p>
        </div>
        <div class="clear"></div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
function updateSelectors() {
	var checked = $("#allSelectors").is(":checked");
	$("input.activity-selector").each(function () {
		if ($(this).attr("disabled")) {
			return;
		}
		$(this).attr("checked", checked);
	});
}

function initErrDiv() {
	$("#activityDiv").hide();
	var errMsg = '您账户目前可投放微积分不足&nbsp;100&nbsp;哦，请先<div class="clear spacer20"></div><a style="margin: 0 20px; padding: 5px 30px;"' +
	    ' class="popup-topup bButton-blue" href="javascript:void(0);">充值</a>';
	$("#pointserror").html(errMsg);
    $(".popup-topup").click(function () {
        $(this).closest(".bOverlay").hide();
        $("#dialogTopup").data("overlay").load();
    });
}

$(function () {
	initErrDiv();
	updateSelectors();
	
	$("#uuidDiv").overlay({
	    top: '30%',
	    mask: {
	        color: '#e9e9e9',
	        loadSpeed: 200,
	        opacity: 0.5
	    },
	    closeOnClick: false,
	    onLoad: function(e) {
	    	hideStatusMessage();
	    	$("#afterUuid").hide();
	        $("#beforeUuid").show();
	    },
	    onBeforeClose: function(e) {
	        hideStatusMessage();
	    }
	});
	
	$("#siteManager").click(function () {
		window.open('${main_cxt_path}/websiteManage');
		$("#afterUuid").show();
		$("#beforeUuid").hide();
	});
    
    $(".bButton-close").click(function () {
    	$("#uuidDiv").data("overlay").close();
    });
	
    $("#addActivity").click(function () {
    	if (parseInt("${request.uuidSize}") === 0) {
    		$("#uuidDiv").data("overlay").load();
    		return;
    	}
        if (parseInt($("#user_using_points").html().replace(",", "")) < 100) {
        	$("#errorDiv").data("overlay").load();
        	return;
        }
        window.location.href = "${points_cxt_path}/publisher/activity/add";
    });
});
</script>
