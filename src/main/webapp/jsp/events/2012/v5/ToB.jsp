<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%pageContext.setAttribute("bSharePointsUuid",com.buzzinate.common.util.ConfigurationReader.getString("bshare.points.uuid")); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Language" content="${curLang}" />
    <meta name="description" content="分享送积分 流量享不停只要您在活动期间进行分享便可获得积分兑换成各种礼物" />
    <meta name="keywords" content="v5, 微积分, 分享, 流量, 分享送积分 流量享不停" />
    <meta name="author" content="Buzzinate" />
    <title>分享送积分 流量享不停 - <s:text name="bshare.points.title"/></title>

    <link rel="stylesheet" href="${points_css_path}/bsharePoints.css" type="text/css" />
    <style type="text/css">
.container-nav { background: #0097d2; }
.container-logo { display: none; }

.container { background: #ffe068; }
.container-event { width: 980px; }
.wrapper-intro, .wrapper-try, .wrapper-follow, .wrapper-rule, .wrapper-prize { background-color: #fef9d3; }
.wrapper-intro { background-image: url(${points_image_path}/events/v5/bkg-body-b.jpg); background-repeat: no-repeat; height: 674px; }
.wrapper-try { background-image: url(${points_image_path}/events/v5/bkg-try-b.jpg); background-repeat: no-repeat; 
    padding: 30px 30px 23px; _padding-bottom: 21px; position: relative; }
.bButton-try { display: block; width: 194px; height: 45px; position: absolute; top: 60px; right: 30px; }    
.wrapper-follow { background-image: url(${points_image_path}/events/v5/bkg-follow.jpg); background-repeat: no-repeat; height: 110px; }
.bButton-follow { display: block; width: 134px; height: 30px; float: right; margin: 47px 142px 0 0; _margin-right: 70px; }
.wrapper-rule { border-radius: 10px; padding: 30px; color: #686767; background-image: url(${points_image_path}/events/v5/bkg-rule-b.jpg); 
    background-repeat: no-repeat; background-position:  bottom right;}

.hd-join, .hd-rules, .hd-top, .hd-media { background: url(${points_image_path}/events/v5/headings-b.jpg) 0 0 no-repeat; height: 24px; }
.hd-rules { background-position: 0 -24px; }
.hd-top { background-position: 0 -48px; }
.hd-media { background-position: 0 -72px; }

.bButton-join { font-size: 16px; font-weight: bold; padding: 5px 40px; }
.wrapper-footer { font-size: 12px; }
    </style>
    
    <link rel="icon" href="http://www.bshare.cn/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="http://www.bshare.cn/favicon.ico" type="image/x-icon" />
    
    <script type="text/javascript" charset="utf-8" src="${jquerySrc}"></script>
    <!--[if lt IE 7]>
    <script type="text/javascript" charset="utf-8">
        var BSHARE_STATIC_HOST = "${static_cxt_path}/";
    </script>
    <script type="text/javascript" charset="utf-8" src="${js_path}/libs/unitpngfix.js"></script>
    <![endif]-->
</head>

<body>
    <div class="container">
	    <div class="container-center">
	        <noscript>
	            <span style="color: red;"><strong><s:text name="bshare.no.js"/></strong></span>
	            <div class="spacer10"></div>
	        </noscript>
	    </div>
	    
	    <%@ include file="/jsp/common/topMenu.jsp"%>
	    
	    <div class="clear"></div>
	    <div class="container-center container-event">
	        <div class="wrapper-intro">
	            <div class="clear"></div>
	        </div>
	        <div class="wrapper-try">
	            <p class="heading3">1. 本次活动仅限<span class="text-orange">PV>2000/天</span>的电子商务公司参与；</p>
	            <div class="spacer10"></div>
	            <p class="heading3">2. 参与网站需要在首页展示活动公告，<a class="bLinkOrange" href="${points_cxt_path}/events/2012/v5/download" target="_blank">广告模板下载</a>；</p>
	            <div class="spacer10"></div>
	            <p class="heading3">3. 有官方微博帐号，转发bShare微积分微博，另获1000微积分（非必须）。</p>
	            <a class="bButton-try" href="${points_cxt_path}/events/2012/v5/intro" target="_blank"></a>
	            <div class="clear"></div>
	        </div>
	        <div class="wrapper-follow">
	            <a class="bButton-follow" href="http://weibo.com/bshareweijifen" target="_blank"></a>
	            <div class="clear"></div>
	        </div>
	        <div class="spacer15"></div>
	        
	        <div class="wrapper-rule">
	            <div class="hd-join"></div>
	            <div class="spacer20"></div>
	            <p>1. 为方便查询、发送或管理微积分，请<a class="bLinkOrange" href="${points_cxt_path}/register" target="_blank">注册微积分帐号</a>或使用<a class="bLinkOrange" href="${points_cxt_path}/login" target="_blank">已有社交媒体帐号登陆</a>；</p>
	            <div class="spacer10"></div>
	            <p>2. 通过Plus的方式安装<a class="bLinkOrange" href="${points_cxt_path}/events/2012/v5/intro" target="_blank">安装&nbsp;bShare&nbsp;分享代码</a>；</p>
	            <div class="spacer10"></div>
	            <p>3. 网站首页公告活动，号召大家参与即可；</p>
	            <div class="spacer10"></div>
	            <p>4. 提供商品兑换的网站，请提交兑换的清单，&nbsp;bShare&nbsp;收取12%手续费，运费自理。</p>
	            <div class="spacer30"></div>
	            
	            <div class="hd-rules"></div>
	            <div class="spacer20"></div>
	            <p>1. 参与活动的电商用户可获得bShare赠送的2000积分，全免费推广； </p>
	            <div class="spacer10"></div>
	            <p>2. 同一个网站，每人每天最多发放100个微积分；</p>
	            <div class="spacer10"></div>
	            <p>3. 活动时间：2012.09.20-2012.9.30。活动结束后带来的点击不奖励积分；</p>
	            <div class="spacer10"></div>
	            <p>4. 我们有各种防范作弊的措施，确保只有真实有效的2次回流后才会对该用户进行奖励；</p>
	            <div class="spacer10"></div>
	            <p>5. 活动结束后，&nbsp;bShare&nbsp;对所有剩余微积分进行回收；</p>
	            <div class="spacer10"></div>
	            <p>6. 本活动最终解释权归&nbsp;bShare&nbsp;所有。</p>
	            <div class="clear spacer30"></div>
	            
	            <div class="hd-top"></div>
	            <div class="spacer20"></div>
	            <p>1. 分享量越高的网站，排行越靠前；</p>
	            <div class="spacer10"></div>
	            <p>2. 活动期间，积分送完的网站，可追送价值6000微积分予以奖励；</p>
	            <div class="spacer10"></div>
	            <p>3. 活动结束后，分享量前三名的网站赠送bShare Pro高级账号；</p>
	            <div class="spacer10"></div>
	            <p style="padding-left: 20px;">（bShare Pro除了让您在按钮弹窗中有了更多的自主权之外，数据统计中的二次回流数据分析，意见领袖分析等更加专业的数据报告，会使您网站获得流量的每一个细节，尽收眼底。
	            本次活动的奖品是bShare高级账号一年的使用权，价值2000元！）</p>
	            <div class="spacer30"></div>
	                        
	            <div class="hd-media"></div>
	            <div class="spacer20"></div>
	            <p>1. 硬广：派代、开个网店、V5SHOP、Chinaz、我要啦、我啦网、bShare硬广展示；</p>
	            <div class="spacer10"></div>
	            <p>2. 新闻稿：与本次活动相关的30-50篇新闻稿发布；</p>
	            <div class="spacer10"></div>
	            <p>3. 专访：速途网专题采访；</p>
	            <div class="spacer10"></div>
	            <p>4. 专题：速途专题报道。</p>
	            
	            <div class="clear spacer20"></div>
	            <div style="text-align: center">
	                <a class="bButton-orange bButton-join" href="${points_cxt_path}/events/2012/v5/2c" target="_blank">我要分享&nbsp;参加活动</a>
	            </div>
	            <div class="clear"></div>
	        </div>
	        <div class="clear spacer30"></div>
	        
	        <div class="wrapper-footer">
	            <p class="text-orange" style="font-size: 14px;">成为bShare合作伙伴，获得更多活动信息请联系市场部：<a class="bLinkOrange" target="_blank" href="mailto:events@buzzinate.com" 
	                title="events@buzzinate.com">events@buzzinate.com</a>。</p>
	            <div class="spacer15"></div>
	            <p>本次活动最终解释权归&nbsp;<a class="bLinkBlue" href="${points_cxt_path}" target="_blank">微积分</a>&nbsp;所有</p>
	        </div>
	        <div class="clear"></div>
	    </div>
	    <div class="clear spacer30"></div>
    </div>
    
    <%@ include file="/jsp/common/bottomMenu.jsp"%>

<a class="bshareDiv" href="${main_cxt_path}/share"></a><script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/button.js#uuid=${bSharePointsUuid}&amp;style=3&amp;fs=4&amp;textcolor=#fff&amp;bgcolor=#ff6600&amp;text=分享到"></script>
<script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/button.js#uuid=${bSharePointsUuid}&amp;style=-1"></script>
<script type="text/javascript" charset="utf-8">
$(function() {
    bShare.addEntry({
        title: '分享送积分 流量涨不停',
        summary: '参与活动，获取bShare赠送的2000积分，开启社会化电商的引流之旅吧！',
        vUid: '<s:property value="%{#session.USER_ID}"/>', 
        vEmail: '<s:property value="%{#session.DISPLAY_NAME}"/>', 
        vTag: 'WEIJIFEN'
    });
});
</script>
</body>
</html>
