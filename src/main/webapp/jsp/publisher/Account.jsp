<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.account"/> - <s:text name="bshare.points.publisher"/> - <s:text name="bshare.points.title"/></title>

<style>
    .container-overview { display: block; *display: inline-block; overflow: hidden; background-color: #f3f3f3; 
        padding: 10px 0; border: 1px solid #d8d8d8; color: #434343; }
    .num-activities-red { font-size: 20px; color: #ff0000; margin: 0 5px; font-weight: bold; }
    .num-deposit-blank { font-size: 28px; color: #000; }
    #overviewTable td { padding: 0 30px; width: 45%; }
    #overviewTable .bInputLabel { width: auto; }
    #overviewTable .bInputLabel.label { width: 75px; *width: 80px; }
    
    .container-search-box.sub { background-color: transparent; border: none; }
    #bButtonSearch { padding: 3px 15px; margin: 0 20px; vertical-align:top; }
	.container-search-box.sub .bLinkBlue { margin: 0 8px; line-height: 28px; font-size: 12px; }
	
    .module-table-history ul { list-style: none; display: block; overflow: hidden; }
    .module-table-history li { cursor: pointer; float: left; width: 80px; text-align: center; padding: 5px 0; border-width: 1px 1px 0; 
        border-style: solid; border-color: #d1d1d1; margin: 4px 4px 0 0; color: #434343; }
    .module-table-history li.current { cursor: default; background-color: #f3f3f3; color: #f60; }
    #recordTable td { border-bottom: 1px dashed #d0d0d0; }
    #recordTable tr.second td { background-color: #f2f6f9; }
    
    #pageDiv ul { float: right; font-size: 12px; overflow: hidden; border: 1px solid #dadada; }
    #pageDiv li { border: none; float: left; margin: 2px 10px; width: auto; }
    #pageDiv a { text-decoration: underline; color: #333; line-height: 20px; vertical-align: text-top; }
    #pageDiv a.current { text-decoration: none; font-size: 16px; }
    
    #recordMsgDiv { display: none; padding: 20px; border-bottom: 1px dashed #d0d0d0; margin-top: -10px; text-align: center; color:red;font-weight:bold;background:#ffd9d9; }
</style>

<div class="container-center">
	<%@ include file="/jsp/common/statsComm.jsp" %>
	
	<div class="container-overview">
	    <table id="overviewTable" class="bTablePlain">
	        <tr>
	            <td style="border-right:1px solid #aaa;">
	                <p class="heading4"><s:text name="bshare.points.account.deposit"/></p>
			        <div class="spacer10"></div>
			        <p class="left" style="line-height:30px;">
			            <span class="num-deposit-blank" style="vertical-align:bottom;"><s:text name="bshare.points.number.format"><s:param value="#request.account.availablePoints"></s:param></s:text></span>
			            <span style="vertical-align:sub;line-height:22px;">微积分</span>
			        </p>
			        <a href="javascript:void(0);" class="popup-topup bButton-blue left"
			            style="margin: 0 20px; padding: 5px 30px;"><s:text name="bshare.points.topup"/></a>
	            </td>
	            <td>
	                <p class="heading4"><s:text name="bshare.points.account.start" /></p>
			        <div class="spacer10"></div>
			        <div class="left" style="width: 50%;">
			            <span class="bInputLabel label"><s:text name="bshare.points.topup.total" />：</span>
			            <span class="bInputLabel"><s:text name="bshare.points.number.format"><s:param value="#request.account.totalCharge"></s:param></s:text></span>
			            <span class="bInputLabel"><s:text name="bshare.points.point" /></span>
			        </div>
	                <div style="overflow: hidden; zoom: 1;">
	                    <span class="bInputLabel label"><s:text name="bshare.points.points.froozen" />：</span>
	                    <span class="bInputLabel"><s:text name="bshare.points.number.format"><s:param value="#request.account.totalCharge-account.totalUsed-account.availablePoints"></s:param></s:text></span>
	                    <span class="bInputLabel"><s:text name="bshare.points.point" /></span>
	                </div>
	                <div class="spacer10"></div>
	                <div class="left" style="width: 50%;">
	                    <span class="bInputLabel label"><s:text name="bshare.points.used.total" />：</span>
	                    <span class="bInputLabel"><s:text name="bshare.points.number.format"><s:param value="#request.account.totalUsed"></s:param></s:text></span>
	                    <span class="bInputLabel"><s:text name="bshare.points.point" /></span>
	                </div>
                    <div style="overflow: hidden; zoom: 1;">
	                    <span class="bInputLabel label"><s:text name="bshare.points.points.avail" />：</span>
	                    <span class="bInputLabel"><s:text name="bshare.points.number.format"><s:param value="#request.account.availablePoints"></s:param></s:text></span>
	                    <span class="bInputLabel"><s:text name="bshare.points.point" /></span>
	                </div>
	            </td>
	        </tr>
	    </table>
	</div>

	<%@ include file="/jsp/common/TopupDialog.jsp" %>
	
	<div class="spacer20"></div>
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right module-white-grey module-backend">
        <div class="div-gradient-linear-light text-blue heading4" style="padding: 10px 20px;">
            <s:text name="bshare.points.deposit.history" />
        </div>
        <div class="spacer10"></div>
        <div class="container-search-box sub">
            <span class="bInputLabel" style="width:70px;"><s:text name="bshare.points.date.range" />：</span>
            <div class="left statsSelectorDivItem"><input type="date" id="datePickerStart" 
                value="${startDay}" data-value="${startDay}" max="${endDay}" /></div>
            <div class="left" style="padding: 0 8px; color: #8a8a8a;line-height:26px;vertical-align:bottom;"><span>-</span></div>
            <div class="left statsSelectorDivItem"><input type="date" id="datePickerEnd" 
                value="${endDay}" data-value="${endDay}" min="${startDay}" max="0" /></div>
            <button id="bButtonSearch" class="bButton" onclick="return getDepositHistory();"><s:text name="bshare.points.search" /></button>
            <a class="bLinkBlue" range="0" href="javascript:;" onclick="return goQuickLink(this);"><s:text name="bshare.points.record.quick.today"/></a>
            <a class="bLinkBlue" range="7" href="javascript:;" onclick="return goQuickLink(this);"><s:text name="bshare.points.record.quick.week"/></a>
            <a class="bLinkBlue" range="30" href="javascript:;" onclick="return goQuickLink(this);"><s:text name="bshare.points.record.quick.month.one"/></a>
            <a class="bLinkBlue" range="90" href="javascript:;" onclick="return goQuickLink(this);"><s:text name="bshare.points.record.quick.month.three"/></a>
            <a class="bLinkBlue" range="365" href="javascript:;" onclick="return goQuickLink(this);"><s:text name="bshare.points.record.quick.year"/></a>
        </div>
        <div class="spacer15"></div>
        <div class="module-table-history">
            <ul class="record-types">
                <li rType="all" class="current" title="<s:text name='bshare.points.deposit.history.all'/>">
                    <s:text name='bshare.points.deposit.history.all' />
                </li>
                <li rType="topup" title="<s:text name='bshare.points.deposit.history.topup'/>">
                    <s:text name='bshare.points.deposit.history.topup' />
                </li>
                <li rType="used" id="tab-used" title="<s:text name='bshare.points.deposit.history.used'/>">
                    <a><s:text name='bshare.points.deposit.history.used'/></a>
                </li>
            </ul>
            <table id="recordTable" class="bTable">
                <colgroup>
                    <col style="width: 20%;" />
                    <col style="width: 50%;" />
                    <col style="width: 30%;" />
                </colgroup>
                <tr>
                    <th><s:text name="bshare.points.record.date" /></th>
                    <th><s:text name="bshare.points.record.description" /></th>
                    <th style="text-align: right;"><s:text name="bshare.points.title" /></th>
                </tr>
            </table>
            <div class="clear spacer10"></div>
            <div id="pageDiv"></div>
            <div id="recordMsgDiv"><s:text name="bshare.points.record.message.no" /></div>
        </div>
        <div class="clear spacer20"></div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
function goQuickLink(target) {
    var range = parseInt($(target).attr("range"));
    var today = new Date();
    var startDate = new Date(today.getTime() - 1000 * 60 * 60 * 24 * range);
    
    var formatDate = function(date) {
    	return [date.getUTCFullYear(), date.getMonth() + 1, date.getDate()].join("-");
    };
    
    $("#datePickerStart").val(formatDate(startDate));
    $("#datePickerEnd").val(formatDate(today));
    getDepositHistory();
}

var RECORDS_PER_PAGE = 20, totalRecords;

function getDepositHistory() {
    var startDate = getDateStart();
    var endDate = getDateEnd();
    
    var rType = $(".record-types").find("li.current").attr("rType");        
    var rUrl = "${points_cxt_path}/publisher";
    if (rType == "topup") {
        rUrl += "/account/chargeRecords?";
        $("#recordType").text('<s:text name="bshare.points.topup"/>');
    } else if (rType == "used") {
        rUrl += "/account/usedRecords?";
        $("#recordType").text('<s:text name="bshare.points.used"/>');
    } else {
        rUrl += "/account/records?";
        $("#recordType").text("");
    }
    if (startDate && endDate) {
        rUrl += ["startDay=" + startDate, "endDay=" + endDate].join("&");
    }
    $.ajax({
        type: 'GET',
        url: rUrl,
        success: function(results) {
        	$("#pageDiv").html("");
            $("#recordTable").find("tr.record-item").remove();
            if (results.success) {
            	totalRecords = results.contents.accountRecords;
                if (totalRecords.length === 0) {
                    $("#recordMsgDiv").show();
                } else {
                    $("#recordMsgDiv").hide();
                    initPagenation();
                }
            } else {
            	displayStatusMessage(results.message, "error"); 
            }
        },
        error: function() {
        	displayStatusMessage('<s:text name="bshare.points.common.error"/>', "error");
        }
    });
}

function initPagenation() {
	var pages = $("<ul></ul>");
	var maxLength = totalRecords.length;
	for (var i = 0; i < Math.ceil(maxLength / RECORDS_PER_PAGE); ++i) {
		$('<li><a href="javascript:;">' + (i + 1) + '</a></li>').appendTo(pages);
	}
    pages.appendTo($("#pageDiv"));
    
	$("#pageDiv").find("a").click(function () {
	    $("#recordTable").find("tr.record-item").remove();
        var recordTable = $("#recordTable");
        var page = parseInt($(this).html());
        for (var i = RECORDS_PER_PAGE * (page - 1), last = (RECORDS_PER_PAGE * page < maxLength) ? 
        		RECORDS_PER_PAGE * page : maxLength; i < last; ++i) {
            var record = totalRecords[i];
            var item = $('<tr class="record-item' + (i % 2 === 1 ? ' second' : '') + '"><td>' + record.dateTime + '</td><td>' + record.description + '</td><td class="'
            + (record.type == "DEDUCT" ? 'text-green"' : 'text-orange"') 
            + 'style="font-size:14px;text-align:right;">'
            + (record.type == "DEDUCT" ? '-' : "+") + addCommas(record.points) + '</td></tr>');
            if (i === maxLength) {
                item.addClass("last");
            }
            item.appendTo(recordTable);
        }
        $("#pageDiv").find("a").removeClass("current");
        $(this).addClass("current");
	});
	$("#pageDiv").find("a").first().trigger("click");
}

$(function () {
    $(".popup-topup").click(function () {
        $("#dialogTopup").data("overlay").load();
    });
    $(".record-types").find("li").click(function() {
        $(".record-types").find("li").removeClass("current");
        $(this).addClass("current");
        getDepositHistory();
    });
    
    initDatepicker();
    getDepositHistory();
});
</script>
