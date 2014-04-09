<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<style>
    .container-pExchange { padding: 15px 20px; _padding-top: 12px; _padding-bottom: 13px; position: relative; background: #fff; height: 62px;
        background: url(${points_image_path}/bkg-pExchange2.jpg) repeat-x; color: #666; z-index: 300;
        /* box-shadow: 0 0 5px #ddd; */ }
    .container-pExchange.promos { background: url(${points_image_path}/bkg-pExchange.jpg) no-repeat; 
        color: #ffcc00; font-family: Helvetica,Calibri,Tahoma,Arial,微软雅黑,宋体,sans-serif; font-size: 16px; border: 1px solid #01acf0; }
    .bLabel-pExchange { position: absolute; left: -8px; top: -9px; display: block; width: 90px; height: 90px;
        background: url(${points_image_path}/icons/banner-label-grey.png) no-repeat; z-index: 400; }
    .bLabel-pExchange.blue { background: url(${points_image_path}/icons/banner-label.png) no-repeat; }
    .wrapper-pExchange .keyword { font-style: italic; font-size: 18px; }
    .wrapper-pExchange .text-indent { padding-left: 40px; }
    .wrapper-pExchange input, .wrapper-pExchange select { margin-right: 5px; font-size: 14px; 
        border-width: 1px; border-style: solid; border-color: #939393 #c8c8c8 #c8c8c8; padding: 2px; }
    .wrapper-pExchange input { width: 100px; height: 20px; *line-height: 20px; }
    .wrapper-pExchange select { width: 200px; height: 25px; }
    #loginButton { *display: inline; zoom: 1; display: inline-block; height: 30px; width: 210px; margin: 38px 0 0 262px; /*background: #000;*/ }
    #taobaoPoint { font-size: 18px; font-weight: bold; text-align: center; }
    .pExchange-button { padding: 4px 20px; vertical-align:bottom }
    
    #loginOverlay { position: fixed; _position: absolute; top: 50%; left: 50%; margin-top: -100px; margin-left: -270px; z-index: 9999; 
        width: 570px; height: auto; color: #333; font-size: 14px; }
    .auth-message { display: none; }
    #iframeAuth { height: 280px; width: 500px; padding: 0 20px; border: 1px solid #ddd; }
    .bSearch-hint { display: none; padding: 5px 4px; color: #bbb; position: absolute; left: 306px; top: 0; *left: 320px; *top: 2px; }
    #errorDiv { width: 630px; }
</style>

<div class="module-white-grey container-pExchange<sec:authorize ifNotGranted="ROLE_USER"> promos</sec:authorize>">
    <span class="bLabel-pExchange<sec:authorize ifAnyGranted="ROLE_USER"> blue</sec:authorize>"></span>
    <div class="wrapper-pExchange">
        <sec:authorize ifNotGranted="ROLE_USER">
	        <p class="center"><a rel="loginOverlay" href="javascript:;" id="loginButton"></a></p>
        </sec:authorize>
        <sec:authorize ifAnyGranted="ROLE_USER" ifNotGranted="ROLE_POINTS_ADMIN">
            <%-- <s:if test="%{request.taobaoAccounts}"> --%>
                <p class="text-indent">您目前账户中可兑换的<s:text name="bshare.points.point"/>为：<span class="text-blue keyword">${request.pointsUser.points}</span>&nbsp;&nbsp;&nbsp;&nbsp;<s:text name="bshare.shop.order.points.rate"/>：<s:text name="bshare.shop.order.points.ratemessage"><s:param>${request.taoBaoPoints.currentPoints}</s:param><s:param>${request.taoBaoPoints.name}</s:param></s:text></p>
                <div class="spacer15"></div>
                <div class="text-indent" style="overflow:hidden;zoom:1;position: relative;">
                <form id="exchangeForm" name="exchangeForm" method="POST" action="${points_cxt_path}/shop/order/points" onsubmit="return verifyForm(this);">
                    <div class="left">将数量
                        <input name="order.productId" value="${request.taoBaoPoints.id}" type="hidden"/>
	                    <input id="bSharePoint" name="order.orderPoints" type="number" maxlength="5" min="0" max="${request.pointsUser.points}" value="0" />
	                    <span id="exchangeRate"></span>的
	                    <span><s:text name="bshare.points.point"/></span>转换为
	                    <label class="bSearch-hint" for="userAccountName"><span><s:text name="bshare.shop.order.points.pointsaccount"><s:param>${request.taoBaoPoints.merchant.name}</s:param></s:text></span></label>
	                    <input name="userAccount.accountName" id="userAccountName" type="text"  maxlength="50" style="width: 200px;" />的
	                    <input type="hidden" id="orderProdNum" name="order.prodNum"/>
	                    <span id="taobaoPoint" class="text-blue keyword"></span>
	                    <span>集分宝</span>
                    </div>
                    <div class="right">
                        <button type="submit" class="pExchange-button bButton-blue">兑换</button>
                    </div>
                </form>
                </div>
        </sec:authorize>
    </div>
    <div class="clear"></div>
</div>
<div id="loginOverlay" class="bOverlay">
    <div class="body">
        <a href="javascript:;" class="close">X</a>
        <p class="auth-message">还没有bShare账号？ <a href="javascript:;" class="auth-link bLinkBlue">免费注册</a></p>
        <p class="auth-message">已经有一个账户？<a href="javascript:;" class="auth-link gotoLogin bLinkBlue">登录</a></p>
        <div class="spacer10"></div>
        <iframe id="iframeAuth" scrolling="no" frameborder="0"></iframe>
    </div>
</div>
<script tyle="text/javascript" charset="utf-8">
function loginSuccess() {
    window.location.reload();
}
function initAuthLink() {
    $(".auth-link").click(function () {
        $(".auth-message").show();
        $(".auth-link").addClass("bLinkBlue").removeClass("bLinkDark");
        $(this).removeClass("bLinkBlue").addClass("bLinkDark");
        $(this).closest(".auth-message").hide();
        var _gotoLogin = $(this).hasClass("gotoLogin");
        var _src = "${one_cxt_path}/iframe" + (_gotoLogin ? "Login" : "Register") + 
            "?enableOauth=true&service=${points_cxt_path}/authentication&targetUrl=${points_cxt_path}/loginCallback" + (_gotoLogin ? "" : "&roleType=user") + "&source=points";
        var _height = 280; 
        if (_gotoLogin) {
        	$("#iframeAuth").removeClass("frame-register");
        } else {
        	_height += 100;
        	$("#iframeAuth").addClass("frame-register");
        }
        $("#iframeAuth").attr("src", _src);
        $("#iframeAuth").height(_height);
    });
    $("#loginButton").click(function () {
    	$("#" + $(this).attr("rel")).show();
    	$(".auth-link.gotoLogin").trigger("click");
    });
    $(".close").click(function () {
    	$(this).closest(".bOverlay").hide();
    });
}

$(document).ready(function () {
	initAuthLink();
});
</script>
<sec:authorize ifAnyGranted="ROLE_USER" ifNotGranted="ROLE_POINTS_ADMIN">
<script type="text/javascript" charset="utf-8">
var EXCHANGE_RATE = ${request.taoBaoPoints.currentPoints};
function initPointInput() {
    var formatNumber = function (value) {
        value = value.replace(/[^\d]/g, "");
        if (!value) {
        	value = "0";
        }
        var current=${request.pointsUser.points};
        current = value>current?current:value;
        var exPoints = ((current-current%EXCHANGE_RATE)/EXCHANGE_RATE).toFixed();
        value = exPoints*EXCHANGE_RATE;
        $("#taobaoPoint").text(exPoints);
        $("#orderProdNum").val(exPoints);
        return value;
    };
    $.fn.numeral = function() {
         $(this).css("ime-mode", "disabled");
         this.bind("blur", function() {
             if (isNaN(this.value)) {
                 this.value = formatNumber(this.value);
             }
             this.value = formatNumber(this.value);
         });
          this.bind("paste", function() {
             var s = clipboardData.getData('text');
             this.value = formatNumber(s);
             return false;
         }); 
          this.bind("dragenter", function() {
             return false;
         }); 
/*          this.bind("keyup", function() {
             this.value = formatNumber(this.value);
         }); */
     };     
     $("#bSharePoint").numeral();
     formatNumber($("#bSharePoint").val());
}
function switchInputContent(target) {
	if($(target).val() == '') {
        $(target).prev().css({"display": "block"});
    } else {
        $(target).prev().css({"display": "none"});
    }
}
function verifyForm(form){
	var points = "${request.pointsUser.points}";
	var productPoints = "${request.taoBaoPoints.currentPoints}";
    if(Number(points)<Number(productPoints)){
    	$("#errorDiv").data("overlay").load();
    	return false;
    }
    return true;
}
function initErrDiv() {
	var errMsg = '<s:text name="bshare.shop.points.errorinfo"/>';
	$("#pointserror").html(errMsg);
    $(".popup-topup").click(function () {
        $(this).closest(".bOverlay").hide();
        $("#dialogTopup").data("overlay").load();
    });
}
$(function() {
    $('#userAccountName').focus(function() {
        $(this).prev().css({"display": "none"});
    }).blur(function() {
    	switchInputContent(this);
    });
    initErrDiv();
    switchInputContent('#userAccountName');
});

$(document).ready(function () {
    initPointInput();
});
</script>
</sec:authorize>
<%@ include file="/jsp/common/commError.jsp"%>
