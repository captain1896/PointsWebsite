<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<title>${request.product.name} - <s:text name="bshare.points.title"/></title>

<style>
    .module-white-grey { padding: 20px; }
    .container-exchange { width: 670px; position: relative; }
    .card-product { zoom: 1; overflow: hidden; color: #333; position: relative; height: 302px; padding-left: 20px; }
    .wrapper-points p { margin: 5px 0; }
    .wrapper-points h4 { display: inline-block; *display: inline; zoom: 1; color: #333; }
    .product-image { border: 1px solid #dadada; width: 300px; height: 300px; line-height: 300px; vertical-align: middile; }
    .card-product .param-title { width: 70px; }
    .product-image img { margin: 0 auto; display: block; }
    .activity-title { color: #333; font-size: 16px; height: 20px; line-height: 20px; overflow: hidden; }
    .exchange-button { margin: 0 auto; padding: 6px 51px; font-size: 12px; }
    .table-size {font-size: 12px;}
    
    .bSearch-hint { display: none; padding: 5px 4px; color: #bbb; position: absolute; left: 0; top: 0; }
    #activityList { background: url(${points_image_path}/bkg-grey-white.png) repeat-x #fff; 
        width: 250px; border: 1px solid #ddd; }
    #errorDiv { width: 630px; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
	    <span>&gt;</span>${request.product.name}
	</div>
	<div class="spacer20 clear"></div>
	<div class="module-white-grey container-exchange left">
	<form id="shipInfoForm" name="shipInfoForm" method="POST" action="${points_cxt_path}/shop/order/pointsconfirm" onsubmit="return checkSubmit();">
		<div class="wrapper-points">
	        <h1 class="activity-title">${request.product.name}<s:text name="bshare.shop.order.points.info"/></h1>
	        <input type="hidden" name="order.productId" value="${request.product.id}"/>
	        <input type="hidden" name="order.orderNo" id="orderNo" value="${request.order.orderNo}"/>
	        <div class="spacer15 clear"></div>
	        <table class="table-size">
	           <tr>
	             <td><span class="param-title inlineBlock"><s:text name="bshare.shop.order.points.rate"/></span>：</td>
	             <td colspan="2"><s:text name="bshare.shop.order.points.ratemessage"><s:param>${request.product.currentPoints}</s:param><s:param>${request.product.name}</s:param></s:text>&nbsp;&nbsp;&nbsp;<a 
	                 class="bLinkBlue" href="${request.product.merchant.homeURLPrefix}"><s:text name="bshare.shop.order.points.points.info"><s:param>${request.product.name}</s:param></s:text></a></td>
	           </tr>
	           <tr><td colspan="3"><div class="spacer15"></div></td></tr>
	           <tr>
	             <td><span class="param-title inlineBlock"><s:text name="bshare.shop.order.points.using" /></span>：</td>
	             <td colspan="2">${request.pointsUser.points}</td>
	           </tr>
	           <tr><td colspan="3"><div class="spacer15"></div></td></tr>
	           <tr>
	             <td><span class="param-title inlineBlock"><s:text name="bshare.shop.order.points.num"/></span>：</td>
	             <td colspan="2"><input id="bSharePoint" name="orderPoints" type="text" maxlength="50"  min="${request.product.currentPoints}" max="<s:property value="getText('{0,number,#}',{(#request.pointsUser.points-#request.pointsUser.points%#request.product.currentPoints)/#request.product.currentPoints})"/>"  value="${request.order.orderPoints}" /></td>
	           </tr>
	           <tr><td colspan="3"><div class="spacer15"></div></td></tr>
	           <tr>
	             <td><span class="param-title inlineBlock"><s:text name="bshare.shop.order.points.otherPoints"><s:param>${request.product.name}</s:param></s:text></span>：</td>
	             <td colspan="2"><input type="hidden" id="orderProdNum" name="order.prodNum"/><span id="otherPoints" class="text-blue">${request.order.prodNum}</td>
	           </tr>
	           <tr><td colspan="3"><div class="spacer15"></div></td></tr>
	           <tr>
	             <td><span class="param-title inlineBlock"><s:text name="bshare.shop.order.points.accountName"><s:param>${request.product.merchant.name}</s:param></s:text></span>：</td>
	             <td>
	                 <div style="overflow: hidden; zoom: 1; position: relative;">
	                     <label class="bSearch-hint" for="accountName"><span><s:text name="bshare.shop.order.points.pointsaccount"><s:param>${request.product.merchant.name}</s:param></s:text></span></label>
                         <input name="userAccount.accountName" id="accountName" type="text" maxlength="50" required="required"  value="${request.userAccount.accountName}"/>
	                 </div>
	             </td>
	             <td><s:text name="bshare.shop.order.points.points"><s:param>${request.product.merchant.name}</s:param><s:param>${request.product.merchant.name}</s:param></s:text></td>
	           </tr>
	        </table>
	    </div>
		<div class="spacer20 clear"></div>
		
	    <div class="separator spacer1"></div>
	    <div class="spacer20"></div>
	    <div class="wrapper-form center">
	        <button type="submit" class="exchange-button bButton-blue"><s:text name="bshare.points.to.exchange"/></button>
	    </div>
	    </form>
		<div class="spacer20 clear"></div>
	</div>
	
	<div id="activityList" class="container-activities right">
	    <%@ include file="/jsp/common/commActivities.jsp"%>
	</div>
	<div class="spacer20 clear"></div>
</div>
<%@ include file="/jsp/common/commError.jsp"%>
<script type="text/javascript" charset="utf-8">
var EXCHANGE_RATE = ${request.product.currentPoints};
function initPointInput() {
    var formatNumber = function (value) {
        value = value.replace(/[^\d]/g, "");
        if (!value) {
        	value = "0";
        }
        var current=${request.pointsUser.points};
        current = value>current?current:value;
        var exPoints = ((current-current%EXCHANGE_RATE)/EXCHANGE_RATE).toFixed();
        //value = exPoints*EXCHANGE_RATE;
        $("#otherPoints").text(exPoints);
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
function checkSubmit(){
	if (!$("#shipInfoForm").data("validator").checkValidity()) {
        return false;
    }
 	if($("#orderProdNum").val()*EXCHANGE_RATE!=$("#bSharePoint").val()){
		displayStatusMessage('<s:text name="bshare.field.error.mulitple"/>'.replace('{0}',EXCHANGE_RATE), "info");
		$("#bSharePoint").focus();
	    return false;
	} 
	if(!confirm("请确认是否把"+$("#bSharePoint").val()+"个微积分兑换成"+$("#orderProdNum").val()+"个${request.product.name}，并冲入账号"+$("#accountName").val()+"吗?\n 一旦确认后，出现帐号错误等问题，微积分概不负责。")){
		return false;
	}
	var result =1;
    $.ajax({
	    type: 'POST',
	    async:false,
	    url: '${points_cxt_path}/shop/order/pointsproductjs',
	    data:$("#shipInfoForm").serialize(),
	    success: function(results) {
	        if (!results.success) {
	        	$("#pointserror").html(results.contents.message);
	        	$("#errorDiv").data("overlay").load();
	        	$("#orderNo").val('');
            	result=2;
	        }
	    },
	    error: function() {
	    	displayStatusMessage('<s:text name="bshare.points.common.error"/>', "error");
	    	result=2;
	    }
	});
    if(result==2){
    	return false;
    }
	return true;
}
function switchInputContent(target) {
	if($(target).val() == '') {
        $(target).prev().css({"display": "block"});
    } else {
        $(target).prev().css({"display": "none"});
    }
}
$(function() {
    $('#accountName').focus(function() {
        $(this).prev().css({"display": "none"});
    }).blur(function() {
    	switchInputContent(this);
    });
    
    switchInputContent('#accountName');
});
$(document).ready(function () {
    initPointInput();
    $.tools.validator.localize('<s:text name="bshare.lang.code"/>', {
        '*'         : '<s:text name="bshare.field.error.general"/>',
        ':email'    : '<s:text name="bshare.field.error.email"/>',
        ':number'   : '<s:text name="bshare.field.error.number"/>',
        ':url'      : '<s:text name="bshare.field.error.url"/>',
        '[max]'     : '<s:text name="bshare.field.error.max"/>',
        '[min]'     : '<s:text name="bshare.field.error.min"/>',
        '[required]': '<s:text name="bshare.field.error.required"/>'
    });
    $("#shipInfoForm").validator({
        lang: '<s:text name="bshare.lang.code"/>',
        messageClass: 'errorInput',
        onFail: function() {
            isSubmitting = false;
            hideStatusMessage();
        }
    });
});
</script>
