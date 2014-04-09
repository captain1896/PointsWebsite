<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/jsp/common/init.jsp"%>

<script type="text/javascript" charset="utf-8" src="${js_path}/ajaxLogout.js"></script>

<style type="text/css">
    .container-nav { height: 40px; width: 100%;  font-size: 12px; position:relative !important;z-index:1000;}
    .wrapper-nav, .wrapper-msg { line-height: 36px; text-align: center; }
    .wrapper-nav { margin: 3px 1px 0; position: relative; cursor: pointer; }
    .wrapper-nav:hover { border: 1px solid #0581c7; margin: 2px 0 0; }
    .wrapper-msg { margin: 4px 0 0 10px; }
    .nav-message { color: #fff; }

    .nav-button { width: 85px; color: #fff; text-decoration: none; display: block; }
    .wrapper-msg .nav-button { width: 60px; }
    .nav-button-rich { width: 100px; background: url(${image_path}/arrow-down-white.gif) no-repeat 85px 14px; }
    .nav-button-rich:hover { text-decoration: none; }
    .nav-menu-popup {display:none;z-index:200000000 !important; width: 102px;  position:absolute !important;left:0px;top:18px;}

    .nav-popup-content { background:#00acf0; color:#fff; box-shadow: 5px 10px 5px #e9e9e9; -moz-box-shadow: 5px 10px 5px #e9e9e9; -webkit-box-shadow: 5px 10px 5px #e9e9e9;}
    .nav-popup-content a {width:100%; color: #fff; font-size: 12px; text-decoration: none; display:block; background-color: transparent height: 24px; line-height: 24px; padding:5px 0px;}
    .nav-popup-content a:hover { background-color: #006eb6;  text-decoration: underline;}
    .seperator { padding-top: 15px; }
    .seperator span { width: 1px; height: 14px; display: inline-block; *display: inline; zoom: 1; }
    
    .top-message { color: #333; line-height: 140%; *text-align: right; }
</style>

<div class="container-nav">
	<div class="container-center" style="position: relative;">
	    <div class="wrapper-nav right"><a class="nav-button" href="${points_cxt_path}/help"><s:text name="bshare.points.help"/></a></div>
	    <sec:authorize ifAnyGranted="ROLE_POINTS_PUBLISHER" ifNotGranted="ROLE_POINTS_ADMIN">
	    <div class="wrapper-nav right">
	        <a class="nav-button nav-button-rich" href="${points_cxt_path}/publisher/userDashboard"><s:text name="bshare.points.publisher"/></a>
	        <div class="nav-menu-popup">
	            <div class="spacer20"></div>
	            <div class="nav-popup-content">
	                <a title="<s:text name="bshare.points.overview"/>" href="${points_cxt_path}/publisher/userDashboard"><s:text name="bshare.points.overview"/></a>
	                <a title="<s:text name="bshare.points.account"/>" href="${points_cxt_path}/publisher/account"><s:text name="bshare.points.account"/></a>
	                <a title="<s:text name="bshare.points.activities"/>" href="${points_cxt_path}/publisher/activity/list"><s:text name="bshare.points.activities"/></a>
	                <a title="<s:text name="bshare.points.statistics"/>" href="${points_cxt_path}/publisher/activityStats"><s:text name="bshare.points.statistics"/></a>
	            </div>
	        </div>
	    </div>
	    </sec:authorize>
	    <sec:authorize ifAnyGranted="ROLE_POINTS_ADMIN">
	    <div class="wrapper-nav right">
	        <a class="nav-button nav-button-rich" href="${points_cxt_path}/admin/publisher"><s:text name="bshare.points.admin"/></a>
	        <div class="nav-menu-popup">
	            <div class="spacer20"></div>
	            <div class="nav-popup-content">
	                <a title="<s:text name="bshare.points.admin.publisher"/>" href="${points_cxt_path}/admin/publisher"><s:text name="bshare.points.admin.publisher"/></a>
	                <a title="<s:text name="bshare.points.admin.merchant"/>" href="${points_cxt_path}/admin/merchant"><s:text name="bshare.points.admin.merchant"/></a>
	                <a title="<s:text name="bshare.points.admin.product"/>" href="${points_cxt_path}/admin/product"><s:text name="bshare.points.admin.product"/></a>
	                <a title="<s:text name="bshare.points.admin.deposit"/>" href="${points_cxt_path}/admin/deposit"><s:text name="bshare.points.admin.deposit"/></a>
	                <a title="<s:text name="bshare.points.admin.deposit"/>" href="${points_cxt_path}/admin/orders"><s:text name="bshare.points.admin.order"/></a>
	                <a title="<s:text name="bshare.points.statistics"/>" href="${points_cxt_path}/admin/activeSites"><s:text name="bshare.points.statistics"/></a>
	            </div>
	        </div>
	    </div>
	    </sec:authorize>
	    <sec:authorize ifAnyGranted="ROLE_USER">
	    <div class="wrapper-nav right">
	        <a class="nav-button nav-button-rich" href="${one_cxt_path}/points/userProfile" target="_blank">我的<s:text name="bshare.points.point"/></a>
	        <div class="nav-menu-popup">
	            <div class="spacer20"></div>
	            <div class="nav-popup-content">
	                <a title="<s:text name="bshare.points.user.profile"/>" target="_blank" 
	                   href="${one_cxt_path}/points/userProfile"><s:text name="bshare.points.user.profile"/></a>
	                <a title="<s:text name="bshare.points.user.record.activities"/>" href="${points_cxt_path}/user/activityRecords"><s:text name="bshare.points.user.record.activities"/></a>
	                <a title="<s:text name="bshare.points.user.record.orderrecords"/>" href="${points_cxt_path}/user/orders"><s:text name="bshare.points.user.record.orderrecords"/></a>
	            </div>
	        </div>
	    </div>
	    </sec:authorize>
        <div class="wrapper-nav right"><a class="nav-button" href="${points_cxt_path}/shop/category/all">花微积分</a></div>
        <div class="wrapper-nav right"><a class="nav-button" href="${points_cxt_path}/shop/activities">赚微积分</a></div>
	    <div class="wrapper-nav right"><a class="nav-button" href="${points_cxt_path}"><s:text name="bshare.points.home"/></a></div>
	    <div class="wrapper-nav right"><a class="nav-button" href="${main_cxt_path}" target="_blank"><s:text name="bshare.home"/></a></div>
	    
	    <sec:authorize ifAnyGranted="ROLE_USER">
	    <div class="wrapper-msg left" style="margin-left:0;"><span class="nav-message"><strong id="displayName"></strong>，<s:text name="bshare.points.welcome" />！</span></div>
	    <div class="wrapper-msg left"><a id="bshare_logout" class="nav-button" href="${points_cxt_path}/logout"><s:text name="bshare.points.logout"/></a></div>
	    </sec:authorize>
	    <sec:authorize ifNotGranted="ROLE_USER">
	    <div class="wrapper-msg left"><span class="nav-message"><s:text name="bshare.points.welcome"/>，</span></div>
	    <div class="wrapper-msg left"><a class="nav-button" href="${points_cxt_path}/login"><s:text name="bshare.points.login"/></a></div>
	    <div class="seperator left"><span style="background-color: #0066a7;"></span><span style="background-color: #fff;"></span></div>
	    <div class="wrapper-msg left"><a class="nav-button" href="${points_cxt_path}/register"><s:text name="bshare.points.register"/></a></div>
	    </sec:authorize>
	</div>
	<div class="clear"></div>
</div>

<div class="container-logo container-content">
    <div class="clear spacer20"></div>
	<div class="container-center">
	    <div class="left">
	        <a title="<s:text name="bshare.points.title"/>" href="${points_cxt_path}">
	            <img alt="<s:text name="bshare.points.title"/>" src="${points_image_path}/bshare-points-logo.png"/>
	        </a>
	    </div>
	    <div class="top-message right">
	        <div class="spacer15"></div>
	        <sec:authorize ifAnyGranted="ROLE_USER">
	                <span style="font-size:12px;vertical-align:text-bottom;"><s:text name="bshare.points.welcome.points.avail" /></span>
	                <span class="text-blue" style="font-size:16px;vertical-align:text-bottom;" id="user_points"></span>
	            <sec:authorize ifAnyGranted="ROLE_POINTS_PUBLISHER" ifNotGranted="ROLE_POINTS_ADMIN">
	                <span style="font-size:12px;vertical-align:text-bottom;">&nbsp;&nbsp;<s:text name="bshare.points.welcome.points.using" /></span>
	                <span class="text-blue" style="font-size:16px;vertical-align:text-bottom;" id="user_using_points"></span>
	            </sec:authorize>
	        </sec:authorize>
	    </div>
	    <div class="clear"></div>
	</div>
	<div class="spacer20 clear"></div>
</div>

<!-- SCRIPTS-START -->
<script type="text/javascript" charset="utf-8">

$(".wrapper-nav").bind("mouseenter",function(){
	$(this).find(".nav-menu-popup").show();
}).bind("mouseleave",function(){
	$(this).find(".nav-menu-popup").hide();
});

$("#bshare_logout").live("click", function(e) {
    passport_ajax_logout("${one_cxt_path}");
    
    window.location.href='${cxt_path}/logout';
    return false;
});
<sec:authorize ifAnyGranted="ROLE_USER">
var rUrl = '${points_cxt_path}/shop/basic';
$.ajax({
    type: 'GET',
    url: rUrl,
    success: function(results) {
        if (results.success && results.contents && results.contents.pointsUser) {
        	var name = results.contents.pointsUser.userName;
        	$("#displayName").text(name.length > 20 ? name.substring(0, 17) + "..." : name).attr("title", name);
                if (results.contents.pointsUser && results.contents.pointsUser.points) {
                    $("#user_points").append(addCommas(results.contents.pointsUser.points));
                } else {
                	$("#user_points").append("0");
                }
            <sec:authorize ifAnyGranted="ROLE_POINTS_PUBLISHER" ifNotGranted="ROLE_POINTS_ADMIN">
	            if (results.contents.account && results.contents.account.availablePoints) {
	                $("#user_using_points").append(addCommas(results.contents.account.availablePoints));
	            } else {
	                $("#user_using_points").append("0");
	            }
            </sec:authorize>
        } else {
        	displayStatusMessage(results.message, "error"); 
        }
    },
    error: function() {
    	displayStatusMessage('<s:text name="bshare.points.common.error"/>', "error");
    }
});
</sec:authorize>
function formatInteger(value){
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(value)) {
		value = value.replace(rgx, '$1' + ',' + '$2');
	}
	return value;
}
function addCommas(nStr){
	nStr += '';
	var x = nStr.split('.');
	return formatInteger(x[0]) + (x.length > 1 ? '.' + x[1] : '');
}
</script>
