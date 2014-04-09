<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.shop.order.confirm"/> - <s:text name="bshare.points.title"/></title>

<style>
    .orderInfoTable, .orderInfoItemTable { width: 100%; border-collapse: collapse; text-align: left; font-size:12px;table-layout: fixed;}
    .orderInfoTable th, .orderInfoItemTable th { padding: 10px; border-bottom: 1px solid #f90; background: #ffeac0; text-align:left;}
    .orderInfoTable th { padding: 4px 10px; height: 26px; line-height: 26px; }
    .orderInfoItemTable th { background: #F2F6F9; }
    .orderInfoTable td, .orderInfoItemTable td { padding: 10px; border-bottom: 1px solid #eee; word-wrap:break-word; overflow:hidden;word-break:break-all;}
    .productPrice { font-family: Arial,宋体,sans-serif; }
    #priceTr td { background: #F2F6F9; }
    #discountedPriceTr td { background: #ddf8cc; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.shop.title"/></a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/shop/product/${request.product.id}">${request.product.name}</a>
	</div>
	<div class="clear spacer20"></div>
	<div class="module-white-grey module-backend div-shadow-5">
	    <div class="clear spacer20"></div>
	    <div style="padding:0 20px;">
	        <h1 class="heading1 text-blue">
	            <s:text name="bshare.shop.order.confirm" />
	        </h1>
	        <div class="spacer5 clear"></div>
	        <div style="color:#666;">
	            <s:text name="bshare.points.user.order.no" />:${request.order.orderNo}</div>
	    </div>
	    <div class="clear spacer20"></div>
	    <div class="div-gradient-light-top" style="height:20px;"></div>
	    <div style="padding:0 20px;">
	        <div class="spacer20"></div>
	        <form id="orderInfoForm" name="orderInfo" method="POST" action="${points_cxt_path}/shop/order/<s:if test="#request.product.lottery">lottery</s:if>confirm">
	            <input type="hidden" id="productId" name="order.productId" value="${request.product.id}"/>
	        	<input type="hidden" id="productNum" name="order.prodNum" value="${request.order.prodNum}"/>
	        	<input type="hidden" id="productNum" name="order.orderNo" value="${request.order.orderNo}"/>
	        	<input id="name" name="pointsUser.contactName" type="hidden" value="${request.pointsUser.contactName}"/>
	        	<input id="mobile"name="pointsUser.contactNo" type="hidden" value="${request.pointsUser.contactNo}"/>
	        	<input id="state" name="pointsUser.state" type="hidden" value="${request.pointsUser.state}"/>
	        	<input id="city" name="pointsUser.city" type="hidden" value="${request.pointsUser.city}"/>
	        	<input id="address" name="pointsUser.contactAddress" type="hidden" value="${request.pointsUser.contactAddress}"/>
	        	<input id="postcode" name="pointsUser.zipCode" type="hidden" value="${request.pointsUser.zipCode}"/>
	            <table class="orderInfoTable mp0">
	                <tr>
	                    <th class="heading3" style="width:20%">
	                        <s:text name="bshare.shop.order.confirm.detail" />
	                    </th>
	                    <th style="width:80%">
	                    </th>
	                </tr>
	                <tr>
	                    <td class="heading3">
	                        <s:text name="bshare.shop.order.confirm.product" />
	                    </td>
	                    <td>
	                        <table class="orderInfoItemTable bTablePlain">
	                            <tr>
	                                <th style="width:25%"><s:text name="bshare.points.admin.product.name"/></th>
	                                <th style="width:25%">
	                                    <s:text name="bshare.points.admin.product.price" />
	                                </th>
	                                <th style="width:25%">
	                                    <s:text name="bshare.points.admin.product.initial.num" />
	                                </th>
	                                <th style="width:25%">
	                                    <s:text name="bshare.points.admin.product.current.num" />
	                                </th>
	                            </tr>
	                            <tr>
	                                <td><span title="${request.product.desc}"><a href="${points_cxt_path}/shop/product/${request.product.id}">${request.product.name}</a></span></td>
	                                <td>￥${request.product.priceMarketValue}</td>
	                                <td>${request.product.initialPoints}</td>
	                                <td>${request.product.currentPoints}</td>
	                            </tr>
	                        </table>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="heading3">
	                        <s:text name="bshare.shop.order.confirm.points" />
	                    </td>
	                    <td>
	                        <table class="orderInfoItemTable">
	                            <tr>
	                                <th style="width:25%"><s:text name="bshare.shop.order.confirm.points.productnum"/></th>
	                                <th style="width:25%"><s:text name="bshare.shop.order.confirm.points.orderpoints" /></th>
	                                <th style="width:25%"><s:text name="bshare.shop.order.confirm.points.userpoints" /></th>
	                                <th style="width:25%"><s:text name="bshare.shop.order.confirm.points.endpoints" /></th>
	                            </tr>
	                            <tr>
	                                <td>${request.order.prodNum}</td>
	                                <td>${request.order.orderPoints}</td>
	                                <td>${request.pointsUser.points}</td>
	                                <td>${request.pointsUser.points-request.order.orderPoints}</td>
	                            </tr>
	                        </table> 
	                    </td>
	                </tr>
	                <s:if test="!#request.product.lottery">
	                <tr>
	                    <td class="heading3">
	                        <s:text name="bshare.shop.order.confirm.contact" />
	                    </td>
	                    <td>
	                        <table class="orderInfoItemTable">
	                            <tr>
	                                <th style="width:25%"><s:text name="bshare.points.user.order.contactname"/></th>
	                                <th style="width:25%"><s:text name="bshare.points.user.order.contactno" /></th>
	                                <th style="width:25%"><s:text name="bshare.points.user.order.contactaddress" /></th>
	                                <th style="width:25%"><s:text name="bshare.points.user.order.zipcode" /></th>
	                            </tr>
	                            <tr>
	                                <td>${request.order.contactName}</td>
	                                <td>${request.order.contactNo}</td>
	                                <td>${request.order.contactAddress}</td>
	                                <td>${request.order.zipCode}</td>
	                            </tr>
	                        </table>
	                    </td>
	                </tr>
	                </s:if>
	            </table>
	            <div class="clear spacer20"></div>
	            <div style="text-align: right; font-size: 12px;"><input id="agreeTerms" type="checkbox" checked style="vertical-align: middle; margin-right: 10px;" /><label 
	                style="vertical-align: middle;">我已阅读并同意&nbsp;<a class="bLinkBlue" href="${points_cxt_path}/terms" 
	                target="_blank"><s:text name="bshare.points.title"/><s:text name="bshare.points.service"/></a></label></div>
                <div class="clear spacer20"></div>
	            <div style="text-align:center;">
	                <button id="saveButton" type="submit" class="bButton-blue" style="padding: 5px 30px; *padding: 2px 30px; margin-right: 20px; color: #fff;">
	                    <s:text name="bshare.shop.order.confirm.button" /></button>
	            </div>
	        </form>
	        <div class="clear spacer20"></div>
	    </div>
	    <div class="clear spacer20"></div>
	    <div class="div-gradient-light-top" style="height:20px;"></div>
	    <div class="clear spacer20"></div>
	</div>
</div>
            
<script type="text/javascript" charset="utf-8">
$(function () {
	$("#agreeTerms").click(function () {
		if (!!$(this).attr("checked")) {
			$("#saveButton").removeClass("bButton").addClass("bButton-blue").css({"color": "#fff"}).removeAttr("disabled").click(function () {
                $("#orderInfoForm").submit();
            });
		} else {
			$("#saveButton").addClass("bButton").removeClass("bButton-blue").css({"color": "#999"}).attr("disabled", "disabled").click(function () {
				return false;
			});
		}
	});
});
</script>
