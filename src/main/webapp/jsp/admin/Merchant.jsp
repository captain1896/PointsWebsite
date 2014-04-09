<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.merchant"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<div class="container-center">
    <%@ include file="/jsp/common/leftMenu.jsp" %>

	<div class="container-right">
	    <div class="module-white-grey module-backend">
	        <div class="spacer20 clear"></div>
	        <a class="bButton-blue right" href="${points_cxt_path}/admin/addMerchant"
	            style="padding: 5px 20px;"><s:text name="bshare.points.admin.merchant.add"/></a>
	        <div class="spacer10 clear"></div>
	        <table class="bTable">
	            <colgroup>
	                <col style="width: 20%;" />
	                <col style="width: 25%;" />
	                <col style="width: 25%;" />
	                <col style="width: 20%;" />
	                <col style="width: 10%;" />
	            </colgroup>
	            <tr>
	                <th>Email</th>
	                <th><s:text name="bshare.points.admin.merchant.name" /></th>
	                <th><s:text name="bshare.points.admin.merchant.home.url" /></th>
	                <th style="text-align:right;"><s:text name="bshare.points.admin.merchant.join.time" /></th>
	                <th style="text-align:right;" class="activity-status"><s:text name="bshare.points.status" /></th>
	            </tr>
	            <s:if test="%{#request.merchants.size() > 0}">
		            <s:iterator value="#request.merchants" var="site" status="count">
		            <tr<s:if test="%{#count.even}"> class="second"</s:if>>
		                <td>
		                    <a class="bLinkBlue" title="${site.email}" href="mailto:${site.email}" target="_blank">${site.email}</a>
		                </td>
		                <td title="${site.name}">${site.name}</td>
		                <td>
		                    <a class="bLinkBlue" title="${site.homeURL}" href="${site.homeURL}" target="_blank">${site.homeURL}</a>
		                </td>
		                <td title="${site.joinTimeString}" style="text-align:right;">${site.joinTimeString}</td>
		                <td style="text-align:right;">
		                    <input type="hidden" id="id" name="id" value="${site.id}" />
		                    <a id="edit" class="bLinkBlue keyword" style="margin-right:0;" href="${points_cxt_path}/admin/editMerchant/${site.id}"><s:text name="bshare.points.common.edit"/></a>
		                    <!-- 
		                    <a id="delete" class="bLinkRed keyword" href="${points_cxt_path}/admin/deleteMerchant/${site.id}"><s:text name="bshare.points.common.delete"/></a>
		                     -->
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
	        <div class="spacer20 clear"></div>
	    </div>
	</div>
</div>
