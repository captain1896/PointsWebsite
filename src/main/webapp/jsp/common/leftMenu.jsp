<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/jsp/common/init.jsp"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
String path = request.getServletPath();
if(path != null && path.trim() != "") {
    pageContext.setAttribute("curPath", path.substring(1));
} else {
    pageContext.setAttribute("curPath", "Index.jsp");
}
%>

<style type="text/css">
    .container-leftMenu { margin-top: 2px; width:150px; margin-right: 15px; }
    .bLeftMenuTitle { display: block; font-weight: bold; text-decoration: none; width: 125px; margin: -1px 0 0; padding: 10px; cursor:pointer; color: #444; font-size: 14px; 
        border: 1px solid #d9d9d9; border-radius: 3px; background: #e5e5e5; background: -moz-linear-gradient(top, #e5e5e5, #f5f5f5); background: -webkit-gradient(linear, 0% 20%, 0% 90%, from(#e5e5e5), to(#f5f5f5)); filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#ffe5e5e5',EndColorStr='#fff5f5f5'); }
    .bLeftMenuTitle:hover { opacity: 0.8; }
    .bLeftMenuTitle.active, .bLeftMenuTitle.bLeftMenuTitleActive { color: #fff; border: 1px solid #42c1f4; background: #1e9ede; border-radius: 3px; 
        background: -webkit-gradient(linear, 0% 20%, 0% 90%, from(#61D6F7), to(#1E9EDE)); background: -moz-linear-gradient(top, #61D6F7, #1E9EDE); 
        filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FF61D6F7',EndColorStr='#FF1E9EDE'); }
    .bLeftMenuContent { border:1px solid #ddd; width: 145px; border-top: none; }
    .bLeftMenuContent h2 { color: #444; background: #e8e8e8 url('${image_path}/plus-black-8.gif') no-repeat 90% 50%; border-top: 1px solid #bbb; margin:0; padding:10px 0 10px 10px; font-size:14px; font-weight:normal; cursor:pointer; }
    .bLeftMenuCurrent { cursor:default !important; background: #e8e8e8 url('${image_path}/dot-black-8.gif') no-repeat 90% 50% !important; }
    
    .bLeftMenuTitle { 
        transition:0.2s;
        -moz-transition:0.2s; /* Firefox 4 */
        -webkit-transition:0.2s; /* Safari and Chrome */
        -o-transition:0.2s; /* Opera */
    }
    
    .bLeftMenuPanel { background: #fff; color:#444; font-size:12px; }
    .bLeftMenuPanel h3 { border:none; font-weight:normal; }
    .bLeftMenuPanel h3.active { text-decoration:none; background: #fef5dc; cursor:default; }
    .bLeftMenuPanel a { text-decoration:none; font-size: 12px; color: #484848; padding: 8px 0 8px 20px; display: block; width: 125px; }
    .bLeftMenuPanel a:hover { text-decoration:underline; }
    
    .bLeftMenuTitle a {color:#333;}
    .bLeftMenuTitleActive a {color:#fff;}
</style>

<div class="container-leftMenu left">
    <!-- ADMIN LEFT MENU START -->
    <sec:authorize ifAnyGranted="ROLE_POINTS_ADMIN">
        <a class="bLeftMenuTitle leftMenuTitle-admin-publisher" href="${points_cxt_path}/admin/publisher"><s:text name="bshare.points.admin.publisher"/></a>
        <div class="clear spacer10"></div>
        <a class="bLeftMenuTitle leftMenuTitle-admin-merchant" href="${points_cxt_path}/admin/merchant"><s:text name="bshare.points.admin.merchant"/></a>
        <div class="clear spacer10"></div>
        <a class="bLeftMenuTitle leftMenuTitle-admin-product" href="${points_cxt_path}/admin/product"><s:text name="bshare.points.admin.product"/></a>
        <a class="bLeftMenuTitle leftMenuTitle-admin-product" href="${points_cxt_path}/admin2/lucasproduct"><s:text name="烧点商品管理Lucas"/></a>
        <div class="clear spacer10"></div>
        <a class="bLeftMenuTitle leftMenuTitle-admin-deposit" href="${points_cxt_path}/admin/deposit"><s:text name="bshare.points.admin.deposit"/></a>
        <div class="clear spacer10"></div>
        <a class="bLeftMenuTitle leftMenuTitle-admin-orders" href="${points_cxt_path}/admin/orders"><s:text name="bshare.points.admin.order"/></a>
        <div class="clear spacer10"></div>
        
        <div rel="bLeftMenuAdminStatsVisitor" class="bLeftMenuTitle leftMenuTitle-admin-statistics">
            <div class="left"><s:text name="bshare.points.statistics"/></div>
            <div class="icon-down-grey right" style="margin:2px 0 0;"></div>
            <div class="clear"></div>
        </div>
        <div id="bLeftMenuAdminStatsVisitor" class="bLeftMenuContent">
            <div class="bLeftMenuPanel">
                <h3 class="leftMenu-admin-activeSites"><a class="statsPageLink" href="${points_cxt_path}/admin/activeSites"><s:text name="bshare.points.admin.stats.active.sites"/></a></h3>           
                <h3 class="leftMenu-admin-dailyStats"><a class="statsPageLink" href="${points_cxt_path}/admin/dailyStats"><s:text name="bshare.points.admin.stats.daily"/></a></h3> 
                <h3 class="leftMenu-admin-platformStats"><a class="statsPageLink" href="${points_cxt_path}/admin/platformStats"><s:text name="bshare.points.admin.stats.platforms"/></a></h3>
                <!-- 
                <h3 class="leftMenu-publisher-pageStats"><a class="statsPageLink" href="${points_cxt_path}/admin/pageStats"><s:text name="bshare.points.admin.stats.pages"/></a></h3>
                 -->
            </div>
        </div>
        <div class="clear spacer10"></div>
    </sec:authorize>
    <!-- ADMIN LEFT MENU END -->
    <!-- PUBLISHER LEFT MENU START -->
    <% if (((String)pageContext.getAttribute("curPath")).contains("publisher/")) { %>
    <sec:authorize ifAnyGranted="ROLE_POINTS_PUBLISHER" ifNotGranted="ROLE_POINTS_ADMIN">
        <a class="bLeftMenuTitle leftMenuTitle-publisher-userDashboard" href="${points_cxt_path}/publisher/userDashboard"><s:text name="bshare.points.overview"/></a>
        <div class="clear spacer10"></div>
        
        <a class="bLeftMenuTitle leftMenuTitle-publisher-account" href="${points_cxt_path}/publisher/account"><s:text name="bshare.points.account"/></a>
        <div class="clear spacer10"></div>
        
        <a class="bLeftMenuTitle leftMenuTitle-publisher-activity-list" href="${points_cxt_path}/publisher/activity/list"><s:text name="bshare.points.activities"/></a>
        <div class="clear spacer10"></div>
        
        <div rel="bLeftMenuPublisherStatsVisitor" class="bLeftMenuTitle leftMenuTitle-publisher-statistics">
            <div class="left"><s:text name="bshare.points.statistics"/></div>
            <div class="icon-down-grey right" style="margin:2px 0 0;"></div>
            <div class="clear"></div>
        </div>
        <div id="bLeftMenuPublisherStatsVisitor" class="bLeftMenuContent">
            <div class="bLeftMenuPanel">
                <h3 class="leftMenu-publisher-activityStats"><a class="statsPageLink" href="${points_cxt_path}/publisher/activityStats"><s:text name="bshare.points.stats.activities"/></a></h3>           
                <h3 class="leftMenu-publisher-activityContrast"><a class="statsPageLink" href="${points_cxt_path}/publisher/activityContrast"><s:text name="bshare.points.stats.contrast"/></a></h3> 
                <!--           
                <h3 class="leftMenu-publisher-userStats"><a class="statsPageLink" href="${points_cxt_path}/publisher/userStats"><s:text name="bshare.points.stats.user"/></a></h3>
                 -->
            </div>
        </div>
        <div class="clear spacer10"></div>
    </sec:authorize>
     <% } %>
    <!-- PUBLISHER LEFT MENU END -->
    <!-- USER LEFT MENU START -->
    <% if (((String)pageContext.getAttribute("curPath")).contains("user/")) { %>
    <sec:authorize ifAnyGranted="ROLE_USER" ifNotGranted="ROLE_POINTS_ADMIN">
        <a class="bLeftMenuTitle leftMenuTitle-user-profile" href="${one_cxt_path}/points/userProfile" target="_blank"><s:text name="bshare.points.user.profile"/></a>
        <div class="clear spacer10"></div>
        <a class="bLeftMenuTitle leftMenuTitle-user-activityRecords" href="${points_cxt_path}/user/activityRecords"><s:text name="bshare.points.user.record.activities"/></a>
        <div class="clear spacer10"></div>
        <a class="bLeftMenuTitle leftMenuTitle-user-orders" href="${points_cxt_path}/user/orders"><s:text name="bshare.points.user.record.orderrecords"/></a>
        <div class="clear spacer10"></div>
    </sec:authorize>
    <!-- USER LEFT MENU END -->
    <div class="clear"></div>
    <% } %>
</div>

<script type="text/javascript" charset="utf-8">
$(document).ready(function () {
    $(".bLeftMenuTitle").click(function() {
        var toDisplay = $("#" + $(this).attr("rel"));
        if (toDisplay.is(":visible")) {
            $(this).find('.icon-down-grey').addClass('icon-up-grey');
            toDisplay.slideUp();
        } else {
            $(this).find('.icon-down-grey').removeClass('icon-up-grey');
            toDisplay.slideDown();
        }
    });
});
</script>
