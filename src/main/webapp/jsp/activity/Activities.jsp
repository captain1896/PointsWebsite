<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<title>所有活动 - <s:text name="bshare.points.title"/></title>

<link rel="stylesheet" type="text/css" href="${css_path}/pagination.css" />
<style>
    .container-activity { display: block; overflow: hidden; }
    .container-activity .bInputLabel { width: 60px; }
    .container-activity .keyword { margin-left: 0; }
    .module-white-grey { padding: 20px; }
    .wrapper-activity { margin-bottom: 15px; padding: 15px; width: 46%; background-color: #fff; border: 1px solid #e0e0e0; }
    .activity-image { width: 120px; height: 120px; border: 1px solid #dadada; }
    .activity-image img { display: block; margin: auto; }
    .card-activity { zoom: 1; overflow: hidden; padding-left: 15px; height: 122px; position: relative; }
    .card-activity a { text-decoration: none; }
    .activity-title { height: 42px; line-height: 21px; display: block; overflow: hidden; word-wrap: break-word; }
    .activity-button { padding: 4px 20px; position: absolute; bottom: 0; }
    .text-vert-align { vertical-align: text-bottom; font-size: 12px; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.title"/></a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/shop/activities">所有活动</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<div class="module-white-grey">
		<div class="container-activity">
		    <!-- -->
		    <s:iterator value="#request.activities" var="activity" status="status">
		    <div class="wrapper-activity <s:if test="%{#status.count % 2 == 0}">right</s:if><s:else>left</s:else>">
		        <a class="activity-image inlineBlock left" href="${points_cxt_path}/shop/activity/${activity.id}" target="_blank" title="${activity.name}"><img src="${activity.picUrl}" /></a>
		        <div class="card-activity">
		            <a href="${points_cxt_path}/shop/activity/${activity.id}" target="_blank" class="activity-title bLinkBlue" title="${activity.name}">${activity.name}</a>
		            <div class="clear"></div>
		            <p>
		               <span class="bInputLabel text-vert-align">奖励<s:text name="bshare.points.point"/></span>
		               <span class="text-vert-align">：</span>
		               <span class="text-blue keyword text-vert-align" style="font-size:16px;"><s:text name="bshare.points.number.format"><s:param value="#activity.totalPoints"></s:param></s:text></span>
		               <span class="text-vert-align"><s:text name="bshare.points.point"/></span>
		            </p>
		            <div class="clear"></div>
	                <p>
	                    <span class="bInputLabel text-vert-align">活动时间</span>
	                    <span class="text-vert-align">：</span>
	                    <span class="text-vert-align">
	                        <s:date name="#activity.startDate" format="yyyy-MM-dd"/> <s:text name="bshare.shop.activity.date.mid"/><s:date name="#activity.endDate" format="yyyy-MM-dd"/>
	                    </span>
	                </p>
		            <div class="clear"></div>
		            <a class="activity-button bButton" href="${points_cxt_path}/shop/activity/${activity.id}" target="_blank">查看</a>
		        </div>
		    </div>
		    </s:iterator> 
		</div>
		<div class="spacer10"></div>
		<div id="bindedPagination" class="pagination"></div>
	    <div class="clear"></div>
	</div>
	<div class="spacer20 clear"></div>
</div>

<script type="text/javascript" charset="utf-8" src="${js_path}/libs/jquery.pagination.js"></script>
<script type="text/javascript" charset="utf-8">
	function initPage(pageNo, pageSize, totalRecords) {
	    try {
	        var pn = parseInt(pageNo, 10),
	         ps = parseInt(pageSize, 10),
	         tr = parseInt(totalRecords, 10);
	        if (pn < 0) return;
	        
	        $("#bindedPagination").pagination(tr, {
	            current_page:--pn,
	            num_edge_entries: 2,
	            num_display_entries: 6,
	            next_text:'<s:text name="bshare.pagination.nextPage"/>',
	            prev_text:'<s:text name="bshare.pagination.prevPage"/>',
	            items_per_page:ps, 
	            callback: pageCallback
	        });
	    } catch(e) {}
	}
	function pageCallback(clickedNumber) {
		location.href = "${points_cxt_path}/shop/activities?pageNo=" + (clickedNumber+1);
	}
	
	$(function () {
		if ("${pagination.totalPage}" > 1) {
			initPage("${pagination.pageNo}","${pagination.pageSize}","${pagination.totalCount}");
		}
	});
</script>