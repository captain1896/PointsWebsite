<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<meta name="description" content="请仔细阅读微积分平台的帮助页面" />
<title>站长用户使用说明 - 帮助 - <s:text name="bshare.points.title"/></title>

<style>
.separator { border-bottom: 1px dashed #dadada; margin: 15px 0; }
.module-backend p { line-height: 200%; }
.field-tip { color: #333; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
        <span>&gt;</span>
        <a class="bLinkDark" href="${points_cxt_path}/help">帮助</a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/help/pRule">站长用户使用说明</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<%@ include file="/jsp/common/leftHelpMenu.jsp" %>
	
	<div class="container-right module-white-grey module-backend">
        <div class="clear spacer20"></div>
        <p class="heading3 text-blue">如何成为微积分的发点商</p>
        <div class="clear spacer15"></div>
        <p>微积分帮助您管理您的积分系统，让您能够使用微积分奖励您的用户，并为您免去积分运营的问题，而这一切仅需要简单的两步：</p>
        <div class="clear spacer10"></div>
        <p>1、    点击<a class="bLinkBlue" target="_blank"
            href="${main_cxt_path}/help/install">这里</a>安装bShare分享工具。安装bShare分享工具，且安装的分享按钮方式为Plus方式。
        </p>
        <div class="clear spacer10"></div>
        <p class="field-tip">bShare分享方式分为两种：一种为Lite，一种为Plus。</p>
        <p class="field-tip">站长可以通过以下两种方式确认和修改当前分享方式是否为Plus：</p>
        <p class="field-tip">方法一：Lite代码为buttonLite.js，Plus代码为button.js，查看当前bShare JS代码，如果是button.js，说明分享方式是Plus，无需修改代码；如果是buttonLite.js，说明分享方式是Lite，将代码中的“buttonLite.js”更换为“button.js”即可。</p>
        <div class="clear spacer10"></div>
        <div class="codeBox">
            &lt;a class="bshareDiv" href="${main_cxt_path}/share"&gt;<s:text name="bshare.common.share"/>&lt;/a&gt;<br/>
            &lt;script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/<font style="color:red;font-weight:bold;">button.js</font>#uuid="&gt;&lt;/script&gt;
        </div>
        <div class="clear spacer10"></div>
        <p class="field-tip">方法二：登录bShare，重新获取bShare Plus JS代码（详见下图）</p>
        <div class="clear spacer10"></div>
        <img src="${points_image_path}/help/help-button-code.jpg" />
        <div class="clear spacer10"></div>
        <p>2、   点击<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/user/applypointspublisher">这里</a>申请成为微积分的发点商。具体的发点商协议和相关事宜，请仔细阅读<a class="bLinkBlue" target="_blank"
            href="${points_cxt_path}/terms">这里</a>
         <!--    ，如果您希望免费参加我们的微积分计划，也可以点击<a class="bLinkBlue" target="_blank"
            href="${main_cxt_path}/olympic">这里</a>参与我们的任务，获取bShare赠送给您的微积分
         --> 。</p>
        <div class="clear spacer1 separator"></div>
        
        <p class="heading3 text-blue">如何成为微积分的烧点商</p>
        <div class="clear spacer15"></div>
        <p>如果您希望您的商品或服务可以在微积分的平台中进行兑换，或者希望将微积分与您现有的积分体系打通，或者愿意加入我们的商品兑换平台成为我们的烧点商，请点击<a class="bLinkBlue"
            href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" target="_blank">这里</a>与我们联系。</p>
            
        <div class="clear spacer50"></div>
        <a class="bLinkBlue right" href="${points_cxt_path}/apply/publisher" target="_blank">立即加入微积分，马上行动！</a>
        <div class="clear spacer50"></div>
    </div>
	<div class="clear"></div>
</div>