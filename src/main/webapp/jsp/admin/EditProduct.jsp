<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:text name="bshare.points.admin.product.edit"/> - <s:text name="bshare.points.admin"/> - <s:text name="bshare.points.title"/></title>

<style>
    .div-gradient-linear-light { padding: 10px 20px; border-radius: 0 0 5px 5px; color: #666; }
    .wrapper-product { padding: 5px 20px 20px; font-size: 12px; }
    .wrapper-product .param-div { margin: 15px 0; }
    .wrapper-product .bInput,  .wrapper-product textarea, .wrapper-product select { width: 220px; margin-left: 0px; padding: 3px; 
        font-size: 12px; border-width: 1px; border-style: solid; border-color: #939393 #c8c8c8 #c8c8c8; height: 18px; }
    .wrapper-product textarea { height: 122px; }
    .wrapper-product select { width: 228px; height: 28px; }
    .wrapper-product .help-popup-img { margin: 6px 10px 0 0; vertical-align: top; }
    .wrapper-product .bInputLabel { width: 80px; height: 26px; line-height: 26px; }
    .wrapper-product p { line-height: 200%; }
    
    #imageFileUpload { height: 28px; width: 100px; }
    #message { height: 15px; line-height: 15px; }
    #showImage { display: none; border: 1px solid #ddd; width: 300px; height: 300px; }
</style>

<div class="container-center">
	<div class="module-white-grey module-backend container-product">
	    <s:form id="createProductForm" name="createProductForm" action="updateProduct"
	        method="POST" theme="simple" onsubmit="return verifyForm(this);">
	    <div class="div-gradient-linear-light heading3"><s:text name="bshare.points.admin.product.edit" /></div>
	    <div class="wrapper-product">
	        <input type="hidden" id="id" name="id" value="${pointsProduct.id}">
	        <div class="left" style="width:430px;*width:410px;">
		        <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.name" /></span>
	                <span title="<s:text name='bshare.points.admin.product.name.tip'/>" class="help-popup-img"></span>
	                <input id="name" name="name" class="bInput" type="text" maxlength=50 required="required" style="width:220px;" value="${pointsProduct.name}" />
	            </div>
	            <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.desc" /></span>
	                <span title="<s:text name='bshare.points.admin.product.desc.tip'/>" class="help-popup-img"></span>
	                <textarea id="desc" name="desc" type="text" maxlength=400 style="width:220px;" onblur="this.value = this.value.substr(0,400);">${pointsProduct.desc}</textarea>
	            </div>
		        <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.desc.url" /></span>
	                <span title="<s:text name='bshare.points.admin.product.desc.url.tip'/>" class="help-popup-img"></span>
	                <input id="descUrl" name="descUrl" class="bInput" type="url" maxlength=200 value="${pointsProduct.descUrl}" />
	            </div>	            
	            <div class="param-div">
	                <span class="bInputLabel" style="height: 28px; line-height: 28px;"><s:text name="bshare.points.admin.product.category" /></span>
	                <span title="<s:text name='bshare.points.admin.product.category.tip'/>" class="help-popup-img"></span>
	                <s:select list="%{#request.categorySelector}" id="prodCate" name="prodCate"></s:select>
	            </div>
	            <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.pic" /></span>
	                <span title="<s:text name='bshare.points.admin.product.pic.tip'/>" class="help-popup-img"></span>
	                <input id="picUrl" name="picUrl" class="bInput" type="text" maxlength=150 value="${pointsProduct.picUrl}" readonly="readonly" />
	                <input id="pic" name="pic" class="bInput" type="hidden" />
	            </div>
	            <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.brand" /></span>
	                <span title="<s:text name='bshare.points.admin.product.brand.tip'/>" class="help-popup-img"></span>
	                <input id="brand" name="brand" class="bInput" type="text" maxlength=100 value="${pointsProduct.brand}" />
	            </div>
	            <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.tags" /></span>
	                <span title="<s:text name='bshare.points.admin.product.tags.tip'/>" class="help-popup-img"></span>
	                <input id="tags" name="tags" class="bInput" type="text" maxlength=100 value="${pointsProduct.tags}" />
	            </div>
	            <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.price" /></span>
	                <span title="<s:text name='bshare.points.admin.product.price.tip'/>" class="help-popup-img"></span>
	                <input id="priceMarketValue" name="priceMarketValue" class="bInput" type="number" min="0.01" max="1000000"
	                    maxlength=250 required="required" style="width:220px;" value="${pointsProduct.priceMarketValue}" />
	            </div>
	            <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.store.num" /></span>
	                <span title="<s:text name='bshare.points.admin.product.store.num.tip'/>" class="help-popup-img"></span>
	                <input id="storeNum" name="storeNum" class="bInput" type="number" min="-1" max="1000000"
	                    maxlength=250 required="required" value="${pointsProduct.storeNum}"/>
	                <span style="vertical-align:middle;"><input style="vertical-align:middle;margin:0 3px 3px;" type="checkbox" id="unlimited" name="unlimited" value="true"/>无限库存</span>
	            </div>		            
	            <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.initial.num" /></span>
	                <span title="<s:text name='bshare.points.admin.product.initial.num.tip'/>" class="help-popup-img"></span>
	                <input id="initialPoints" name="initialPoints" class="bInput" type="number" maxlength=250 min="1" required="required" 
	                    style="width:220px;" onblur="this.value=this.value>0?this.value:0;"  value="${pointsProduct.initialPoints}" />
	            </div>
	            <div class="param-div">
	                <span class="bInputLabel"><s:text name="bshare.points.admin.product.current.num" /></span>
	                <span title="<s:text name='bshare.points.admin.product.current.num.tip'/>" class="help-popup-img"></span>
	                <input id="currentPoints" name="currentPoints" class="bInput" type="number" maxlength=250 min="1" required="required" style="width:220px;" 
	                    onblur="this.value=this.value>0?this.value:0;" value="${pointsProduct.currentPoints}" />
	            </div>
	            <div class="param-div">
	                <span class="bInputLabel" style="height: 28px; line-height: 28px;"><s:text name="bshare.points.admin.product.merchant" /></span>
	                <span title="<s:text name='bshare.points.admin.product.merchant.tip'/>" class="help-popup-img"></span>
	                <s:select list="%{#request.merchantSelector}" id="merchantId" name="merchantId"></s:select>
	            </div>
	            <div class="param-div">
	                <span class="bInputLabel" style="height: 28px; line-height: 28px;"><s:text name="bshare.points.admin.product.status" /></span>
	                <span title="<s:text name='bshare.points.admin.product.status.tip'/>" class="help-popup-img"></span>
	                <select id="productStatusValue" name="productStatusValue">
	                    <option value="1"><s:text name="bshare.points.admin.product.status.active" /></option>
	                    <option value="2"><s:text name="bshare.points.admin.product.status.inactive" /></option>
	                    <option value="3"><s:text name="bshare.points.admin.product.status.perfered" /></option>
	                </select>
	            </div>
	        </div>
	        <div class="left">
	            <div class="clear spacer10"></div>
	            <span class="bInputLabel" style="height:28px;line-height:28px;">产品图片：</span>
	            <input type="button" id="imageFileUpload" value="上传" />
	            <div class="clear spacer5"></div>
	            <p class="field-tip">只接受 JPEG和 PNG格式，小于50K，规格符合300px*300px.</p>
	            <div class="clear spacer5"></div>
	            <div id="message" class="text-red"></div>
	            <div class="clear spacer15"></div>
	            <div id="showImage"></div>
	            <div class="clear spacer15"></div>
	        </div>
	        <div class="clear spacer5"></div>
	        <div style="margin-left:112px;">
	            <button id="saveButton" type="submit" class="bButton-blue" style="padding: 5px 30px; *padding: 2px 30px; margin-right: 20px;">
	                <s:text name="bshare.points.save" /></button>
	            <a id="closeButton" class="bButton" style="padding: 5px 30px; *padding: 2px 30px;"
	                href="${points_cxt_path}/admin/product"><s:text name="bshare.points.cancel" /></a>
	        </div>
	    </div>
	    </s:form>
	    <div class="clear"></div>
	</div>
</div>

<script type="text/javascript" charset="utf-8" src="${js_path}/libs/ajaxupload.js"></script>
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
    isSubmitting = true;
    displayStatusMessage('<s:text name="bshare.points.wait"/>', "info");
    $("#saveSiteButton").html('<s:text name="bshare.points.wait"/>');
    return true;
}
$(function() {
	$("#unlimited").click(function() {
        if ($("#unlimited").is(":checked")) {
            $("#storeNum").removeAttr("required");
            $("#storeNum").attr("min", "-1");
            $("#storeNum").attr("disabled", "disabled");
            $("#storeNum").val("");
        } else {
            $("#storeNum").attr("required", "required");
            $("#storeNum").attr("min", "1");
            $("#storeNum").removeAttr("disabled");
            $("#storeNum").val("0");
        }
    });
	
    $.tools.validator.localize('<s:text name="bshare.lang.code"/>', {
        '*'         : '<s:text name="bshare.field.error.general"/>',
        ':email'    : '<s:text name="bshare.field.error.email"/>',
        ':number'   : '<s:text name="bshare.field.error.number"/>',
        ':url'      : '<s:text name="bshare.field.error.url"/>',
        '[max]'     : '<s:text name="bshare.field.error.point.max2"/>',
        '[min]'     : '<s:text name="bshare.field.error.min"/>',
        '[required]': '<s:text name="bshare.field.error.required"/>'
    });

    $("#createProductForm").validator({
        lang: '<s:text name="bshare.lang.code"/>',
        messageClass: 'errorInput',
        onFail: function() {
            isSubmitting = false;
            $("#saveButton").text('<s:text name="bshare.points.save"/>');
            hideStatusMessage();
        }
    });
    if ('${pointsProduct.storeNum}' == -1) {
        $('#unlimited').attr("checked",true);
        $("#storeNum").removeAttr("required");
        $("#storeNum").attr("min", "-1");
        $("#storeNum").attr("disabled", "disabled");
        $("#storeNum").val("");
    } else {
    	$("#storeNum").attr("required", "required");
        $("#storeNum").attr("min", "1");
        $("#storeNum").removeAttr("disabled");
    }
    $('#productStatusValue').val('${pointsProduct.productStatusValue}');
    $('#prodCate').val('${pointsProduct.prodCate}');
    $('#merchantId').val('${pointsProduct.merchantId}');
    $("#showImage").html("<img src='"+ "${pointsProduct.picUrl}" +"'/>").show();
    unescapeInner("desc");
});

$(document).ready(function () {
    // create image file uploader:
    var currentImageFile = "";
    new AjaxUpload('#imageFileUpload', { 
        action: '${points_cxt_path}/uploadFile?type=points_product', autoSubmit: true, name: 'tempFile', responseType: "json",
        onChange: function(file, extension){},
        onSubmit: function(file, extension) {
            hideStatusMessage();
            $("#message").empty().html("");
            if (!(extension && /^(jpg|png|jpeg)$/i.test(extension))){
                displayStatusMessage('<s:text name="bshare.create.invalid.image.file"/>', "error");
                return false; // cancel upload
            }
            this.setData({
                'fileName': file,
                'fileExtension': extension
            });
        },
        onComplete: function(file, response) {
            if(response.success) {
                var imgUrl = response.contents.url;
                var msg = response.contents.msg;
                var filename = response.contents.filename;
                $("#showImage").html("<img src='"+ imgUrl +"'/>").show();
                $("#pic").val(filename);
                $("#message").empty().html("");
            } else {
                var msg = response.message;
                displayStatusMessage(msg, "error");
                $("#message").html(msg);
            }  
        }
    });
});
</script>
