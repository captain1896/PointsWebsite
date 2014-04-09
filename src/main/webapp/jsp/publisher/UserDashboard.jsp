<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.overview"/> - <s:text name="bshare.points.publisher"/> - <s:text name="bshare.points.title"/></title>

<style>
    .container-overview { display: block; *display: inline-block; *display: inline; zoom: 1; overflow: hidden; 
        padding: 10px 0; background-color: #f3f3f3; border: 1px solid #d8d8d8; color: #434343; }
    #overviewTable td { padding: 0 30px; width: 45%; }
    .num-activities-red { font-size: 20px; color: #ff0000; margin: 0 5px; font-weight: bold; cursor: default; text-decoration: none; }
    .num-activities-red.active { cursor: pointer; text-decoration: underline; }
    .num-deposit-blank { font-size: 28px; color: #000; font-family: Arial,宋体,sans-serif; }
</style>

<%@ include file="/jsp/common/TopupDialog.jsp" %>
<div class="container-center">
	<!-- OVERVIEW START -->
	<div class="container-overview">
	    <table id="overviewTable">
	        <tr>
	            <td style="border-right:1px solid #aaa;">
	                <p class="heading4"><s:property value="%{#session.DISPLAY_NAME}"/>&nbsp;<s:text name="bshare.points.hi"/></p>
			        <div class="spacer15"></div>
			        <p><s:text name="bshare.points.activities.overview"><s:param value="%{#request.activityCount}"/></s:text></p>
	            </td>
	            <td>
	                <p class="heading4"><s:text name="bshare.points.account.deposit"/></p>
	                <div class="spacer10"></div>
		            <p class="left" style="line-height:30px;">
		               <span class="num-deposit-blank" style="vertical-align:bottom;"><s:text name="bshare.points.number.format"><s:param value="account.availablePoints"></s:param></s:text></span>
		               <span style="vertical-align:sub;line-height:22px;">微积分</span>
		            </p>
			        <a href="javascript:void(0);" class="popup-topup bButton-blue left" style="margin: 0 20px; padding: 5px 30px;"><s:text name="bshare.points.topup"/></a>
			        <a class="bButton" style="padding: 5px 15px;" href="${points_cxt_path}/publisher/account"><s:text name="bshare.points.topup.history"/></a>
	            </td>
	        </tr>
	    </table>
	</div>
	<!-- OVERVIEW END -->
	<div class="spacer20"></div>
	
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right">
	    <div class="module-white-grey module-backend">
	        <div class="div-gradient-linear-light text-blue heading4" style="padding: 10px 20px;"><s:text name="bshare.points.activities.active"/><a href="${points_cxt_path}/publisher/activity/list" class="bLinkOrange right" style="font-size:12px">&gt;&gt;&nbsp;<s:text name="bshare.points.more"></s:text></a></div>
	        <table class="bTable-border">
	            <colgroup>
                    <col style="width: 36%;" />
                    <col style="width: 16%;" />
                    <col style="width: 16%;" />
                    <col style="width: 16%;" />
                    <col style="width: 16%;" />
                </colgroup>
	            <tr>
	                <th><s:text name="bshare.points.activity.name"/></th>
	                <th style="text-align:right;"><s:text name="bshare.points.activity.points.total"/></th>
	                <th style="text-align:right;"><s:text name="bshare.points.activity.points.used"/></th>
	                <th style="text-align:right;"><s:text name="bshare.points.activity.date.start"/></th>
	                <th style="text-align:right;"><s:text name="bshare.points.activity.date.end"/></th>
	            </tr>
	            <s:iterator value="#request.activitys" var="activity" status="status"><tr>
	                <td title="${activity.name}(${activity.uuidStr})">${activity.name}</td>
	                <td style="text-align:right;"><s:text name="bshare.points.number.format"><s:param value="#activity.totalPoints"></s:param></s:text></td>
	                <td style="text-align:right;"><s:text name="bshare.points.number.format"><s:param value="#activity.usedPoints"></s:param></s:text></td>
	                <td style="text-align:right;">${activity.startDateStr}</td>
	                <td style="text-align:right;">${activity.endDateStr}</td>
	            </tr></s:iterator>
	            
	        </table>
	        <div class="clear spacer20"></div>
	    </div>
	    
	    <%@ include file="/jsp/common/statsComm.jsp" %>
	    
	    <!-- BEST SHARE PLATFORMS/ ACTIVITIES START -->        
	    <div class="module-white-grey module-backend left" style="margin: 0; width: 360px; *width: 355px; height: 300px;">
	        <div class="module-label div-rounded-bottom-5 text-blue left heading4" style="margin-top: -1px;"><s:text name="bshare.points.share.best.platform"/></div>
	        <div class="clear"></div>
	        <div style="font-size: 12px;">
	        <s:if test="%{#request.platformShareStatsList != null && #request.platformShareStatsList.size() > 0}">  
	            <div style="height: 220px;">
	            <s:iterator value="#request.platformShareStatsList" var="platform" status="count">
	                <div class="clear spacer15"></div>
	                <div class="left" style="padding-right: 10px; line-height: 25px; border-right: 1px solid #ddd; width: 60px;"><s:text name="buzzinate.platform.name.%{#platform.platformName}"/></div>
	                <div class="left">
	                    <div class="bulletOrange left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#platform.shareCount*#request.platformShareMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 220px; height: 7px; background: #f90;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#platform.shareCount}"/></s:text></div>
	                    <div class="clear spacer5"></div>
	                    <div class="bulletBlue left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#platform.clickbackCount*#request.platformShareMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 220px; height: 7px; background: #50a9e5;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#platform.clickbackCount}"/></s:text></div>
	                </div>
	            </s:iterator>    
	            </div>
	            <div class="clear spacer10"></div>
		        <div style="overflow:hidden;">
	                <div class="right" style="font-size: 12px;"><div class="left" style="background: #50a9e5; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.burl.clicks"/></div>
		            <div class="right" style="font-size: 12px; margin-right: 20px;"><div class="left" style="background: #f90; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.shares"/></div>
		        </div>     
	        </s:if>
	        <s:else>
	            <div style="padding-top: 20px; text-align: center;"><div class="warningMessage div-rounded-5"><p><s:text name="bshare.points.stats.none"/></p></div></div>
	        </s:else>
	        </div>
	        <div class="clear"></div>
	    </div>    
	    <div class="module-white-grey module-backend right" style="margin: 0; width: 360px; *width: 355px; height: 300px;">
	        <div class="module-label div-rounded-bottom-5 text-blue left heading4" style="margin-top: -1px;"><s:text name="bshare.points.share.best.activity"/></div>
	        <div class="clear"></div>
	        <div style="font-size: 12px;">
	        <s:if test="%{#request.platformShareStatsList != null && #request.platformShareStatsList.size() > 0}">  
	            <div style="height: 220px;">
	            <s:iterator value="#request.activityShareStatsList" var="activity" status="count">
	                <div class="clear spacer15"></div>
	                <div class="left" style="padding-right: 10px; line-height: 25px; border-right: 1px solid #ddd; width: 60px;"><span title="${activity.activityName}">${activity.activityShortName}</span></div>
                    <div class="left">
	                    <div class="bulletOrange left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#activity.shareCount*#request.activityShareMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 200px; height: 7px; background: #f90;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#activity.shareCount}"/></s:text></div>
	                    <div class="clear"></div>
	                    <div class="bulletBlue left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#activity.clickbackCount*#request.activityShareMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 200px; height: 7px; background: #50a9e5;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#activity.clickbackCount}"/></s:text></div>
	                </div>
	            </s:iterator>
	            </div>
                <div class="clear spacer10"></div>
	            <div style="overflow:hidden;">
	                <div class="right" style="font-size: 12px;"><div class="left" style="background: #50a9e5; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.burl.clicks"/></div>
	                <div class="right" style="font-size: 12px; margin-right: 20px;"><div class="left" style="background: #f90; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.shares"/></div>
	            </div>         
	         </s:if>
	         <s:else>
	            <div style="padding-top: 20px; text-align: center;"><div class="warningMessage div-rounded-5"><p><s:text name="bshare.points.stats.none"/></p></div></div>
	        </s:else>
	        </div>
	        <div class="clear"></div>
	    </div>
	    <!-- BEST SHARE PLATFORMS/ ACTIVITIES END -->
	
	    <!-- BEST CLICK PLATFORMS/ ACTIVITIES START -->
	    <div class="clear spacer20"></div>        
	    <div class="module-white-grey module-backend left" style="margin: 0; width: 360px; *width: 355px; height: 300px;">
	        <div class="module-label div-rounded-bottom-5 text-blue left heading4" style="margin-top: -1px;"><s:text name="bshare.points.click.best.platform"/></div>
	        <div class="clear"></div>
	        <div style="font-size: 12px;">
	        <s:if test="%{#request.platformShareStatsList != null && #request.platformShareStatsList.size() > 0}">  
	            <div style="height: 220px;">
	            <s:iterator value="#request.platformClickbackStatsList" var="platform" status="count">
	                <div class="clear spacer15"></div>
	                <div class="left" style="padding-right: 10px; line-height: 25px; border-right: 1px solid #ddd; width: 60px;"><s:text name="buzzinate.platform.name.%{#platform.platformName}"/></div>
	                <div class="left">
	                    <div class="bulletOrange left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#platform.shareCount*#request.platformClickbackMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 200px; height: 7px; background: #f90;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#platform.shareCount}"/></s:text></div>
	                    <div class="clear"></div>
	                    <div class="bulletBlue left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#platform.clickbackCount*#request.platformClickbackMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 200px; height: 7px; background: #50a9e5;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#platform.clickbackCount}"/></s:text></div>
	                </div>
	            </s:iterator>
	            </div>
                <div class="clear spacer10"></div>
	            <div style="overflow:hidden;">
	                <div class="right" style="font-size: 12px;"><div class="left" style="background: #50a9e5; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.burl.clicks"/></div>
	                <div class="right" style="font-size: 12px; margin-right: 20px;"><div class="left" style="background: #f90; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.shares"/></div>
	            </div>         
	        </s:if>
	        <s:else>
	            <div style="padding-top: 20px; text-align: center;"><div class="warningMessage div-rounded-5"><p><s:text name="bshare.points.stats.none"/></p></div></div>
	        </s:else>
	        </div>
	        <div class="clear"></div>
	    </div>    
	    <div class="module-white-grey module-backend right" style="margin: 0; width: 360px; *width: 355px; height: 300px;">
	        <div class="module-label div-rounded-bottom-5 text-blue left heading4" style="margin-top: -1px;"><s:text name="bshare.points.click.best.activity"/></div>
	        <div class="clear"></div>
	        <div style="font-size: 12px;">
	        <s:if test="%{#request.platformShareStatsList != null && #request.platformShareStatsList.size() > 0}">  
	            <div style="height: 220px;">
	            <s:iterator value="#request.activityClickbackStatsList" var="activity" status="count">
	                <div class="clear spacer15"></div>
	                <div class="left" style="padding-right: 10px; line-height: 25px; border-right: 1px solid #ddd; width: 60px;"><span title="${activity.activityName}">${activity.activityShortName}</span></div>
	                <div class="left">
	                    <div class="bulletOrange left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#activity.shareCount*#request.activityClickbackMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 200px; height: 7px; background: #f90;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#activity.shareCount}"/></s:text></div>
	                    <div class="clear"></div>
	                    <div class="bulletBlue left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#activity.clickbackCount*#request.activityClickbackMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 200px; height: 7px; background: #50a9e5;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#activity.clickbackCount}"/></s:text></div>
	                </div>
	            </s:iterator>
	            </div>
                <div class="clear spacer10"></div>
	            <div style="overflow:hidden;">
	                <div class="right" style="font-size: 12px;"><div class="left" style="background: #50a9e5; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.burl.clicks"/></div>
	                <div class="right" style="font-size: 12px; margin-right: 20px;"><div class="left" style="background: #f90; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.shares"/></div>
	            </div>         
	        </s:if>
	        <s:else>
	            <div style="padding-top: 20px; text-align: center;"><div class="warningMessage div-rounded-5"><p><s:text name="bshare.points.stats.none"/></p></div></div>
	        </s:else>
	        </div>
	        <div class="clear"></div>
	    </div>
	    <!-- BEST SHARE PLATFORMS/ ACTIVITIES END -->
	
	    <!-- BEST CONVERSION PLATFORMS/ ACTIVITIES START -->
	    <div class="clear spacer20"></div>        
	    <div class="module-white-grey module-backend left" style="margin: 0; width: 360px; *width: 355px; height: 300px;">
	        <div class="module-label div-rounded-bottom-5 text-blue left heading4" style="margin-top: -1px;"><s:text name="bshare.points.conversion.best.platform"/></div>
	        <div class="clear"></div>
	        <div style="font-size: 12px;">
	        <s:if test="%{#request.platformShareStatsList != null && #request.platformShareStatsList.size() > 0}">  
	            <div style="height: 220px;">
	            <s:iterator value="#request.platformConversionStatsList" var="platform" status="count">
	                <div class="clear spacer15"></div>
	                <div class="left" style="padding-right: 10px; line-height: 25px; border-right: 1px solid #ddd; width: 60px;"><s:text name="buzzinate.platform.name.%{#platform.platformName}"/></div>              
	                <div class="left">
	                    <div class="bulletOrange left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#platform.shareToClickbackDouble*100*#request.platformConversionMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 200px; height: 7px; background: #f90;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#platform.shareToClickback}"/></s:text></div>
	                </div>
	            </s:iterator>
	            </div>
                <div class="clear spacer10"></div>
	            <div style="overflow:hidden;">
	                <div class="right" style="font-size: 12px; margin-right: 20px;"><div class="left" style="background: #f90; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.conversion.rates"/></div>
	            </div>         
	        </s:if>
	        <s:else>
	            <div style="padding-top: 20px; text-align: center;"><div class="warningMessage div-rounded-5"><p><s:text name="bshare.points.stats.none"/></p></div></div>
	        </s:else>
	        </div>
	        <div class="clear"></div>
	    </div>    
	    <div class="module-white-grey module-backend right" style="margin: 0; width: 360px; *width: 355px; height: 300px;">
	        <div class="module-label div-rounded-bottom-5 text-blue left heading4" style="margin-top: -1px;"><s:text name="bshare.points.conversion.best.activity"/></div>
	        <div class="clear"></div>
	        <div style="font-size: 12px;">
	        <s:if test="%{#request.platformShareStatsList != null && #request.platformShareStatsList.size() > 0}">  
	            <div style="height: 220px;">
	            <s:iterator value="#request.activityConversionStatsList" var="activity" status="count">
	                <div class="clear spacer15"></div>
	                <div class="left" style="padding-right: 10px; line-height: 25px; border-right: 1px solid #ddd; width: 60px;"><span title="${activity.activityName}">${activity.activityShortName}</span></div>
	                <div class="left">
	                    <div class="bulletOrange left" style="height: 7px; width: <s:property value="getText('{0,number,#px}',{#activity.shareToClickbackDouble*100*#request.activityConversionMultiplier})"/>;overflow:hidden;">
	                        <div style="width: 200px; height: 7px; background: #f90;"></div>
	                    </div><div class="left" style="margin-left: 3px; vertical-align: text-top; font-size: 10px;"><s:text name="bshare.points.number.format"><s:param value="%{#activity.shareToClickback}"/></s:text></div>
	                    <div class="clear spacer5"></div>
	                </div>
	            </s:iterator>
	            </div>
                <div class="clear spacer10"></div>
	            <div style="overflow:hidden;">
	                <div class="right" style="font-size: 12px; margin-right: 20px;"><div class="left" style="background: #f90; height: 9px; width: 9px; font-size: 0; margin-top: 3px;"></div>&nbsp;<s:text name="bshare.points.stats.conversion.rates"/></div>
	            </div>         
	        </s:if>
	        <s:else>
	            <div style="padding-top: 20px; text-align: center;"><div class="warningMessage div-rounded-5"><p><s:text name="bshare.points.stats.none"/></p></div></div>
	        </s:else>
	        </div>
	        <div class="clear"></div>
	    </div>
	    <!-- BEST SHARE PLATFORMS/ ACTIVITIES END -->
	</div>
</div>

<script type="text/javascript" charset="utf-8">
$(function () {
    var numActivities = ${activityCount};
    if (numActivities > 0) {
    	$("#numActivities").attr("href", "${points_cxt_path}/publisher/activity/list").addClass("active");
    } else {
    	$("#numActivities").attr("href", "javascript:;").removeClass("active");
    }
    if (numActivities <= 5) {
    	$(".bLinkOrange").hide();
    }
    $(".popup-topup").click(function () {
    	$("#dialogTopup").data("overlay").load();
    });
});
</script>
