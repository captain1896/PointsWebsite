<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.user.orders"/> - <s:text name="bshare.points.user"/> - <s:text name="bshare.points.title"/></title>

<link rel="stylesheet" type="text/css" href="${css_path}/pagination.css" />
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
            <s:text name="bshare.points.user.orders" />
        </div>
        <div class="clear spacer20"></div>
        
        <table class="bTable">
            <tr>
                <th width="20%"><s:text name="bshare.points.user.order.productname" /></th>
                <th width="35%"><s:text name="bshare.points.user.order.comment" /></th>
                <th width="10%" style="text-align:right;"><s:text name="bshare.points.user.order.productnum" /></th>
                <th width="12%" style="text-align:right;"><s:text name="bshare.points.user.order.costpoint" /></th>
                <th width="13%" style="text-align:right;"><s:text name="bshare.points.user.order.ordertime" /></th>
                <th width="10%" style="text-align:right;"><s:text name="bshare.points.user.order.orderstatus" /></th>
            </tr>
            <s:if test="#request.orders.size > 0">
                <s:iterator value="#request.orders" var="order" status="status">
                    <tr<s:if test="%{#status.count % 2 == 0}"> class="second"</s:if>>
                        <td>${order.product.name}</td>
                        <td><s:if test="%{#order.product.lottery}">电子抵扣券:</s:if><s:if test="%{#order.product.lottery || #order.product.points}">${order.otherInfo}</s:if><s:else><s:text name="bshare.points.user.order.nocomment"/></s:else></td>
                        <td style="text-align:right;">${order.prodNum}</td>
                        <td style="text-align:right;">${order.orderPoints}</td>
                        <td style="text-align:right;">
                            <s:date name="#order.orderTime" format="yyyy-MM-dd" />
                        </td>
                        <td style="text-align:right;"><s:text name="%{'bshare.shop.order.orderstatus'+#order.orderStatus.code}"/></td>
                    </tr>
                </s:iterator>
            </s:if>
	        <s:else>
	            <td style="color:red;font-weight:bold;text-align:center;padding:20px 0;background:#ffd9d9 !important;"
                       colspan="6">您目前没有兑换记录。</td>
	        </s:else>
        </table>
            <div class="spacer10"></div>
            <div id="bindedPagination" class="right pagination"></div>
        
        <div class="clear spacer30"></div>
        <div id="activityList" class="container-activities">
           <%@ include file="/jsp/common/commActivities.jsp"%>
           <div class="clear"></div>
        </div>
        <div class="clear spacer20"></div>
    </div>
</div>

<script type="text/javascript" charset="utf-8" src="${js_path}/libs/jquery.pagination.js"></script>
<script type="text/javascript" charset="utf-8">
function initPage(pageNo, pageSize, totalRecords) {
    try{
    	
        var pn = parseInt(pageNo,10);
        var ps = parseInt(pageSize,10);
        var tr = parseInt(totalRecords,10);
        if (pn < 0)
            return;
        $("#bindedPagination").pagination(tr, {
            current_page:--pn,
            num_edge_entries: 2,
            num_display_entries: 6,
            next_text:'<s:text name="bshare.pagination.nextPage"/>',
            prev_text:'<s:text name="bshare.pagination.prevPage"/>',
            items_per_page:ps, 
            callback: pageCallback
        });
    }catch(e){}
}
function pageCallback(clickedNumber) {
	setTimeout(function(){location.href="orders?pageNo=" + (clickedNumber+1);},0);
}
$(function() {
    $("#activityList .activity-summary").hide();
    $("#activityList .card-activity").show();
    <s:if test="#request.orders.size > 0">
    	if ("${pagination.totalPage}" > 1) {
			initPage("${pagination.pageNo}","${pagination.pageSize}","${pagination.totalCount}");
		}
    </s:if>
});
</script>
