<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
String pathSub = request.getServletPath();
if(pathSub != null && pathSub.trim() != "") {
    pageContext.setAttribute("curPathSub", pathSub.substring(1));
} else {
    pageContext.setAttribute("curPathSub", "Index.jsp");
}
%>

<link href="${css_path}/libs/calendar-date.css" rel="stylesheet" type="text/css" />

<style>
    .separator { background: #dadada; }
    .bInputLabel { width: 100px; height: 26px; line-height: 26px; font-size: 12px; }
    .container-search-box { *display: inline-block; *display: inline; zoom: 1; padding: 10px 20px; background-color: #f3f3f3;
	    -moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius: 5px;
	    -moz-box-shadow: box-shadow: 0 2px 2px #dadada;-webkit-box-shadow: box-shadow: 0 2px 2px #dadada; box-shadow: 0 2px 2px #dadada; 
    }
    .container-search-box input, .container-search-box select { margin-left: 0px; padding: 3px; border-width: 1px; border-style: solid; 
        border-color: #939393 #c8c8c8 #c8c8c8; }
    .container-search-box input { height: 18px; }
    .container-search-box select { height: 26px; width: 679px; _width: 676px; }
    .container-search-box .date { width: 100px; }
    .statsSelectorDivItem { position: relative; }
    .statsSelectorDivItem .caltrigger { position: absolute; right: 2px; top: 3px; }
    .activity-list { width: 315px; padding: 2px; margin-right: 10px; bordeR: 1px solid #dadada; background: #fff; font-size: 12px; border-radius: 5px; }
    .activity-list select { width: 100%; }
    #activityId { width: 540px; }
    
    .module-conversion { margin: 9px 0 0; }
    #bButtonSearch { margin-right: 16px; padding: 4px 30px; }
    #bButtonContrast { margin-right: 14px; padding: 4px 30px; }
    
</style>

<% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityStats.jsp")
		|| ((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityContrast.jsp")
		|| ((String)pageContext.getAttribute("curPathSub")).endsWith("UserStats.jsp")
        || ((String)pageContext.getAttribute("curPathSub")).endsWith("DailyStats.jsp")
        || ((String)pageContext.getAttribute("curPathSub")).endsWith("PlatformStats.jsp")
		) { %>
<!-- SEARCH BOX START -->
<div class="module-backend container-search-box">
<form id="updateStatsForm" name="updateStatsForm" method="POST">
    <div class="clear spacer10"></div>
    <% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityContrast.jsp")) { %>
    <p style="font-size: 12px;"><s:text name="bshare.points.stats.activity.date"/></p>
    <div class="clear spacer15"></div>
    <% } %>
    <div class="bInputLabel"><span><s:text name="bshare.points.date.range"/>：</span>
    <% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityStats.jsp")
	        || ((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityContrast.jsp")
	        ) { %>
	<span title="<s:text name='bshare.points.stats.activity.date.tip'/>" class="help-popup-img"></span>     
	<% } %>   
    </div>
    <div class="left statsSelectorDivItem" style="width: 108px;"><input type="date" id="datePickerStart" name="dateStart" value="${dateStart}" data-value="${dateStart}" max="${dateEnd}" /></div>
    <div class="left" style="padding: 0 10px 0 8px; text-align: center; color: #8a8a8a; line-height: 26px;"><span>-</span></div>
    <div class="left statsSelectorDivItem" style="width: 108px;"><input type="date" id="datePickerEnd" name="dateEnd" value="${dateEnd}" data-value="${dateEnd}" min="${dateStart}" max="0" /></div>
    <div class="left" style="padding:10px; font-size:12px;"><span id="reselect" class="hidden text-red"><s:text name="bshare.points.stats.activity.reselect"/></span></div>
    <div class="right"><button id="bButtonSearch" type="submit" class="bButton-blue"><s:text name="bshare.points.search"/></button></div>
    <input type="hidden" id="sortBy" name="sortBy" value="${sortBy }">
    <div class="clear spacer10"></div>
	<% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityStats.jsp")
	        || ((String)pageContext.getAttribute("curPathSub")).endsWith("UserStats.jsp")
	        ) { %>
	    <div class="bInputLabel"><span><s:text name="bshare.points.activity.selector"/>：</span></div>
	    <div class="left"><select id="activityId" name="activityId" <s:if test="#request.activities.size==0">disabled</s:if>>
	        <s:if test="#request.activities.size>0"><option value="0"><s:text name="bshare.points.activity.all"/></option></s:if>
	        <s:iterator value="#request.activities" var="activity" status="status">
	            <option value="${activity.id}">${activity.name}</option>
	        </s:iterator>
	    </select></div>
        <div class="clear spacer10"></div>
    <% } %>
    
    <% if (((String)pageContext.getAttribute("curPathSub")).endsWith("UserStats.jsp")) { %>
    <div class="bInputLabel"><span><s:text name="bshare.points.platform.selector"/>：</span></div>
    <div class="left"><select name="platform">
        <option value="0"><s:text name="bshare.points.platform.all"/></option>
        <s:iterator value="#request.platforms" var="platform" status="status">
        <option value="${platform.id}">${platform.name}</option>
        </s:iterator>
    </select></div>
    <div class="clear spacer10"></div>
    <% } %>
    <% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityContrast.jsp")) { %>
    <div id="wrapperContrast">
        <div class="clear spacer10"></div>
	    <div class="spacer1 separator"></div>
	    <div class="clear spacer10"></div>
	    <p style="font-size: 12px;"><s:if test="#request.activities.size>0"><s:text name="bshare.points.stats.activity.selectnote1"/></s:if><s:else><s:text name="bshare.points.stats.activity.selectnote2"/></s:else></p>
	    <div class="clear spacer15"></div>
	    <div class="activity-list left">
            <select name="activityId1" id ="activityId1" <s:if test="#request.activities.size==0">disabled</s:if>>
	        <s:iterator value="#request.activities" var="activity" status="status" >
                <option value="${activity.id}">${activity.name} (<s:date name="#activity.startDate" format="yyyy-MM-dd"/> - <s:date name="#activity.endDate" format="yyyy-MM-dd"/>)</option>
	        </s:iterator>
	        </select>
	    </div>
	    <div class="activity-list left">
	        <select name="activityId1" id="activityId2" <s:if test="#request.activities.size==0">disabled</s:if>>
	        <s:iterator value="#request.activities" var="activity" status="status" >
	            <option value="${activity.id}">${activity.name} (<s:date name="#activity.startDate" format="yyyy-MM-dd"/> - <s:date name="#activity.endDate" format="yyyy-MM-dd"/>)</option>
	        </s:iterator>
	        </select>
	    </div>
	    <input type="hidden" id="activityIds" name="activityIds" value=""/>
	    <div style="text-align: right;padding:2px;">
	    <button id="bButtonContrast" type="button" <s:if test="#request.activities.size==0">disabled="disabled" class="bButton" style="cursor:default" onclick="javascript:void(0);"</s:if><s:else> class="bButton-blue"</s:else>><s:text name="bshare.points.stats.activity.compare"/></button></div>
	    <div class="clear spacer10"></div>
    </div>
    <% } %>
</form>
</div>
<!-- SEARCH BOX END -->
<% } %>

<% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityStats.jsp")
        || ((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityContrast.jsp")
        || ((String)pageContext.getAttribute("curPathSub")).endsWith("UserStats.jsp")
        || ((String)pageContext.getAttribute("curPathSub")).endsWith("UserDashboard.jsp")
        || ((String)pageContext.getAttribute("curPathSub")).endsWith("DailyStats.jsp")
        ) { %>
<!-- ACTIVITY EFFECTION START -->
<div class="module-white-grey module-backend container-stats-effection">
<% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityStats.jsp")
        || ((String)pageContext.getAttribute("curPathSub")).endsWith("UserStats.jsp")
        || ((String)pageContext.getAttribute("curPathSub")).endsWith("UserDashboard.jsp")
        ) { %>
    <div class="module-label div-rounded-bottom-5 text-blue left heading4" style="margin-top: -1px;"><s:text name="bshare.points.effection"/></div>
    <div class="module-conversion right">
        <span style="font-size:14px;color:#333;vertical-align:text-bottom;line-height:26px;"><s:text name="bshare.points.stats.burl.clicks"/> / <s:text name="bshare.points.stats.shares"/><s:text name="bshare.points.stats.conversion.rates"/>：</span>
        <!-- <span class="txt-orange" style="font-size: 20px;">${request.conversion}</span> -->
        <span class="text-blue" style="font-size:24px;font-weight:bold;vertical-align:text-bottom;">${stats.shareToClickback}</span>
    </div>
    <% } %>
    <div class="clear spacer20"></div>
    <div style="padding: 0 20px;">
        <div class="heading4"><s:text name="bshare.points.stats.shares"/></div>
        <div class="clear spacer10"></div>
        <div style="height:200px;">
            <s:if test="%{#request.jsonDataShares != null && #request.jsonDataShares != '' && #request.jsonDataShares != '{}'}">
                <div id="divChartShares" style="height:100%;width:100%">
                    <div style="text-align:center;padding:10px 0;">
                    <img title="<s:text name="bshare.points.loading"/>..." 
                        alt="<s:text name="bshare.points.loading"/>..." 
                        src="${image_path}/ajaxLoad.gif"/>&nbsp;<s:text name="bshare.points.loading"/>...
                    </div>
                </div>
            </s:if>
            <s:else>
                <div style="padding-top: 20px; text-align: center;"><div class="warningMessage div-rounded-5"><p><s:text name="bshare.points.stats.none"/></p></div></div>
            </s:else>
        </div>
        <div class="clear spacer20"></div>
        
        <div class="heading4"><s:text name="bshare.points.stats.burl.clicks"/></div>
        <div class="clear spacer10"></div>
        <div style="height:200px;">
            <s:if test="%{#request.jsonDataBurlClicks != null && #request.jsonDataBurlClicks != '' && #request.jsonDataBurlClicks != '{}'}">
                <div id="divChartBurlClicks" style="height:100%;width:100%">
                    <div style="text-align:center;padding:10px 0;">
                    <img title="<s:text name="bshare.points.loading"/>..." 
                        alt="<s:text name="bshare.points.loading"/>..." 
                        src="${image_path}/ajaxLoad.gif"/>&nbsp;<s:text name="bshare.points.loading"/>...
                    </div>
                </div>
            </s:if>
            <s:else>
                <div style="padding-top: 20px; text-align: center;"><div class="warningMessage div-rounded-5"><p><s:text name="bshare.points.stats.none"/></p></div></div>
            </s:else>
        </div>
        <div class="clear spacer20"></div>
    </div>
</div>
<!-- ACTIVITY EFFECTION END -->
<% } %>

<!-- POPUPS START -->
<div class="bOverlay2" id="getCodePopup">
    <div class="header div-rounded-top-5"><s:text name="bshare.chart.popup.saveas.csv.note"/></div>
    <div class="close">X</div>
    
    <div class="body" style="color:#444;padding:20px;">
        <div><textarea class="code-textarea-popup" id="bShare_Code" name="bShare_Code" style="width:450px;height:200px;" readonly></textarea></div>
        <div class="clear spacer5"></div>
        <div class="left"><button id="saveAsCsvFileLink" class="bButton" onClick="getCsvFile();return false;" type="button"><s:text name="bshare.charts.popup.saveas.csv.file"/></button></div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
</div>
<!-- POPUPS END-->

<script type="text/javascript" charset="utf-8" src="${js_path}/libs/json2-min.js"></script>
<script type="text/javascript" charset="utf-8" src="${js_path}/ofc2-menu.js"></script>
<script type="text/javascript" charset="utf-8">
//for ofc2-menu.js
var OFC2MENU_SAVEIMAGE_NOTE = '<s:text name="bshare.charts.popup.saveas.image.note"/>';
var OFC2MENU_SAVEAS_IMAGE = '<s:text name="bshare.charts.popup.saveas.image"/>';
var OFC2MENU_INVALID_CHARTID = '<s:text name="bshare.charts.popup.invalid.chart.id"/>';
var OFC2MENU_VIEWS = '<s:text name="bshare.ofc.label.views"/>';
var OFC2MENU_CLICKS = '<s:text name="bshare.ofc.label.clicks"/>';
var OFC2MENU_SHARES = '<s:text name="bshare.ofc.label.shares"/>';
var OFC2MENU_DATE = '<s:text name="bshare.points.date"/>';
var OFC2MENU_LOADING = '<s:text name="bshare.points.stats.loading"/>...';
var OFC2MENU_RATES = '<s:text name="bshare.ofc.label.conversions"/>';
var OFC2MENU_BURLCLICKS = '<s:text name="bshare.ofc.label.clickbacks"/>';
var OFC2MENU_ACTIVITY = '<s:text name="bshare.ofc.label.activity"/>';

var pathError = '<s:text name="bshare.stats.common.pathError"/>';
var paths="${pathJson}";

// Datepicker
function getDateStart() {
    var dateStart = $("#datePickerStart").val();
    if (dateStart === null || dateStart === undefined) {
        dateStart = "";
    }
    return dateStart;
}

function getDateEnd() {
    var dateEnd = $("#datePickerEnd").val();
    if (dateEnd === null || dateEnd === undefined) {
        dateEnd = "";
    }
    return dateEnd;
}

function initDatepicker() {
    // init date pickers
    var fDay = 0;
    if('<s:text name="bshare.points.lang.code"/>' == "zh") {
        $.tools.dateinput.localize("zh", {
            <s:text name="bshare.points.calendar.inputs"/>
        });
        fDay = 1;
    } else if('<s:text name="bshare.points.lang.code"/>' == "zh_TW") {
        $.tools.dateinput.localize("zh_TW", {
            <s:text name="bshare.points.calendar.inputs"/>
        });
        fDay = 1;
    }
    $(":date").dateinput({ trigger: true, format: 'yyyy-mm-dd', lang: '<s:text name="bshare.points.lang.code"/>', firstDay: fDay });
    $(":date").bind("onShow onHide", function()  {
        $(this).parent().toggleClass("active"); 
    });
    if ($(":date").length != 0) {
    	var dates = $(":date"), startDate = dates.eq(0), endDate = dates.eq(dates.length - 1);
    	startDate.data("dateinput").change(function() {
    		endDate.data("dateinput").setMin(this.getValue(), true);
            //checkValue();
            resetSelect();
                    
        });
    	endDate.data("dateinput").change(function() {
    		startDate.data("dateinput").setMax(this.getValue(), true);
            //checkValue();
            resetSelect();
        });
    }
}
function resetSelect(){
	 <% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityStats.jsp")){ %>
     $('#activityId').empty().attr("disabled","disabled");
<% }else if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityContrast.jsp")) {  %>
     $('#activityId1').empty().attr("disabled","disabled");
     $('#activityId2').empty().attr("disabled","disabled");
<%}%>
 $('#reselect').removeClass("hidden");
}


// Flash statistics
var appendTS = "";
if ($.browser.msie) {// && $.browser.version=="6.0") {
    var timestamp = Number(new Date()); // current time as number.. this is needed for IE6 support
    appendTS = "?ts="+timestamp;
}
var ofcSource = '${static_cxt_path}/ofc2/open-flash-chart.swf'+appendTS;
var ofcBubble = '${static_cxt_path}/buzzleChart/buzzle-chart.swf'+appendTS;
var expInsSource = '${static_cxt_path}/ofc2/expressInstall.swf';
var saveImageMsg = '<s:text name="bshare.charts.popup.saveas.image"/>';
var loadingMsg = '<s:text name="bshare.points.loading"/>...';

var embedOptionsShares = { id:'pointsChartShares', src:ofcSource,version:[9,0], wmode:'opaque', expressInstall:expInsSource };
var embedOptionsBurlClicks = { id:'pointsBurlChartClicks', src:ofcSource,version:[9,0], wmode:'opaque', expressInstall:expInsSource };
var flashConfigurationShares = { "id":"pointsChartShares", "get-data":"getOfcDataShares", "save_image_message":saveImageMsg, "loading":loadingMsg };
var flashConfigurationBurlClicks = { "id":"pointsBurlChartClicks", "get-data":"getOfcDataBurlClicks", "save_image_message":saveImageMsg, "loading":loadingMsg };

function ofc_ready() {
    // called when chart data is loaded
}
function getOfcDataShares() {
    return unescapeJson("${jsonDataShares}").replace(/'/g, "\"");
}
function getOfcDataBurlClicks() {
    return unescapeJson("${jsonDataBurlClicks}").replace(/'/g, "\"");
}

function addCommas(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}
function checkactivity(){
	 if($('#activityId1').val()==null){
		 alert('<s:text name="bshare.points.stats.activity.comparenote1"/>');
	    return false;
	 }
	if($('#activityId1').val()==$('#activityId2').val()){
		alert('<s:text name="bshare.points.stats.activity.comparenote2"/>');
        return false;
     }
	return true;
}
$(function() {
	/*TODO: need to handle 2 selectors*/
	$("select[name='activityId']").val('${activityId>0?activityId:0}');
	if ($("input[type=date]").length > 0) {
	    initDatepicker();
	}
	<% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityStats.jsp")){%>
	    
	<%}%>
    <% if (((String)pageContext.getAttribute("curPathSub")).endsWith("ActivityContrast.jsp")){%>
	<s:if test="%{#request.activitieStr[0]>0}">
		$('#activityId1').val('${activitieStr[0]}');
	</s:if>
	<s:if test="#request.activitieStr[1]>0">
	$('#activityId2').val('${activitieStr[1]}');
	</s:if>
    $('#activityId1').change(checkactivity);
    $('#activityId2').change(checkactivity);
    $('#bButtonContrast').click(function(){
    	if(checkactivity()){
            $('#activityIds').val($('#activityId1').val()+'|'+$('#activityId2').val());
    		$('#updateStatsForm').submit();
    	}
    });
    <%}%>

    if ($(".container-stats-effection").length > 0) {
        // embed flash elements
        <s:if test="%{#request.jsonDataShares != null && #request.jsonDataShares != '' && #request.jsonDataShares != '{}'}">
        flashembed("divChartShares", embedOptionsShares, flashConfigurationShares);
        </s:if>
        <s:if test="%{#request.jsonDataBurlClicks != null && #request.jsonDataBurlClicks != '' && #request.jsonDataBurlClicks != '{}'}">
        flashembed("divChartBurlClicks", embedOptionsBurlClicks, flashConfigurationBurlClicks);
        </s:if>
    }
    
});
</script>
