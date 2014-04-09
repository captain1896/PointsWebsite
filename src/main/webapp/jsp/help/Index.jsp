<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<meta name="description" content="请仔细阅读微积分平台的帮助页面" />
<title>帮助 - <s:text name="bshare.points.title"/></title>

<style>
.module-backend p { line-height: 200%; }
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.point"/></a>
        <span>&gt;</span>
        <a class="bLinkDark" href="${points_cxt_path}/help">帮助</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<%@ include file="/jsp/common/leftHelpMenu.jsp" %>
	
	<div class="container-right module-white-grey module-backend">
        <div class="clear spacer20"></div>
        <p class="heading2 text-blue">什么是微积分...</p>
        <div class="clear spacer15"></div>
        <p>微积分是bShare为其客户打造的一个网上积分服务平台。在这里，我们的客户通过使用微积分及其合作伙伴而获得积分。这些积分可以兑换成礼品，也可以兑换成给微积分合作伙伴的商品，或者兑换成抵扣。在微积分，我们会选择最好的合作品牌，让我们的会员都能享受微积分所带来的无限乐趣！</p>
        <div class="clear spacer10"></div>
        <p>微积分也是一个互动的沟通平台，在这里，我们能有更多机会聆听每一位客户的声音。在微积分，我们关注您的想法和意见。您可以通过在<a class="bLinkBlue"
            href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" target="_blank">在线客服QQ</a>上留言来让我们听到您的声音，知道您的想法和意见。</p>
        <div class="clear spacer10"></div>
        <p>微积分的乐趣从这里开始。我们承诺给我们的会员最新、最好的礼品选择，以及服务支持。期待您的参与和支持！</p>
            
        <div class="clear spacer50"></div>
        <a class="bLinkBlue right" href="${points_cxt_path}/apply/publisher" target="_blank">立即加入微积分，马上行动！</a>
        <div class="clear spacer50"></div>
    </div>
	<div class="clear"></div>
</div>