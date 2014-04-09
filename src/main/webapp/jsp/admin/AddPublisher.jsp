<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.site.add"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<style>
    .div-gradient-linear-light { padding: 10px 20px; border-radius: 0 0 5px 5px; color: #666; }
    .wrapper-site { padding: 20px; font-size: 12px; display: block; overflow: hidden; position: relative; }
    .wrapper-site ul { list-style: none; }
    .wrapper-site input { width: 220px; margin-left: 0px; padding: 3px; 
        font-size: 12px; border-width: 1px; border-style: solid; border-color: #939393 #c8c8c8 #c8c8c8; height: 18px; }
    .wrapper-site input[disabled=disabled] { border: none; background-color: transparent; }
    .wrapper-site select { height: 28px; }
    .wrapper-site .help-popup-img { margin: 6px 10px 0 0; vertical-align: top; }
    .wrapper-site .bInputLabel { width: 80px; height: 26px; line-height: 26px; }
    .wrapper-site p { line-height: 200%; }
</style>

<div class="container-center">
	<div class="module-white-grey module-backend">
	    <s:form id="createSiteForm" name="createSiteForm" action="createPublisher"
	        method="POST" theme="simple" onsubmit="return verifyForm(this);">
	    <div class="div-gradient-linear-light heading3"><s:text name="bshare.points.admin.site.add" /></div>
	    <div class="wrapper-site">
	        <ul>
	            <li>
	                <span class="bInputLabel"><s:text name="bshare.points.admin.site.email" /></span>
	                <span title="<s:text name='bshare.points.admin.email.tip'/>" class="help-popup-img"></span>
	                <input id="email" name="email" type="email" maxlength=50 required="required" style="width:220px;" value="${email}" />
	            </li>
	        </ul>
		    <div class="clear spacer20"></div>
		    <div style="margin-left:112px;">
		        <button id="saveSiteButton" type="submit" class="bButton-blue" style="padding: 5px 30px; 
		            *padding: 2px 30px; margin-right: 20px;"><s:text name="bshare.points.save" /></button>
		        <a id="closeButton" class="bButton" style="padding: 5px 30px; *padding: 2px 30px;"
		            href="${points_cxt_path}/admin/publisher"><s:text name="bshare.points.cancel" /></a>
		    </div>
	    </div>
	    </s:form>
	    <div class="clear"></div>
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
            displayStatusMessage('<s:text name="bshare.points.admin.site.point.message"/>', "error");
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
    $("#saveSiteButton").html('<s:text name="bshare.points.wait"/>');
    return true;
}

$(document).ready(function () {
    $.tools.validator.localize('<s:text name="bshare.lang.code"/>', {
        '*'         : '<s:text name="bshare.field.error.general"/>',
        ':email'    : '<s:text name="bshare.field.error.email"/>',
        ':number'   : '<s:text name="bshare.field.error.number"/>',
        '[max]'     : '<s:text name="bshare.field.error.point.max2"/>',
        '[min]'     : '<s:text name="bshare.field.error.min"/>',
        '[required]': '<s:text name="bshare.field.error.required"/>'
    });

    $("#createSiteForm").validator({
        lang: '<s:text name="bshare.lang.code"/>',
        messageClass: 'errorInput',
        onFail: function() {
            isSubmitting = false;
            $("#saveSiteButton").text('<s:text name="bshare.points.save"/>');
            hideStatusMessage();
        }
    });
});
</script>
