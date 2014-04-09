<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.checkout.confirm"/> - <s:text name="bshare.points.title"/></title>

<style>
    .orderInfoTable, .orderInfoItemTable { width: 100%; border-collapse: collapse; text-align: left; }
    .orderInfoTable th, .orderInfoItemTable th { padding: 10px; border-bottom: 1px solid #f90; background: #ffeac0; }
    .orderInfoTable th { padding: 4px 10px; height: 26px; line-height: 26px; }
    .orderInfoItemTable th { background: #F2F6F9; }
    .orderInfoTable td, .orderInfoItemTable td { padding: 10px; border-bottom: 1px solid #eee; }
    .productPrice { font-family: Arial,宋体,sans-serif; }
    #priceTr td { background: #F2F6F9; }
    #discountedPriceTr td { background: #ddf8cc; }
</style>

<div class="container-center">
	<div class="module-white-grey module-backend div-shadow-5">
	    <div class="clear spacer20"></div>
	    <div style="padding:0 20px;">
	        <h1 class="heading1 text-blue"><s:text name="bshare.points.checkout.confirm" /></h1>
	        <div class="spacer5 clear"></div>
	        <div style="color:#666;">
	            <s:text name="bshare.points.order.order.no" />${request.orderInfo.tradeNo}</div>
	    </div>
	    <div class="clear spacer20"></div>
	    <div class="div-gradient-light-top" style="height:20px;"></div>
	    <div style="padding:0 20px;">
	        <div><s:text name="bshare.points.checkout.top" /></div>
	        <div class="spacer5 clear"></div>
	        <div>
	            <p><s:text name="bshare.points.checkout.top.note" /></p>
	        </div>
	        <div class="spacer20"></div>
	        <form id="orderInfoForm" name="orderInfo" action="${points_cxt_path}/checkout">
	            <input type="hidden" id="paymentOrderInfoId" name="paymentOrderInfoId"
	            value="${request.orderInfo.id}" />
	            <input type="hidden" id="paygateId" name="paygateId" value="" />
	            <table class="orderInfoTable mp0">
	                <tr>
	                    <th class="heading3" style="vertical-align:middle;">
	                        <s:text name="bshare.points.checkout.order.no" />
	                    </th>
	                    <th>
	                        <div class="left floatFix">${request.orderNo}</div>
	                        <div class="right floatFix" style="padding:5px;border:1px solid #bbb;background:#eee;height:16px;line-height:16px;">
	                            <a target="_blank" href="mailto:vipsales@${bshareDomain}" class="bLink"
	                            style="font-weight:normal;"><s:text name="bshare.points.checkout.need.receipt"/></a>
	                        </div>
	                    </th>
	                </tr>
	                <tr>
	                    <td class="heading3"><s:text name="bshare.points.checkout.order.time" /></td>
	                    <td>
	                        <s:text name="bshare.points.number.format"><s:param value="%{#request.orderInfo.createTime}" /></s:text>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="heading3">
	                        <s:text name="bshare.points.checkout.order.details" />
	                    </td>
	                    <td>
	                        <table class="orderInfoItemTable">
	                            <tr>
	                                <th>&nbsp;</th>
	                                <th align="center"><s:text name="bshare.points.order.points" /></th>
	                                <th align="right"><s:text name="bshare.points.order.total" /></th>
	                            </tr>
	                            <tr>
	                                <td><s:text name="bshare.points.topup.name" /></td>
	                                <td align="center">
	                                    <s:text name="bshare.points.number.format"><s:param value="%{#request.orderInfo.points}" /></s:text>
	                                </td>
	                                <td align="right" class="productPrice">￥<s:text name="bshare.points.number.format">
	                                        <s:param value="%{#request.orderInfo.amountValue}" /></s:text>
	                                </td>
	                            </tr>
	                        </table>
	                    </td>
	                </tr>
	                <tr id="discountedPriceTr">
	                    <td class="heading3"><s:text name="bshare.points.order.total.price" /></td>
	                    <td class="productPrice" style="font-size:18px;">
	                        <strong>￥<s:text name="bshare.points.number.format"><s:param value="%{#request.orderInfo.amountValue}" /></s:text>
	                        </strong>
	                    </td>
	                </tr>
	                <tr style="border-bottom:2px solid #ddd;">
	                    <td class="heading3"><s:text name="bshare.points.checkout.payment.status" /></td>
	                    <td>
	                        <s:if test="%{#request.orderInfo.tradeStatus == @com.buzzinate.bshare.points.bean.enums.TradeStatus@SUCCESS}">
	                            <font style="color:green;"><s:text name="bshare.points.checkout.payment.complete" /></font>
	                        </s:if>
	                        <s:elseif test="%{#request.orderInfo.tradeStatus == @com.buzzinate.bshare.points.bean.enums.TradeStatus@WAITPAY}">
	                            <font style="color:#ff5c00;">
	                                <s:text name="bshare.points.checkout.payment.waiting" />
	                            </font>
	                        </s:elseif>
	                        <s:else>
	                            <font style="color:red;"><s:text name="bshare.points.checkout.payment.failed" /></font>(
	                            <s:text name="bshare.points.order.fail.note" />)</s:else>
	                    </td>
	                </tr>
	            </table>
	        </form>
	        <div class="clear spacer20"></div>
	        <div>
	            <p><s:text name="bshare.points.checkout.bottom.note" /></p>
	        </div>
	        <div class="clear spacer20"></div>
	        <div>
	            <div style="text-align:center;">
	                <span class="heading3"><s:text name="bshare.points.checkout.bottom.note2" /></span>
	                <br /><br />
	                <a class="submitPayButton" onclick="javascript:gotoPaygate('1');return false;"
	                    href="javascript:;"><img src="${image_path}/paygate/alipay_logo.gif"></a>
	            </div>
	        </div>
	    </div>
	    <div class="clear spacer20"></div>
	    <div class="div-gradient-light-top" style="height:20px;"></div>
	    <div class="clear spacer20"></div>
	</div>
</div>
            
<script type="text/javascript" charset="utf-8">
    var isSubmitting = false;
    function gotoPaygate(paygateId) {
        if (isSubmitting) return false;
        
        $("#paygateId").val(paygateId);

        $(".submitPayButton").attr("onclick", ""); //disable from submitting twice
        $("#orderInfoForm").submit();
    }
</script>
