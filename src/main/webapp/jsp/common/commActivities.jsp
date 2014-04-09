<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<style>
    .container-activities .wrapper-header { width: 144px; height: 40px; line-height: 40px; margin-top: -8px; margin-left: 15px; color: #fff; text-align: center;
        background: url(${points_image_path}/header-blue-1.png) no-repeat; }
    .container-activities .wrapper-header2 { margin-top: 10px; }
    .container-activities .text-more { text-decoration: none; margin-right: 5px; font-size: 12px; }
    .container-activities .list-activity { padding: 10px; font-size: 12px; }
    .container-activities .list-activity li { border-top: 1px solid #d3d3d3; margin-left: 10px; list-style: none; padding-top: 10px; }
    .container-activities .list-activity li.first { border-top: none; }
    .container-activities .list-activity li a { text-decoration: none; color: #454545; }
    .container-activities .activity-image { width: 90px; height: 90px; border: 1px solid #dadada; cursor: pointer; display: block; }
    .container-activities .activity-info { zoom: 1; overflow: hidden; padding: 5px 0 0 5px; _padding-top: 0; cursor: pointer; }
    .container-activities .card-activity { display: none; }
    .container-activities .activity-summary { cursor: pointer; }
    .container-activities .activity-title, .activity-summary-title { font-size: 14px; height: 18px; line-height: 18px; overflow: hidden; word-wrap: break-word; }
    .container-activities .activity-summary-title { height: 32px; line-height: 16px; }
</style>

<div class="wrapper-header left heading3">最新活动</div>
<div class="wrapper-header2 right">
    <a class="text-more text-blue" href="${points_cxt_path}/shop/activities" target="_blank">更多<span class="icon-more"></span></a>
</div>
<div class="clear"></div>
<ul class="list-activity">
    <s:iterator value="#request.activities" var="activity" status="status">
    <li <s:if test="#status.count == 1">class="first"</s:if>>
        <a class="card-activity" href="${points_cxt_path}/shop/activity/${activity.id}" target="_blank">
           <img class="activity-image left" src="${activity.picUrl}" />
           <div class="activity-info">
               <p class="activity-title bLinkBlue" title="${activity.name}">${activity.name}</p>
               <div class="spacer5"></div>
               <p class="bLinkDark">
                   <span style="font-size:12px;vertical-align:text-bottom;">奖励<s:text name="bshare.points.point"/>：</span>
                   <span class="text-blue" style="font-size:14px;font-weight:bold;vertical-align:text-bottom;"><s:text name="bshare.points.number.format"><s:param value="#activity.totalPoints"></s:param></s:text></span>
               </p>
               <div class="spacer5"></div>
               <p class="bLinkDark">开始：<s:date name="#activity.startDate" format="yyyy-MM-dd"/></p>
               <p class="bLinkDark">结束：<s:date name="#activity.endDate" format="yyyy-MM-dd"/></p>
           </div>
        </a>
        <a class="activity-summary" href="javascript:;">
            <p class="activity-summary-title bLinkBlue">${activity.name}</p>
            <p><s:date name="#activity.startDate" format="yyyy-MM-dd"/><s:text name="bshare.shop.activity.date.mid"/><s:date name="#activity.endDate" format="yyyy-MM-dd"/></p>
        </a>
        <div class="spacer5 clear"></div>
    </li>
    </s:iterator>
</ul>
<div class="clear"></div>

<script type="text/javascript" charset="utf-8">
function initActivityList() {
    $(".activity-summary").click(function() {
        $(".activity-summary").show();
        $(".card-activity").hide();
        $(this).hide();
        if (/msie|MSIE 6/.test(navigator.userAgent)) {
        	$(this).closest("li").find(".card-activity").show();
        } else {
        	$(this).closest("li").find(".card-activity").fadeIn(500);        	
        }
    }).first().trigger("click");
}

$(function() {
	initActivityList();
});
</script>
