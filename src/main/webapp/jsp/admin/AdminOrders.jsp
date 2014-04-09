<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.merchant"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<link rel="stylesheet" type="text/css" href="${css_path}/pagination.css" />

<div class="container-center">
    <%@ include file="/jsp/common/leftMenu.jsp" %>
    
	<div class="container-right">
	    <div class="module-white-grey module-backend">
	        <div class="spacer20 clear"></div>
	        <form id="orderform" name="orderform" method="Post">
	        <%--<a class="bButton-blue right" style="padding: 5px 20px; margin-left: 10px; font-size: 12px;" href="javascript:updateNext()"><span title="<s:text name="bshare.points.user.order.updatenext.tip"/>"><s:text name="bshare.points.user.order.updatenext"/></span></a>--%>
	        <a class="bButton-blue right" style="padding: 5px 20px; margin-left: 10px; font-size: 12px;" href="javascript:updateOder()"><s:text name="bshare.points.user.order.update"/></a>
	        <a class="bButton-blue right" style="padding: 5px 20px; margin-left: 10px; font-size: 12px;" href="javascript:doSearch()"><s:text name="bshare.points.search"/></a>
	        <div class="right"><s:select style="height: 26px; margin-top: 1px; width: 160px;" list="#request.orderMap" id="orderStatus"  name="orderStatus" value="#request.orderStatus"></s:select></div>
	        <div class="spacer10 clear"></div>
	        <input id="isNext" type="hidden" name="isNext" value="N"/>
	        <table class="bTable">
	            <colgroup>
	                <col style="width: 3%;" />
	                <col style="width: 15%;" />
	                <col style="width: 18%;" />
	                <col style="width: 15%;" />
	                <col style="width: 9%;" />
	                <col style="width: 11%;" />
	                <col style="width: 20%;" />
	                <col style="width: 9%;" />
	            </colgroup>
	            <tr>
	                <th style="padding: 8px 2px;"><input type="checkbox" id="selectAll" name="selectAll"/></th>
	                <th><s:text name="bshare.points.user.order.no" /></th>
	                <th><s:text name="bshare.shop.order.confirm.contact" /></th>
	                <th><s:text name="bshare.points.user.order.productname" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.user.order.productnum" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.user.order.costpoint" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.user.order.ordertime" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.user.order.orderstatus" /></th>
	            </tr>
	            <s:if test="%{#request.orders.size() > 0}">
	            <s:iterator value="#request.orders" var="order" status="count">
	                <tr<s:if test="%{#count.even}"> class="second"</s:if>>
	                    <td title="${order.id}" style="padding: 8px 2px;"><input type="checkbox" id="orderId" name="orderId" value="${order.id}"/></td>
	                    <td title="${order.orderNo}">${order.orderNo}</td>
	                    <s:if test="#order.userAccountId>0">
	                        <td title="${order.pointsUserAccount.accountName}">${order.pointsUserAccount.accountName}</td>
	                    </s:if>
	                    <s:else>
	                        <s:if test="#order.product.normal">
	                            <td title="<s:text name="bshare.points.user.order.contactname"/>: ${order.contactName}<s:text name="bshare.points.user.order.contactno"/>: ${order.contactNo}<s:text name="bshare.points.user.order.contactaddress"/>: ${order.contactAddress}<s:text name="bshare.points.user.order.zipcode"/>: ${order.zipCode}"><s:text name="bshare.points.user.order.contactname"/>: ${order.contactName}<br><s:text name="bshare.points.user.order.contactno"/>: ${order.contactNo}<br><s:text name="bshare.points.user.order.contactaddress"/>: ${order.contactAddress}<br><s:text name="bshare.points.user.order.zipcode"/>: ${order.zipCode}</td>
	                        </s:if>
	                        <s:else>
	                            <td title="${order.otherInfo}">${order.otherInfo}</td>
	                        </s:else>
	                    </s:else>
	                    <td title="${order.product.name}<s:if test="#order.product.lottery">-${order.otherInfo}</s:if>">${order.product.name}<s:if test="#order.product.lottery">-${order.otherInfo}</s:if></td>
	                    <td style="text-align:right;"><s:text name="bshare.points.number.format">
                            <s:param value="%{#order.prodNum}" /></s:text></td>
	                    <td style="text-align:right;"><s:text name="bshare.points.number.format">
                            <s:param value="%{#order.orderPoints}" /></s:text></td>
	                    <td style="text-align:right;"><s:date name="#order.orderTime" format="yyyy-MM-dd HH:mm:ss" /></td>
	                    <td style="text-align:right;">
	                        <input type="hidden" name="oldStatus${order.id}" value="${order.orderStatus.code}" />
	                        ${request.orderMap[order.orderStatus.code]}
	                    </td>
	                </tr>
	            </s:iterator>
	            </s:if>
	            <s:else>
	                 <tr>
		                <td style="color:red;font-weight:bold;text-align:center;padding:20px 0;background:#ffd9d9 !important;"
		                   colspan="8"><s:text name="bshare.points.stats.none" /></td>
		            </tr>
	            </s:else>
	        </table>
	        </form>
	        <div class="spacer10"></div>
		    <div id="bindedPagination" class="right pagination"></div>
		    <div class="spacer20 clear"></div>
	    </div>
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
function updateNext(){
  if(!checkOrders()){
	  return;
  }
  if(confirm("<s:text name="bshare.points.user.order.updatenextconfirm"/>")){
	  $("#isNext").val("Y");
	  $('#orderform').attr('action',"${points_cxt_path}/admin/updateOrder");
	  $('#orderform').submit(); 
  }	
}
function checkOrders(){
	 var orders =$('input[name="orderId"]').map(function(){
	      return this.checked?$(this).val():"";
	    }).get().join("");
	 if(orders.length==0){
		 alert("<s:text name="bshare.points.user.order.noselect"/>");
		 return false;
	 }
	 if($("#orderStatus").val()<="0"){
		 alert("<s:text name="bshare.points.user.order.noorderstatus"/>");
		 return false;
	 }
	 return true;
}
function updateOder(){
	if(checkOrders()){
		$("#isNext").val("Y");
		$('#orderform').attr('action',"${points_cxt_path}/admin/updateOrder");
		setTimeout(function(){$('#orderform').submit();},0);
	}
}
function doSearch(){
	$('#orderform').attr('action',"${points_cxt_path}/admin/orders");
	setTimeout(function(){$('#orderform').submit();},0);
}
function pageCallback(clickedNumber) {
	setTimeout(function(){location.href="orders?pageNo=" + (clickedNumber+1)+"&orderStatus="+$("#orderStatus").val();},0);
}
$(function() {
	if ("${pagination.totalPage}" > 1) {
		initPage("${pagination.pageNo}","${pagination.pageSize}","${pagination.totalCount}");
	}
	$("#selectAll").click(function() {
		   $('input[name="orderId"]').each(function() {
			   var check = !!$("#selectAll").attr("checked");
		       $(this).attr("checked", check);
		  });
	 });
});
</script>
