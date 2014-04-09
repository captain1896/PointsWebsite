<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.product"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<link rel="stylesheet" type="text/css" href="${css_path}/pagination.css" />

<div class="container-center">
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right">
	    <div class="module-white-grey module-backend">
	        <div class="spacer20 clear"></div>
	        <a class="bButton-blue right" href="${points_cxt_path}/admin/addProduct" 
	            style="padding: 5px 20px;"><s:text name="bshare.points.admin.product.add"/></a>
	        <!-- cutting line -->   
	        <a class="bButton-blue right" href="${points_cxt_path}/admin/addProduct2" style="padding:5px 20px;">
	        	<s:text name="LucasAddDemo" /> 
	        </a> 
	        <div class="spacer10 clear"></div>
	        <table class="bTable">
	            <colgroup>
	                <col style="width: 19%;" />
	                <col style="width: 12%;" />
	                <col style="width: 25%;" />
	                <col style="width: 25%;" />
	                <col style="width: 8%;" />
	            </colgroup>
	            <tr>
	                <th><s:text name="bshare.points.admin.product.name" /></th>
	                <th><s:text name="bshare.points.admin.product.category" /></th>
	                <th><s:text name="bshare.points.admin.product.brand" /></th>
	                <th><s:text name="bshare.points.admin.product.merchant" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.status" /></th>
	            </tr>
	            <s:if test="%{#request.pointsProducts.size() > 0}">
		            <s:iterator value="#request.pointsProducts" var="p" status="count">
		                <tr<s:if test="%{#count.even}"> class="second"</s:if>>
		                    <td title="${p.name}">${p.name}</td>
		                    <td title="${p.productCategory.name}">${p.productCategory.name}</td>
		                    <td title="${p.brand}">${p.brand}</td>
		                    <td title="${p.merchant.name}">${p.merchant.name}</td>
		                    <td style="text-align:right;" class="cell-status">
		                        <!--  
		                        <a id="edit" class="bLinkBlue keyword" style="margin-right:0;" href="${points_cxt_path}/admin/editProduct/${p.id}"><s:text name="bshare.points.common.edit"/></a>
		                        -->
		                        
		                        <!-- By Lcuas Cutting line -->
		                        <a id="edit" class="bLinkBlue keyword" style="margin-right:0;" href="${points_cxt_path}/admin2/editProduct/${p.id}">
		                        	<s:text name="e"/>
		                        </a>
		                        <!-- 
		                        <a id="delete" class="bLinkBlue keyword" href="${points_cxt_path}/admin/deleteProduct/${p.id}"><s:text name="bshare.points.common.delete"/></a>
		                         -->
		                        <a id="delete" class="bLinkBlue keyword" href="${points_cxt_path}/admin2/deleteProduct/${p.id}"><s:text name="delete"/></a>
		                    </td>
		                </tr>
		            </s:iterator>
	            </s:if>
	            <s:else>
                     <tr>
                        <td style="color:red;font-weight:bold;text-align:center;padding:20px 0;background:#ffd9d9 !important;"
                           colspan="5"><s:text name="bshare.points.stats.none" /></td>
                    </tr>
                </s:else>
           
	            <!-- ACTIVITIES TABLE END -->
	        </table>
	        <div class="clear spacer10"></div>
	        <div id="bindedPagination" class="right pagination"></div>
	        <div class="clear spacer20"></div>
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
function pageCallback(clickedNumber) {
    location.href="product?pageNo=" + (clickedNumber+1);
}

$(document).ready(function () {
    if ("${pagination.totalPage}" > 1) {
        initPage("${pagination.pageNo}","${pagination.pageSize}","${pagination.totalCount}");
    }
});
</script>