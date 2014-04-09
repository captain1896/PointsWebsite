<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.deposit"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<style>
    .div-gradient-linear-light { padding: 10px 20px; border-radius: 0 0 5px 5px; color: #666; }
    .wrapper-topup { padding: 20px; position: relative; }
    .wrapper-topup input { height: 28px; margin-left: 0px; padding: 3px; border-width: 1px; border-style: solid; border-color: #939393 #c8c8c8 #c8c8c8; background-color: transparent; }
    .wrapper-topup .help-popup-img { margin: 6px 10px 0 0; vertical-align: top; }
    .wrapper-topup .bInputLabel { width: 80px; height: 28px; line-height: 28px; }
</style>

<div class="container-center">
	<%@ include file="/jsp/common/leftMenu.jsp" %>
	
	<div class="container-right">
	    <div class="module-white-grey module-backend">
	        <div class="div-gradient-linear-light text-blue heading3 div-rounded-bottom-5"><s:text name="bshare.points.admin.topup.title" /></div>
	        <div class="clear"></div>
	        <div class="wrapper-topup">
	            <s:form id="topupForm" name="topupForm" action="topup" method="POST" theme="simple"
	            onsubmit="return verifyForm(this);">
	                <div>
	                    <span class="bInputLabel"><s:text name="bshare.points.admin.topup.email" /></span>
	                    <span title="<s:text name='bshare.points.admin.email.tip'/>" class="help-popup-img"></span>
	                    <input type="email" name="email" value="${email}" required="required"
	                    maxlength="30" class="bTextbox24 bUsername" style="width:300px;" />
	                </div>
	                <div class="spacer15"></div>
	                <div>
	                    <span class="bInputLabel"><s:text name="bshare.points.admin.topup.points" /></span>
	                    <span title="<s:text name='bshare.points.admin.topup.points.tip'/>" class="help-popup-img"></span>
	                    <input type="number" min=100 max=1000000 name="points" value="${points}"
	                    class="bTextbox24" style="width:300px;" />
	                </div>
		            <div class="clear spacer20"></div>
                    <button id="bButtonTopup" type="submit" class="bButton-blue" style="padding: 5px 30px;margin-left:113px;">
                        <s:text name="bshare.points.admin.topup.button" />
                    </button>
	            </s:form>
	        </div>
	        <div class="clear"></div>
	    </div>
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
            displayStatusMessage('<s:text name="bshare.points.admin.site.topup.message"/>', "error");
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
    $("#updateActivityButton").html('<s:text name="bshare.points.wait"/>');
    return true;
}

$(document).ready(function () {
    $.tools.validator.localize('<s:text name="bshare.lang.code"/>', {
        '*'         : '<s:text name="bshare.field.error.general"/>',
        ':number'   : '<s:text name="bshare.field.error.number"/>',
        ':email'    : '<s:text name="bshare.field.error.email"/>',
        ':url'      : '<s:text name="bshare.field.error.url"/>',
        '[max]'     : '<s:text name="bshare.field.error.point.max2"/>',
        '[min]'     : '<s:text name="bshare.field.error.min"/>',
        '[required]': '<s:text name="bshare.field.error.required"/>'
    });

    $("#topupForm").validator({
        lang: '<s:text name="bshare.lang.code"/>',
        messageClass: 'errorInput',
        onFail: function() {
            isSubmitting = false;
            $("#bButtonTopup").text('<s:text name="bshare.points.admin.topup.button"/>');
            hideStatusMessage();
        }
    });
    
});
</script>
