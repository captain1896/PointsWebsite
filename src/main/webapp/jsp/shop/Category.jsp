<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<title>${request.category.name} - <s:text name="bshare.points.title"/></title>

<link rel="stylesheet" type="text/css" href="${css_path}/pagination.css" />
<style>
    .separator { background: #dadada; }
    
    .container-category { padding: 5px 15px; background: #fff; color: #666; border: 1px solid #e5e5e5; }
    .wrapper-category a { height: 30px; line-height: 30px; width: 120px; }
    
    #activityList { background: url(${points_image_path}/bkg-grey-white.png) repeat-x #fff; border: 1px solid #dadada; width: 200px; }
    #activityList li { margin-left: 0; }
    #activityList .activity-image { width: 120px; height: 120px; margin: 0 auto 10px; float: none; }
    #activityList .activity-title { max-height: 36px; }
    #activityList .wrapper-button { text-align: center; }
    #activityList .button-more { padding: 6px 30px; font-size: 12px; }
    #activityList .activity-info  { padding-left: 15px; }
    
    .container-promos { height: 280px; width: 760px; border: 1px solid #dadada; background: #fff; }
    .container-promos .wrapper-header { width: 144px; height: 40px; line-height: 40px; margin-top: -8px; 
        margin-left: 15px; color: #fff; text-align: center; background: url(${points_image_path}/header-blue-1.png) no-repeat; }
    .wrapper-promo, .wrapper-promo-image { margin: 5px 25px; width: 200px; display: block; }
    .wrapper-promo { height: 20px; line-height: 20px; overflow: hidden; }
    .wrapper-promo-image { border: 1px solid #dadada; height: 200px; }
    .wrapper-promo-image img { width: 200px; height: 200px; }
    
    .container-products { width: 720px; overflow: hidden; background: #fff; margin-top: 20px; padding: 20px; 
        border: 1px solid #dadada; borde-radius: 5px; }
    .container-products .wrapper-header .view-prod { padding: 5px 20px 5px 40px; position: relative; }
    .container-products .wrapper-header span { display: inline-block; *display: inline; zoom: 1; height: 15px; width: 15px; 
        position: absolute; left: 10px; top: 6px; 
        background: url(${points_image_path}/icons/view-style.png) no-repeat 0 0; *background-image: url(${points_image_path}/icons/view-style.gif); }
    .container-products .wrapper-header .view-thumb span { background-position-x: -15px; }
    .container-products .wrapper-header .bButton-blue span { background-position-y: -15px; }
    .container-products .wrapper-header .bButton span { background-position-y: 0; }
    .container-products .wrapper-header .view-list span { background-position-x: 0; }
    .container-products .wrapper-product { padding-top: 20px; background-color: #fff; position: relative; text-align: center; width: 180px; }
    .pLabel-new { position: absolute; left: -2px; _left: -17px; top: -4px; display: block; width: 54px; height: 54px;
        background: url(${points_image_path}/icons/product-label.png) no-repeat; }
    .product-image { border: 1px solid #dadada; width: 150px; height: 150px; display: block; margin:0 auto;}
    .product-image img { display: block; margin: 0 auto; }
    .card-product { zoom: 1; overflow: hidden; position: relative; margin-bottom: 10px; color: #666; padding: 0 10px; margin-top:15px;}
    .card-product a { text-decoration: none; }
    .product-title { height: 24px; line-height: 24px; display: block; overflow: hidden; word-wrap: break-word; }
    .product-summary { font-size: 12px; height: 30px; line-height: 15px; display: block; overflow: hidden; word-wrap: break-word; }
    .product-points { font-size: 12px !important; }
    .product-button { padding: 6px 30px; font-size: 12px; margin-top: 10px; }
    .product-like { float: none; margin-left: 15px; }
    .container-products.view-list .wrapper-product { padding: 20px 0; width: 100%; border-bottom: 1px solid #dadada; }
    .container-products.view-list .product-image { float: left; margin: 0 15px; *margin-left: 7px; }
    .container-products.view-list .card-product { float: left; position: relative; width: 360px; height: 120px; text-align: left; padding: 0; }
    .container-products.view-list .product-title { height: 48px; }
    .container-products.view-list .product-points { position: absolute; bottom: 0px; }
    .container-products.view-list .product-like { position: absolute; bottom: 20px; left: 180px; margin-left: 0; }
    .container-products.view-list .product-button { position: absolute; right: 0; bottom: 20px; }
    .container-products.view-list .wrapper-sep { display: none; }
    
    .container-activities .wrapper-header { margin-left: 5px !important; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
	    <s:if test="#request.category.id>0">
	         <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/shop/category/all"><s:text name="bshare.shop.product.category.all"/></a>
	    </s:if>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/shop/category/${request.category.nameEn}">${request.category.name}</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<div class="container-category">
	    <div class="wrapper-category">
	    <s:iterator value="#request.categories" var="cate" status="status">
	       <a class="inlineBlock bLinkDark" href="${points_cxt_path}/shop/category/${cate.nameEn}">${cate.name}（${cate.prodNum}）</a>
	    </s:iterator>
	    </div>
		<div class="clear"></div>
	</div>
	<div class="spacer20 clear"></div>
	
	<div id="activityList" class="container-activities right">
	    <%@ include file="/jsp/common/commActivities.jsp"%>
	</div>
	
	<div class="container-promos left">
	    <div class="wrapper-header heading3">推荐商品</div>
	    <div class="spacer5 clear"></div>
	    <s:iterator value="#request.products" var="product" status="status">
	        <s:if test="#status.count <= 3">
	            <div class="left">
	                <a class="wrapper-promo-image" href="${points_cxt_path}/shop/product/${product.id}" title="${product.name}">
		                <img src="${product.picUrl}" />
		            </a>
		            <a class="wrapper-promo bLinkBlue heading3 text-blue center" href="${points_cxt_path}/shop/product/${product.id}" title="${product.name}">${product.name}</a>
	            </div>
	        </s:if>
	    </s:iterator>
	    <div class="spacer10 clear"></div>
	</div>
	
	<div class="container-products left">
		<div class="wrapper-header">
	        <a class="bButton view-prod view-thumb"><span></span>大图</a>
		    <a class="bButton view-prod view-list"><span></span>列表</a>
		</div>
		<div class="spacer15 clear"></div>
	    <s:if test="#request.products.size == 0">
	        <div class="spacer50 clear"></div>
	        <p class="center">当前类别还没有商品哦 ！</p>
	        <div class="spacer50 clear"></div>
	    </s:if>
	    <s:else>
		    <s:iterator value="#request.products" var="product" status="status">
		        <div class="wrapper-product left">
		            <s:if test="%{#product.isNew}">
		                <span class="pLabel-new"></span>
		            </s:if>
		            <a class="product-image" href="${points_cxt_path}/shop/product/${product.id}" target="_blank" title="${product.name}"><img src="${product.thumbnail}" /></a>
		            <div class="card-product">
		                <a href="${points_cxt_path}/shop/product/${product.id}" target="_blank" class="product-title bLinkBlue heading3" title="${product.name}">${product.name}</a>
		                <div class="spacer5 clear"></div>
		                <a href="${points_cxt_path}/shop/product/${product.id}" target="_blank" class="product-summary bLinkDark" title="${product.desc}">${product.desc}</a>
		                <div class="spacer5 clear"></div>
		                <p class="product-points heading4"><s:text name="bshare.points.need.points"><s:param value="%{#product.currentPoints}"/></s:text></p>
		            </div>
		            <!-- <a class="product-like bsLikeDiv" href="${main_cxt_path}"></a> -->
		            <a class="product-button bButton-blue" href="${points_cxt_path}/shop/product/${product.id}" target="_blank">查看详细</a>
		        </div>
		        <s:if test="%{#status.count % 4 == 0}">
		           <div class="wrapper-sep">
		               <div class="spacer30 clear"></div>
		               <div class="spacer1 clear separator"></div>
		           </div>
		        </s:if>
		    </s:iterator> 
	    </s:else>
	    <div class="clear spacer10"></div>
		<div id="bindedPagination" class="right pagination"></div>
	    <div class="clear spacer10"></div>
	</div>
	<div class="spacer20 clear"></div>
	
	<form name="formPagination" id="formPagination" action="${points_cxt_path}/shop/category/${category.nameEn}" method="post">
	    <input type="hidden" name="pageNo" id="pageNo" value=""/>
	</form>
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
	$('#pageNo').val(clickedNumber+1);
	setTimeout(function(){$('#formPagination').submit();},0);
}
</script>
<script type="text/javascript" charset="utf-8">
$(function () {
	$("#cate${request.category.id}").addClass("selected");
	
    if ("${pagination.totalPage}" > 1) {
        initPage("${pagination.pageNo}","${pagination.pageSize}","${pagination.totalCount}");
    }
    $(".view-prod").click(function () {
    	$(".view-prod.bButton-blue").removeClass("bButton-blue").addClass("bButton");
        $(this).removeClass("bButton").addClass("bButton-blue");
    	if ($(this).hasClass("view-list")) {
    		$(".container-products").addClass("view-list");
    	} else {
    		$(".container-products").removeClass("view-list");
    	}
    });
    $("#activityList .activity-summary").hide();
    $("#activityList .card-activity").show();
    $("#activityList").append('<div class="wrapper-button"><a href="${points_cxt_path}/shop/activities" target="_blank" class="button-more bButton-blue">查看所有活动</a><div class="spacer20 clear"></div></div>');
    $(".container-products").find(".separator").last().hide();
    $(".view-prod").first().trigger("click");
});
</script>
<!-- 
<script type="text/javascript" charset="utf-8">
bShareOpt = {
   uuid: "${bSharePointsUuid}",
   template: "1" 
};
</script>
<script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/bshareLike.js#&color=blue"></script>
<script type="text/javascript" charset="utf-8">
function initLikeButtons() {
    <s:iterator value="#request.products" var="product" status="status">
    bShareLike.addEntry({
        url: "${points_cxt_path}/shop/product/${product.id}",
        pic: "${product.pic}",
        title: "${product.name}"
    });
    </s:iterator>
}

$(document).ready(function () {
    initLikeButtons();
});
</script>
-->
