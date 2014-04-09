<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/jsp/common/init.jsp"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<style type="text/css">
    #dialogTopup { position: fixed; _position: absolute; }
    #dialogTopup .body { *width: 470px; }
    #dialogTopup input { font-size: 18px; margin-right: 10px; padding: 3px; border-width: 1px; border-style: solid; border-color: #939393 #c8c8c8 #c8c8c8; }
    #dialogTopup .bInputLabel { width: 80px; font-size: 14px; line-height: 26px; }
    #dialogTopup span { line-height: 30px; }
    #dialogTopup .note { color: #999; font-weight: bold; padding: 0 10px; }
</style>

<div id="dialogTopup" class="bOverlay">
    <a class="close">X</a>
    <div class="body">
        <div class="clear spacer20"></div>
        <s:form id="topupForm" name="topupForm" method="POST" theme="simple" onsubmit="return verifyForm(this);"> 
	    <div style="border: 1px solid #e9e9e9; padding: 20px;">
	        <span class="bInputLabel"><s:text name="bshare.points.topup.points"/>：</span>
	        <input type="text" min=1 max=10000 name="points" value="0" style="width: 150px;" required="required" /><span> * 100<s:text name="bshare.points.point"/></span>
	        <div class="clear spacer10"></div>
	        <span class="bInputLabel"><s:text name="bshare.points.topup.cost"/>：</span>
	        <input name="cost" disabled="disabled" value="0" style="width: 150px;" /><span><s:text name="bshare.points.topup.currency"/></span>
	        <div class="clear spacer10"></div>
	        <span class="bInputLabel">手续费：</span><span class="bInputLabel">${poundageValue}%</span>
	        <div class="clear"></div>
	    </div>
	    <div class="clear spacer15"></div>
	    <button id="bButtonTopup" type="submit" class="bButton-blue right" style="padding: 5px 30px;"><s:text name="bshare.points.topup.pay.online"/></button>
	    </s:form>
	    <div class="clear spacer15"></div>
	    <div style="text-align: right; font-size: 12px; color: #666;"><s:text name="bshare.points.topup.pay.offline"/></div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
var isSubmitting = false;
function verifyForm(target) {
    if(isSubmitting) {
        return false;
    }
    hideStatusMessage();
    if (!$(target).data("validator").checkValidity()) {
        return false;
    }
    var valid = true;
    $("input:number").each(function() {
        if ($(this).val().replace(/[0-9]/g, "").length > 0 || $(this).val().indexOf("0") == 0) {
            displayStatusMessage('<s:text name="bshare.points.topup.message"/>', "error");
            $(this).focus();
            valid = false;
            return false;
        }
    });
    if (!valid) {
        return false;
    }
    isSubmitting = true;
    displayStatusMessage('<s:text name="bshare.points.wait"/>', "info");
    $("#bButtonTopup").html('<s:text name="bshare.points.wait"/>');
    $(target).attr("action", "${points_cxt_path}/order");
    return true;
}

$(document).ready(function () {
    $("#dialogTopup").overlay({
        top: '30%',
        mask: {
            color: '#e9e9e9',
            loadSpeed: 200,
            opacity: 0.5
        },
        closeOnClick: false,
        onLoad: function(e) {
            
        },
        onBeforeClose: function(e) {
            hideStatusMessage();
        }
    });
    $.tools.validator.localize('<s:text name="bshare.lang.code"/>', {
        '*'         : '<s:text name="bshare.field.error.general"/>',
        ':number'   : '<s:text name="bshare.field.error.number"/>',
        '[max]'     : '<s:text name="bshare.field.error.point.max3"/>',
        '[min]'     : '<s:text name="bshare.field.error.min"/>',
        '[required]': '<s:text name="bshare.field.error.required"/>'
    });

    $("#topupForm").validator({
        lang: '<s:text name="bshare.lang.code"/>',
        messageClass: 'errorInput',
        onFail: function() {
            isSubmitting = false;
            $("#bButtonTopup").text('<s:text name="bshare.points.topup.pay.online"/>');
            hideStatusMessage();
        }
    });
    
    $("input[name=points]").keyup(function() {
    	$(this).val($(this).val().replace(/[^\d]/g,''));
    	$("input[name=cost]").val(($(this).val() * ${poundage}).toFixed(2));
    });
    $(".close").click(function () {
        $(this).closest(".bOverlay").hide();
    });
});
</script>
