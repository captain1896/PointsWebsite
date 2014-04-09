<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.stats.active.sites"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<link type="text/css" rel="stylesheet" href="${css_path}/libs/jquery.treeTable.css" media="all" />
<link type="text/css" rel="stylesheet" href="${css_path}/pagination.css" media="all" />

<div class="container-center">
    <%@ include file="/jsp/common/leftMenu.jsp" %>
    
	<div class="container-right">
		<div class="module-white-grey module-backend">
		    <div class="module-label div-rounded-bottom-5 text-blue left heading4" style="margin-top: -1px;">
		        <s:text name="bshare.points.admin.stats.active.sites" />
		    </div>
		    <div class="right" style="margin-top: 10px; width: 480px; position: relative;">
		        <s:form id="activeSiteFilter" name="activeSiteFilter" action="activeSites"
		        method="POST" theme="simple">
		            <div class="bSearchBox-wrapper left" style="width:400px;">
		                <span class="bSearchBox-placeholder">
		                    <input name="filterText" type="text" id="searchBox" style="font-size:12px;" class="bSearchBox" value="${filterText }"/>
		                </span>
		            </div>
		            <a class="bSearchBox-reset" style="right: 78px; top: 7px;"></a>
		            <button type="submit" id="submitButton" class="bButton-blue right" style="font-size:13px; padding: 3px 15px;"
		                onclick="checkInput()">
		                <s:text name="bshare.points.search" />
		            </button>
		        </s:form>
		    </div>
		    <div class="clear spacer20"></div>
		    <table class="bTable">
		        <colgroup>
	                <col style="width: 15%;" />
	                <col style="width: 20%;" />
	                <col style="width: 35%;" />
	                <col style="width: 15%;" />
	                <col style="width: 15%;" />
	            </colgroup>
		        <tr>
		            <th><s:text name="bshare.points.website.name" /></th>
		            <th><s:text name="bshare.points.website.url" /></th>
		            <th>UUID</th>
		            <th style="text-align:right;">
		                <div class="sorter-site" key="share" style="cursor:pointer;" title="<s:text name="bshare.points.admin.sites.sort.shares "/>">
		                    <s:text name="bshare.points.stats.shares" />
		                    <span class="sortDomainSymble"></span>
		                </div>
		            </th>
		            <th style="text-align:right;">
		                <div class="sorter-site" key="clickback" style="cursor:pointer;" 
		                   title="<s:text name="bshare.points.admin.sites.sort.clickbacks "/>">
		                    <s:text name="bshare.points.stats.burl.clicks" />
		                    <span class="sortDomainSymble"></span>
		                </div>
		            </th>
		        </tr>
		        <s:if test="%{#request.uuidWebsiteList.size() > 0}">
	            <s:iterator value="%{#request.uuidWebsiteList}" var="uuidWebsite" status="count">
	                <tr<s:if test="%{#count.even}"> class="second"</s:if>>
				        <td title="<s:property value="#uuidWebsite.name" />"><s:property value="#uuidWebsite.name" /></td>
				        <td>
				            <a target="_blank" title="${uuidWebsite.url}" class="bLinkBlue" href="http://${uuidWebsite.url}">
				                <span><s:property value="#uuidWebsite.url" /></span><img style="margin:0 0 3px 3px;" src="${image_path}/icon_new_window.gif" />
				            </a>
				        </td>
				        <td><s:property value="#uuidWebsite.websiteUuid" /></td>
				        <td style="text-align:right;">
				            <s:text name="bshare.points.number.format">
				                <s:param value="%{#uuidWebsite.shareCount}" /></s:text>
				        </td>
				        <td style="text-align:right;">
				            <s:text name="bshare.points.number.format">
				                <s:param value="%{#uuidWebsite.clickbackCount}" /></s:text>
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
		    </table>
		    <div class="clear spacer20"></div>
		    <div id="pager" class="pagination right" style="height:21px"></div>
		    <div class="clear spacer20"></div>
		</div>
	</div>
</div>

<script type="text/javascript" charset="utf-8" src="${js_path}/libs/jquery.treeTable.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${js_path}/libs/jquery.pagination.js"></script>
<script type="text/javascript" charset="utf-8">
var SEARCH_BOX_DEFAULT_TEXT = '<s:text name="bshare.points.search"/>';
var curDomainSort = "${domainSort}";
function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function buildTable(){
	var key = capitalizeFirstLetter("${domainSort}");
	var curSorter = $(".sorter-site[key=" + key + "]");
	curSorter.css({"cursor":"default","color":"#000"}).attr("title","");
	curSorter.find(".sortDomainSymble").html('<span class="arrow-down" style="display:inline-block;margin-left:3px;*display:inline;zoom:1;"></span>');

    $("#domainDataTable").treeTable();
}

function initPage(_pageNo, pageSize, totalRecords) {
    try{
        var pn = parseInt(_pageNo,10);
        var ps = parseInt(pageSize,10);
        var tr = parseInt(totalRecords,10);
        if (pn < 0)
            return;
        $("#pager").pagination(tr, {
            current_page:pn,
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
    location.href="activeSites?page=" + clickedNumber + "&domainSort=" + curDomainSort;
}

function checkInput() {
    if ($("#searchBox").val() == SEARCH_BOX_DEFAULT_TEXT) {
        $("#searchBox").val('');
    }
}

$(document).ready(function () {
    buildTable();
    initPage("${request.page}", "${request.pageSize}", "${request.totalSites}");
    $(".sorter-site").click(function(e) {
        if ($(this).find(".sortDomainSymble .arrow-down").length > 0) {
            return;
        }
        location.href = "admin/activeSites?domainSort=" + $(this).attr("key");
        e.stopPropagation();
    });
});
</script>
