<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<sec:authorize ifNotGranted="ROLE_ANONYMOUS">
	<%response.sendRedirect("loginAction"); %>
</sec:authorize>

<title><s:text name="bshare.points.login"/> - <s:text name="bshare.points.title"/></title>

<style>
	.connectButton {cursor:pointer;margin-right:10px;}
</style>

<div class="container-center">
	<div class="clear spacer30"></div>
	
	<div class="module-white-grey module-full div-shadow-5" style="width:600px;padding:0;margin-left:190px;">
		<div class="div-rounded-top-5" style="padding:15px 20px;background:#e8e8e8;color:#666;">
			<div class="left" style="font-size:18px;"><s:text name="bshare.points.login"/></div>
			<!-- 
			<div class="right" style="margin-top:4px;"><s:text name="bshare.points.no.account"/><a href="${cxt_path}/register" class="bLinkU" style="color:#f60;"><s:text name="bshare.points.register"/></a></div>
			 -->
			<div class="clear"></div>
		</div>
		
		<div class="clear"></div>
		
		<s:form cssClass="mp0" id="loginActionPage" name="loginAction" action="authentication" method="POST" theme="simple" onsubmit="return loginSubmit();">
			<fieldset>
				<div class="clear spacer20"></div>
					
				<s:if test="%{#session.SPRING_SECURITY_SAVED_REQUEST_KEY.getRequestURL().indexOf('/newOrder') != -1}">
					<div class="div-rounded-5 warningMessage" style="height:40px;font-size:12px;border:1px solid red;background:#FFD9D9;padding:10px;margin:0 20px;">
						<p><s:text name="bshare.points.cart.must.login"/></p>
						<div class="clear"></div>
					</div>
					<div class="clear spacer10"></div>
				</s:if>
				
				<div id="login-messages-div" class="hidden" style="text-align:center;padding:5px;color:red;background:#FFF8CC;margin:0 10px;">
				    <s:actionerror cssClass="action-error-messages"/>
				    <s:actionmessage cssClass="action-messages"/>
				    <s:fielderror cssClass="field-error-messages"/>
				    <div class="clear"></div>
				</div>
			    
			    <div class="clear spacer20"></div>
				<div>
					<div class="bInputLabel" style="width:200px;line-height:30px;color:#666;"><s:text name="bshare.points.username"/>
					<span title="<s:text name="bshare.points.login.help.username"/>" class="help-popup-img"></span>
					</div>
					<input type="text" required="required" maxlength="30" id="j_username" 
						name="j_username" class="bTextbox24 bUsername" style="width:200px;height:30px;border:1px solid #999;" value="${request.userName}" tabindex="1" 
						title='<s:text name="bshare.points.username.alt"/>' placeholder='<s:text name="bshare.points.username.alt"/>'/>
				</div>
				<div class="spacer20"></div>
				<div>
					<div class="bInputLabel" style="width:200px;line-height:30px;color:#666;"><s:text name="bshare.points.password"/>
					<span title="<s:text name="bshare.points.login.help.password"/>" class="help-popup-img"></span>
					</div>
					<input type="password" required="required" maxlength="30" id="password" name="password" class="bTextbox24" style="width:200px;height:30px;border:1px solid #999;" value="" tabindex="2"/>
				</div>
				<div class="spacer20"></div>
				<div>
					<div class="left" style="width:208px;">&nbsp;</div>
			      	<input type="checkbox" id="rememberMe" name="rememberMe" value="true" tabindex="3" checked/>
			      	<span style="color:#666;"><s:text name="bshare.points.remember.me"/></span>
			      	
			      	<span style="border-left:1px solid #666;margin:0 10px;"></span>
			      	
			      	<a class="bLinkU" href="${cxt_path}/forgotPassword"><s:text name="bshare.points.login.forgot.password.link"/>?</a>
				</div>
				
				<s:hidden id="loginType" name="loginType" value="1"/>
				<s:hidden name="prevActionUrl" value="%{#request.prevActionUrl}"></s:hidden>
				<s:hidden name="prevQueryString" value="%{#request.prevQueryString}"></s:hidden>
				<s:hidden id="j_password" cssClass="j_password" name="j_password" value=""/>
				
				<div class="spacer20"></div>
				<div style="width:205px;float:left;">&nbsp;</div>
				<div style="float:left;"><button class="bButton-blue" style="font-weight:bold;padding:6px 20px;width:130px;" type="submit" tabindex="4"><s:text name="bshare.points.login"/></button></div>
			</fieldset>
		</s:form>
		<!-- 
		<div class="clear spacer30" style="border-bottom:1px solid #aaa;margin:0 20px;"></div>
		<div class="clear spacer30"></div>
		
		<div style="padding:0 20px;">
			<div class="heading4 text-blue"><s:text name="bshare.points.oauth.connect"/></div>
			<div class="spacer20"></div>
			
			<img id="qzone_login_image" class="connectButton qzone_login_image" src="${image_path}/connector/qzone.gif" alt=""/>
			<img id="xn_login_image" class="connectButton xn_login_image" src="${image_path}/connector/renren1.gif" alt=""/>
			<img id="kaixin_login_image" class="connectButton kaixin_login_image" src="${image_path}/connector/kaixin001.gif" alt=""/>
			<img id="tencent_login_image" class="connectButton tencent_login_image" src="${image_path}/connector/tencent.gif" alt=""/>
	
			<div class="clear spacer5"></div>
	
			<img id="sina_login_image" class="connectButton sina_login_image" src="${image_path}/connector/sina.gif" alt=""/>
			<img id="sohu_login_image" class="connectButton sohu_login_image" src="${image_path}/connector/sohu.gif" alt=""/>
			<img id="netease_login_image" class="connectButton netease_login_image" src="${image_path}/connector/netease.gif" alt=""/>
			<img id="tianya_login_image" class="connectButton tianya_login_image" src="${image_path}/connector/tianya.gif" alt=""/>
			<div class="clear spacer5"></div>
			<img id="taobao_login_image" class="connectButton taobao_login_image" src="${image_path}/connector/taobao.gif" alt=""/>
			<div class="clear"></div>
		</div>
		 -->
		<div class="clear spacer40"></div>
	</div>
	
	<div class="clear spacer10"></div>
</div>

<script type="text/javascript" charset="utf-8" src="${jqueryToolsFormsSrc}"></script>
<script type="text/javascript" charset="utf-8" src="${js_path}/libs/webtoolkit.sha1.js"></script>
<!-- SCRIPTS-START -->
<script type="text/javascript" charset="utf-8">
function loginOauth(type) {
	window.location.href = BSHARE_WEBSITE_HOST + "loginByOauth?accountType=" + type;
	return false;
}

<sec:authorize ifNotGranted="ROLE_USER,ROLE_UNVERIFIED">
function kx001_onlogin() {
	if (typeof oauthLoginSuccessAjax == "function") {
		return oauthLoginSuccessAjax("KAIXIN", "-");
	}
	window.location.href = 'loginAction';
} 
   </sec:authorize>

function oauthLoginSuccess(type) {
	window.location.href = "loginAction";
}

$(function() {
	$(".sina_login_image").click(function(){return loginOauth("SINA");});
   	$(".douban_login_image").click(function(){return loginOauth("DOUBAN");});
   	$(".sohu_login_image").click(function(){return loginOauth("SOHU");});
   	$(".netease_login_image").click(function(){return loginOauth("NETEASE");});
   	$(".tencent_login_image").click(function(){return loginOauth("TENCENT");});	
	$(".xn_login_image").click(function(){return loginOauth("RENREN");});
   	$(".qzone_login_image").click(function(){return loginOauth("QZONE");});
   	$(".kaixin_login_image").click(function(){return loginOauth('KAIXIN');});
    $(".taobao_login_image").click(function(){return loginOauth('TAOBAO');});
    $(".tianya_login_image").click(function(){return loginOauth('TIANYA');});
});
</script>
<script type="text/javascript" charset="utf-8">
function loginSubmit() {
	$("#login-messages-div").hide();
	hideStatusMessage();
	
	if ($('#password').val() == "" || $("#j_username").val() == '<s:text name="bshare.points.username.alt"/>' || $("#j_username").val() == "") {
		// user didn't enter password or username... 
		// call checkValidity to display error:
		$("#loginActionPage").data("validator").checkValidity();
		return false;
	}
	
	// encrypt the password for sending:
	var pw = SHA1($('#password').val());
	// set password to meaningless string so real clear password isn't sent in request
	$('#password').val("3gfds532");
	$('.j_password').val(pw);
	return true;
}

$(function() {
	$.tools.validator.localize('<s:text name="bshare.lang.code"/>', {
		'*'			: '<s:text name="bshare.field.error.general"/>',
		':email'  	: '<s:text name="bshare.field.error.email"/>',
		':number' 	: '<s:text name="bshare.field.error.number"/>',
		':url' 		: '<s:text name="bshare.field.error.url"/>',
		'[max]'	 	: '<s:text name="bshare.field.error.max"/>',
		'[min]'		: '<s:text name="bshare.field.error.min"/>',
		'[required]': '<s:text name="bshare.field.error.required"/>'
	});

	$("#loginActionPage").validator({
		lang: '<s:text name="bshare.points.lang.code"/>',
		messageClass: 'errorInput',
		onBeforeValidate: function(e) {
			// check if user entered username:
			if ($("#j_username").val() == '<s:text name="bshare.points.username.alt"/>') {
				// set to empty so validator will invalidate it...
				$('#j_username').val("");
				// don't know why this doesn't work...
				//var errObj = {"j_username": "<s:text name="bshare.field.error.required"/>"};
				//this.invalidate(errObj);
			}
		},
		onBeforeFail: function(e, $inputField, matcher) {
			if ($inputField.attr("id") == "j_username") {
				// if username failed (was empty), reset the input default text.
				$('#j_username').val("<s:text name="bshare.points.username.alt"/>");
			}
		}
	});

	if ($.trim($("#login-messages-div").text())) {
		$("#login-messages-div").show();
	}
	
	var logInd = 0;
	if ('${request.loginType}' == '1') {
		logInd = 1;
	}
});
</script>
