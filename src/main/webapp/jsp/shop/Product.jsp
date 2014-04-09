<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<meta name="description" content="现在花费  ${request.product.currentPoints} 个微积分，就可以在微积分平台兑换到由${request.product.merchant.name}提供的价值  ${request.product.priceMarket} 元的${request.product.name}，还有更多超值商品等待您的兑换。" />
<meta name="keywords" content="${request.product.name}, ${request.product.merchant.name}, 参与积分兑换, 微积分, 分享获取积分, 积分兑换商品" />
<title>${request.product.name} - ${request.product.productCategory.name} - <s:text name="bshare.points.title"/></title>

<style>
    .text-ellipsis { overflow: hidden; text-overflow: ellipsis; -ms-text-overflow: ellipsis; white-space: nowrap; width: 100%; }
    .module-white-grey { padding: 20px; }
    .container-prod { width: 670px; position: relative; }
    .card-product { zoom: 1; overflow: hidden; color: #333; position: relative; height: 302px; padding-left: 20px; }
    .wrapper-product p { margin: 5px 0; }
    .wrapper-product h4 { *margin: 20px 0; }
    .product-image { border: 1px solid #dadada; width: 300px; height: 300px; line-height: 300px; vertical-align: middile; }
    .product-image img { margin: 0 auto; display: block; }
    .product-title { height: 24px; line-height: 24px; overflow: hidden; }
    .prod-like { position: absolute; bottom: 0; }
    #showDetails { margin: 20px 15px; line-height: 18px; text-decoration: underline; font-size: 12px; cursor: pointer; }
    #prodDesc { font-size: 12px; color: #666; line-height: 200%; }
    #prodDesc.text-full { word-wrap: break-word; }
    
    .separator { background: #dadada; }
    #iframeAuth { width: 500px; padding: 0 20px; border: 1px solid #ddd; }
    .param-title { width: 80px; margin-right: 10px; line-height: 28px; }
    .wrapper-form { width: 65%; margin: 0 auto; }
    .wrapper-form input, .wrapper-form textarea, .wrapper-form select { margin-left: 0px; padding: 5px; font-size: 14px; 
        border-width: 1px; border-style: solid; border-color: #939393 #c8c8c8 #c8c8c8; }
    .wrapper-form input { height: 20px; width:300px; }
    .wrapper-form select { height: 32px; width: 154px; *width: 152px; }
    .wrapper-form option { padding: 5px; }
    .wrapper-form seelct[disabled=disabled] { background-color: #e9e9e9; }
    #address { display: block; margin-left: 90px; }
    .prod-button { margin: 0 auto; padding: 8px 51px; font-size: 14px; }
    
    #activityList { background: url(${points_image_path}/bkg-grey-white.png) repeat-x #fff; 
        width: 250px; border: 1px solid #ddd; }
        
    #errorDiv { width: 630px; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/shop/category/${request.product.productCategory.id}">${request.product.productCategory.name}</a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/shop/product/${request.product.id}">${request.product.name}</a>
	</div>
	<div class="spacer20 clear"></div>
	<div class="module-white-grey container-prod left">
		<div class="wrapper-product">
	        <div class="product-title text-blue heading1">${request.product.name}</div>
	        <div class="spacer20"></div>
	        <div class="product-image left"><img title="${request.product.name}" src="${request.product.picUrl}" /></div>
	        <div class="card-product">
	            <div class="spacer30"></div>
	            <p><s:text name="bshare.shop.product.condition"/>：<s:text name="bshare.points.number.format">
                        <s:param value="%{#request.product.initialPoints}" /></s:text>&nbsp;&nbsp;微积分</p>
	            <div class="spacer15"></div>
	            <!-- 
	            <p>促　　销：<span class="text-blue" style="font-size: 16px">${request.product.currentPoints}微积分</span></p>
	            <div class="spacer15"></div>
	            -->
	            <p>市场价格：<s:text name="bshare.points.number.format">
                        <s:param value="%{#request.product.priceMarketValue}" /></s:text>&nbsp;&nbsp;元</p>
	            <div class="spacer15"></div>
	            <p class="text-ellipsis" title="${request.product.brand}">品　　牌：${request.product.brand}</p>
	            <div class="spacer15"></div>
	            <p class="text-ellipsis">所属公司：<a class="bLinkBlue" title="${request.product.merchant.name}"
	                href="${request.product.merchant.homeURLPrefix}" target="_blank">${request.product.merchant.name}</a></p>
	            <div class="spacer15"></div>
	            <p class="text-ellipsis">库　　存：<s:if test="#request.product.storeNum==-1">无限制</s:if><s:else>${request.product.storeNum}</s:else></p>
	            <div class="spacer15"></div>
	            <s:if test="%{#request.product.descUrlPrefix!=''}">
	            <p class="text-ellipsis">商品链接：<a class="bLinkBlue"
	               href="${request.product.descUrlPrefix}" target="_blank">查看链接</a></p>
	            <div class="spacer15"></div>
	            </s:if>
	        </div>
	        <div class="spacer10 clear"></div>
	        <s:if test="%{#request.product.desc!=''}">
		        <h4 class="left">商品描述</h4><a id="showDetails" class="text-blue left">展开</a>
		        <div class="clear"></div>
		        <p id="prodDesc" class="text-ellipsis">${request.product.desc}</p>
	        </s:if>
	    </div>
		<div class="spacer20 clear"></div>
		
	    <div class="separator spacer1"></div>
	    <div class="spacer20"></div>
		
		<sec:authorize ifNotGranted="ROLE_USER">
	    <div class="wrapper-login">
	        <p>您需要<a class="auth-link gotoLogin bLinkBlue" href="javascript:;">登录</a>才能进行兑换。如果您没有微积分帐号，请<a class="auth-link bLinkBlue" href="javascript:;">注册</a>。</p>
	        <div class="spacer20"></div>
	        <iframe id="iframeAuth" scrolling="no" frameborder="0"></iframe>
	    </div>
	    </sec:authorize>
	    <sec:authorize ifAnyGranted="ROLE_USER">
	    <div class="wrapper-form">
	    <form id="shipInfoForm" name="shipInfoForm" method="POST" action="${points_cxt_path}/shop/order/<s:if test="#request.product.lottery">lottery</s:if>product" onsubmit="return verifyForm(this);">
	        <input type="hidden" id="productId" name="order.productId" value="${request.product.id}"/>
	        <input type="hidden" id="productNum" name="order.prodNum" value="1"/>
	        <s:if test="#request.product.lottery">
	           <div class="spacer20"></div>
	        </s:if>
	        <s:else>
	        <p>请填写详细收货人信息（信息仅为活动使用，绝不公开）</p>
	        <div class="spacer30"></div>
	        <div><span class="param-title inlineBlock">真实姓名：</span><input id="name" name="pointsUser.contactName" type="text" maxlength=50 required="required" value="${request.pointsUser.contactName}"/></div>
	        <div class="spacer10"></div>
	        <div><span class="param-title inlineBlock">联系电话：</span><input id="mobile" class="number" name="pointsUser.contactNo" type="text" maxlength=12 required="required" value="${request.pointsUser.contactNo}"/></div>
	        <p class="field-tip" style="margin: 5px 0 0 90px;">请输入手机或固定电话，固话区号与电话号码间无间隔</p>
	        <div class="spacer10"></div>
	        <div>
	            <span class="param-title inlineBlock" style="margin-right: 6px;">联系地址：</span>
	            <select id="state" name="pointsUser.state"></select>
	            <select id="city" name="pointsUser.city"></select>
	            <div class="spacer10"></div>
	            <input id="address" name="pointsUser.contactAddress" type="text" maxlength=50 required="required" value="${request.pointsUser.contactAddress}"/>
	        </div>
	        <div class="spacer10"></div>
	        <div><span class="param-title inlineBlock">邮政编码：</span><input id="postcode" class="number" name="pointsUser.zipCode" type="text" maxlength=6 required="required" value="${request.pointsUser.zipCode}"/></div>
	        <div class="spacer20"></div>
	        </s:else>
	        <div class="center"><button type="submit" class="prod-button bButton-blue"><s:text name="bshare.points.to.exchange" /></button></div>
	    </form>
	    </div>
	    </sec:authorize>
		<div class="spacer20 clear"></div>
	</div>
	
	<div id="activityList" class="container-activities right">
	    <%@ include file="/jsp/common/commActivities.jsp"%>
	</div>
	<div class="spacer20 clear"></div>
</div>
<%@ include file="/jsp/common/commError.jsp"%>

<script type="text/javascript" charset="utf-8">
$(document).ready(function () {
	bShare.entries = [];
    bShare.addEntry({
        title: unescapeHTML("${request.poduction.name}"),
        summary: '现在在@bShare微积分 平台，仅需使用 ${product.initialPoints} 个积分，就可以兑换到价值 ${product.priceMarketValue} 元的 ${product.name} - 我正在使用微积分，你也来试试吧！ 更多超值产品，尽在微积分',
        vUid: '<s:property value="%{#session.USER_ID}"/>', 
        vEmail: '<s:property value="%{#session.DISPLAY_NAME}"/>', 
        vTag: 'BSHARE'
    });
    
	$("#showDetails").click(function () {
		if ($("#prodDesc").hasClass("text-ellipsis")) {
			$("#prodDesc").removeClass("text-ellipsis").addClass("text-full");
			$(this).text("收起");
		} else {
			$("#prodDesc").removeClass("text-full").addClass("text-ellipsis");
            $(this).text("展开");
		}
	});
    
    $("#activityList .activity-summary").hide();
    $("#activityList .card-activity").show();
});
</script>
<sec:authorize ifNotGranted="ROLE_USER">
<script type="text/javascript" charset="utf-8">
function loginSuccess() {
    window.location.reload();
}
$(function () {
	$(".auth-link").click(function () {
	    $(".auth-link").addClass("bLinkBlue").removeClass("bLinkDark");
	    $(this).removeClass("bLinkBlue").addClass("bLinkDark");
	    var _gotoLogin = $(this).hasClass("gotoLogin");
	    var _src = "${one_cxt_path}/iframe" + (_gotoLogin ? "Login" : "Register") + 
	        "?enableOauth=true&service=${points_cxt_path}/authentication&targetUrl=${points_cxt_path}/loginCallback" + (_gotoLogin ? "" : "&roleType=user") + "&source=points";
	    var _height = 280; 
	    if (!_gotoLogin) {
	        _height += 100;
	    }
	    $("#iframeAuth").attr("src", _src);
	    $("#iframeAuth").height(_height);
	});
	$(".gotoLogin").trigger("click");
});
</script>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_USER">
<script type="text/javascript" charset="utf-8" src="${points_js_path}/city.js"></script>
<script type="text/javascript" charset="utf-8">
var isSubmitting = false;

function initAddressSelector() {
    for (var state in CITIES) {
        $("#state").append('<option value="' + state + '">' + state + '</option>');
    }
    var fillCities = function () {
    	var state = $("#state").val();
        $("#city").html("");
        var cities = CITIES[state];
        if (cities.length === 0) {
            $("#city").attr("disabled", "disabled");
            return;
        }
        $("#city").removeAttr("disabled");
        for (var cityNo in cities) {
            $("#city").append('<option value="' + cities[cityNo] + '">' + cities[cityNo] + '</option>');
        }
    }
    $("#state").change(function () {
        fillCities();
    });
    var defaultState = "${request.pointsUser.state}", defaultCity = "${request.pointsUser.city}";
    setTimeout(function () {
        $("#state").val(defaultState);
        $("#state").trigger("change");
        if (!!defaultCity) {
            setTimeout(function () {
                $("#city").val(defaultCity);
            }, 0);
        }
    }, 0);
}

function validateMobile() {
	var value = $("#mobile").val();
	var regx = /(^((0[1,2]{1}\d{1}?\d{8})|(0[3-9]{1}\d{2}?\d{7,8}))$)|(^0?(13[0-9]|15[0-35-9]|18[0236789]|14[57])[0-9]{8}$)/;
	if (!regx.test(value)) {
		return false;
	}
    return true;
}

function validatePostcode() {
	var value = $("#postcode").val();
	var regx = /^[0-9]{6}$/;
	if (!regx.test(value)) {
		return false;
	}
    return true;
}

function verifyForm(target) {
    if(isSubmitting) {
        return false;
    }
    hideStatusMessage();
    <s:if test="!#request.product.lottery">
    if (!$(target).data("validator").checkValidity()) {
        return false;
    }
    if (!validateMobile()) {
        displayStatusMessage("请输入有效的联系电话", "error");
        return false;
    }
    if (!validatePostcode()) {
        displayStatusMessage("请输入有效的邮政编码", "error");
        return false;
    }
    </s:if>
    var result =1;
    $.ajax({
	    type: 'POST',
	    async:false,
	    url: '${points_cxt_path}/shop/order/<s:if test="#request.product.lottery">lottery</s:if>productjs',
	    data:$("#shipInfoForm").serialize(),
	    success: function(results) {
	        if (!results.success) {
	        	$("#pointserror").html(results.contents.message);
	        	$("#errorDiv").data("overlay").load();
            	result=2;
	        }
	    },
	    error: function() {
	    	displayStatusMessage('<s:text name="bshare.points.common.error"/>', "error");
	    }
	});
    if(result==2){
    	return false;
    }
    isSubmitting = true;
    displayStatusMessage('<s:text name="bshare.points.wait"/>', "info");
    $("#updateActivityButton").html('<s:text name="bshare.points.wait"/>');
    return true;
}

$(document).ready(function () {
    $.tools.validator.localize('<s:text name="bshare.lang.code"/>', {
        '*'         : '<s:text name="bshare.field.error.general"/>',
        ':email'    : '<s:text name="bshare.field.error.email"/>',
        ':number'   : '<s:text name="bshare.field.error.number"/>',
        ':url'      : '<s:text name="bshare.field.error.url"/>',
        '[max]'     : '<s:text name="bshare.field.error.point.max"/>',
        '[min]'     : '<s:text name="bshare.field.error.min"/>',
        '[required]': '<s:text name="bshare.field.error.required"/>'
    });

    $("#shipInfoForm").validator({
        lang: '<s:text name="bshare.lang.code"/>',
        messageClass: 'errorInput',
        onFail: function() {
            isSubmitting = false;
            // $("#saveActivityButton").text('<s:text name="bshare.points.save"/>');
            hideStatusMessage();
        }
    });
    
    initAddressSelector();
});

</script>
<!-- 
<script type="text/javascript" charset="utf-8">
bShareOpt = {
   uuid: "${bSharePointsUuid}",
   url: window.location.href,
   title: "${request.prodName}",
   summary: "${request.prodSummary}",
   template: "1" 
};
</script>
<script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/bshareLike.js#style=2&amp;color=blue"></script>
-->
</sec:authorize>
