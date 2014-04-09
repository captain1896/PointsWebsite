<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.publisher"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<div class="container-center">
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right">
	    <div class="module-white-grey module-backend">
	        <div class="clear spacer20"></div>
	        <a class="bButton-blue right" href="${points_cxt_path}/admin/addPublisher" 
	            style="padding: 5px 20px;"><s:text name="bshare.points.admin.publisher.add"/></a>
	        <div class="spacer10 clear"></div>
	        <table class="bTable">
	            <colgroup>
                	<col style="width: 100%" />
            	</colgroup>
	            <tr>
	            	<!-- 
	                <th class="site-selector">
	                    <input id="allSelectors" type="checkbox" onclick="return updateSelectors();" />
	                </th>
	                 -->
	                <th><s:text name="bshare.points.admin.site.email" /></th>
	                <!-- 
	                <th style="text-align:center;" class="activity-status"><s:text name="bshare.points.status" /></th>
	                 -->
	            </tr>
	            <s:if test="%{#request.publishers.size() > 0}">
		            <s:iterator value="#request.publishers" var="publisher" status="count">
		            <tr<s:if test="%{#count.even}"> class="second"</s:if>>
		                <td><a class="bLinkBlue" title="${publisher.email}" href="mailto:${publisher.email}" target="_blank">${publisher.email}</a></td>
		                <td class="publisher-status" style="text-align:center;">
		                    <input type="hidden" id="email" name="email" value="${publisher.email}" />
		                    <!--
		                    <a id="sitesEdit" class="bLinkBlue keyword" 
		                        href="${points_cxt_path}/admin/editPublisher/${site.id}"><s:text name="bshare.points.activity.action.edit"/></a>
		                    <a id="sitesDelete" class="bLinkRed keyword" 
		                        href="${points_cxt_path}/admin/deletePublisher/${site.id}"><s:text name="bshare.points.activity.action.delete"/></a>
		                    -->
		                </td>
		            </tr>
		            </s:iterator>
	            </s:if>
                <s:else>
                     <tr>
                        <td style="color:red;font-weight:bold;text-align:center;padding:20px 0;background:#ffd9d9 !important;"
                           colspan="1"><s:text name="bshare.points.stats.none" /></td>
                    </tr>
                </s:else>
	            <!-- ACTIVITIES TABLE END -->
	        </table>
	        <div class="clear spacer20"></div>
	    </div>
	</div>
</div>

<script type="text/javascript" charset="utf-8">
function updateSelectors() {
    var checked = $("#allSelectors").is(":checked");
    $("input.site-selector").each(function () {
        if ($(this).attr("disabled")) {
            return;
        }
        $(this).attr("checked", checked);
    });
}
</script>
