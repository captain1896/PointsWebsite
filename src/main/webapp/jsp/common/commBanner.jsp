<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<style>
    .container-banner .wrapper-banner a { display: none; height: 300px; width: 640px; }
    .container-banner .wrapper-banner img { display: block; height: 300px; width: 640px; }
    .container-banner .wrapper-tabs { margin: -30px auto; position: relative; width: 70px; *width: 75px; }
    .container-banner .wrapper-tabs a { width: 11px; height: 11px; float: left; *display: inline; margin: 3px; display: block; font-size: 1px;
        background: url(${image_path}/banners/banner-dots.png) 0 -11px no-repeat; }
    .container-banner .wrapper-tabs a:hover { background-position: 0 0; }
    .container-banner .wrapper-tabs a.current { background-position:0 0; } 
</style>

<div class="wrapper-banner">
    <a href="${points_cxt_path}/events/2012/v5/2c" target="_blank"><img src="${points_image_path}/banners/index-banner-v5.jpg"/></a>
    <a href="${points_cxt_path}/events/qixi2012" target="_blank"><img src="${points_image_path}/banners/index-banner-qixi.jpg"/></a>
    <a href="${points_cxt_path}/help" target="_blank" style="display: block;"><img src="${points_image_path}/banners/index-banner-1.jpg"/></a>
    <!-- 
    <a href="${points_cxt_path}/help" target="_blank"><img src="${points_image_path}/banners/index-banner-3.jpg"/></a>
    <a href="${points_cxt_path}/help" target="_blank"><img src="${points_image_path}/banners/index-banner-4.jpg"/></a>
    -->
</div>
<div class="wrapper-tabs">
    <a href="#"></a>
    <a href="#"></a>
    <a href="#"></a>
</div>

<script tyle="text/javascript" charset="utf-8">
$(document).ready(function () {
    $(".wrapper-tabs").tabs(".wrapper-banner > a", {
        rotate: true
    }).slideshow({
        interval: 5000,
        autoplay: true
    });
});
</script>