<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%pageContext.setAttribute("bSharePointsUuid",com.buzzinate.common.util.ConfigurationReader.getString("bshare.points.uuid")); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Language" content="${curLang}" />
    <meta name="description" content="分享送积分 好礼享不停只要您在活动期间进行分享便可获得积分兑换成各种礼物" />
    <meta name="keywords" content="v5, 微积分, 分享, 好礼, 分享送积分 好礼享不停" />
    <meta name="author" content="Buzzinate" />
    <title>分享送积分 好礼享不停 - <s:text name="bshare.points.title"/></title>

    <link rel="stylesheet" href="${points_css_path}/bsharePoints.css" type="text/css" />
    <style type="text/css">
.container-nav { background: #0097d2; }
.container-logo { display: none; }

.container { background: #ffe068; }
.container-event { width: 980px; }
.wrapper-intro, .wrapper-try, .wrapper-follow, .wrapper-rule, .wrapper-prize { background-color: #fef9d3; }
.wrapper-intro { background-image: url(${points_image_path}/events/v5/bkg-body-c.jpg); height: 644px; }
.wrapper-try { background-image: url(${points_image_path}/events/v5/bkg-try-c.jpg); background-repeat: no-repeat; 
    background-position:  bottom right; padding: 20px; text-align: center; }
.bButton-try { background: url(${points_image_path}/events/v5/btn-try-c.png) no-repeat; 
    margin: 0 auto; display: block; width: 194px; height: 45px; }
.wrapper-follow { background-image: url(${points_image_path}/events/v5/bkg-follow.jpg); background-repeat: no-repeat; height: 110px; }
.bButton-follow { display: block; width: 134px; height: 30px; float: right; margin: 47px 142px 0 0; _margin-right: 70px; }
.wrapper-rule, .wrapper-prize { border-radius: 10px; padding: 30px; color: #686767; }
.hd-join, .hd-rules, .hd-websites, .hd-prize { background: url(${points_image_path}/events/v5/headings-c.jpg) 0 0 no-repeat; height: 24px; }
.hd-rules { background-position: 0 -24px; }
.hd-websites { background-position: 0 -48px; }
.hd-prize { background-position: 0 -72px; }
.card-client { width: 110px; text-align: center; margin: 10px; color: #333; text-decoration: none; overflow: hidden; }
.card-client img { width: 110px; height: 46px; display: block; background: #fff; }
.card-client span { text-overflow: ellipsis; white-space: nowrap; overflow: hidden; line-height: 20px; }
.bButton-join { padding: 8px 0; width: 240px; }
.card-prod { width: 152px; margin: 0 16px 20px; _margin: 0 15px 30px; text-align: center;}
.prod-image { border: 1px solid #dadada; width: 150px; height: 150px; display: block; }
.prod-image img { display: block; margin: 0 auto; width: 150px; }
.card-prod a { text-decoration: none; }
.prod-title { height: 24px; line-height: 24px; display: block; overflow: hidden; word-wrap: break-word; word-break: break-all; }
.prod-summary { color: #555; font-size: 12px; height: 45px; line-height: 15px; display: block; overflow: hidden; word-wrap: break-word; word-break: break-all; }
.prod-points { font-size: 12px !important; }
.prod-button { padding: 6px 30px; font-size: 12px; margin-top: 10px; }
.prod-provider { font-size: 12px; color: #666; height: 16px; overflow: hidden; text-align: left; word-wrap: break-word; word-break: break-all; }
.prod-provider .tag { display: block; width: 48px; float: left; }
.prod-provider .name {display: block; width: 104px; overflow: hidden; float: left; }
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
	            <a class="bButton-try" href="${points_cxt_path}/events/2012/v5/rank" target="_blank"></a>
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
	            <p>1. 打开任意<a class="bLinkOrange" href="${points_cxt_path}/events/2012/v5/rank" target="_blank">参与活动的网站</a>；</p>
	            <div class="spacer10"></div>
	            <p>2. 分享任意含有“奖“字的网页，到指定的8个平台（新浪微博、腾讯微博、QQ空间、搜狐微博、网易微博、人人网、开心网、天涯社区）；</p>
	            <div class="spacer10"></div>
	            <p>3. 完成，坐等微积分，或想办法<a class="bLinkOrange" href="${points_cxt_path}/shop/activities" target="_blank">获取更多的微积分</a>。</p>
	            <div class="clear spacer30"></div>
	            
	            <div class="hd-rules"></div>
	            <div class="spacer20"></div>
	            <p>1. 为方便查询或管理你的微积分，请<a class="bLinkOrange" href="${points_cxt_path}/register" target="_blank">注册微积分帐号</a>或者使用<a class="bLinkOrange" href="${points_cxt_path}/login" target="_blank">已有社交媒体帐号登陆</a>；</p>
	            <div class="spacer10"></div>
	            <p>2. 同一个网站，每人每天最多获取100个微积分，在不同网站所获积分可以叠加累计；</p>
	            <div class="spacer10"></div>
	            <p>3. 活动时间：2012.09.20-2012.9.30。活动结束后带来的点击不奖励积分，请在2014年9月20日之前进行兑换；</p>
	            <div class="spacer10"></div>
	            <p>4. 我们有各种防范作弊的措施，本活动最终解释权归&nbsp;bShare&nbsp;所有。</p>
	            <div class="clear spacer30"></div>
	            
	            <img src="${points_image_path}/events/v5/banner-prize-c.jpg" />
	            <div class="clear spacer30"></div>
	            
	            <div class="hd-websites">
	                <a class="bLinkOrange right" href="${points_cxt_path}/events/2012/v5/rank" target="_blank">&gt;&gt;更多</a>
	            </div>
	            <div class="clear spacer20"></div>
	            <a class="card-client left" title="也买酒" href="http://www.yesmywine.com/regredirect.jsp?rurl=http://www.yesmywine.com/&keyname=bShare&keysource=wjf" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/yesmywine.png" />
	                <div class="clear spacer10"></div>
	                <span>也买酒</span>
	            </a>
	            <a class="card-client left" title="钻石小鸟" href="http://www.zbird.com" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/zbird.png" />
	                <div class="clear spacer10"></div>
	                <span>钻石小鸟</span>
	            </a>
	            <a class="card-client left" title="杂良集" href="http://www.okjee.com/" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/okjee.png" />
	                <div class="clear spacer10"></div>
	                <span>杂良集</span>
	            </a>
	            <a class="card-client left" title="橡果国际" href="http://www.chinadrtv.com/" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/chinadrtv.png" />
	                <div class="clear spacer10"></div>
	                <span>橡果国际</span>
	            </a>
	            <a class="card-client left" title="职友正装" href="http://www.zhiyou.cn/" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/zhiyou.png" />
	                <div class="clear spacer10"></div>
	                <span>职友正装</span>
	            </a>
	            <a class="card-client left" title="妈妈好孩子" href="http://www.mamabb.com/" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/mamabb.png" />
	                <div class="clear spacer10"></div>
	                <span>妈妈好孩子</span>
	            </a>
	            <a class="card-client left" title="美居购（搜狐家居）" href="http://www.meijugou.com/" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/meijugou.png" />
	                <div class="clear spacer10"></div>
	                <span>美居购（搜狐家居）</span>
	            </a>
                <a class="card-client left" title="开心人大药房" href="http://360kxr.com" target="_blank">
                    <img src="${points_image_path}/events/v5/clients/360kxr.png" />
                    <div class="clear spacer10"></div>
                    <span>开心人大药房</span>
                </a>
	            <a class="card-client left" title="酷运动" href="http://k121.com" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/k121.png" />
	                <div class="clear spacer10"></div>
	                <span>酷运动</span>
	            </a>
	            <a class="card-client left" title="麦包包" href="http://mbaobao.com" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/mbaobao.png" />
	                <div class="clear spacer10"></div>
	                <span>麦包包</span>
	            </a>
	            <a class="card-client left" title="小也商城" href="http://www.xiaoye.com" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/xiaoye.png" />
	                <div class="clear spacer10"></div>
	                <span>小也商城</span>
	            </a>
	            <a class="card-client left" title="飞虎乐购" href="http://www.efeihu.com" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/efeihu.png" />
	                <div class="clear spacer10"></div>
	                <span>飞虎乐购</span>
	            </a>
	            <a class="card-client left" title="聚尚网" href="http://fclub.cn" target="_blank">
	                <img src="${points_image_path}/events/v5/clients/fclub.png" />
	                <div class="clear spacer10"></div>
	                <span>聚尚网</span>
	            </a>
                <a class="card-client left" title="珍品网" href="http://zhenpin.com" target="_blank">
                    <img src="${points_image_path}/events/v5/clients/zhenpin.png" />
                    <div class="clear spacer10"></div>
                    <span>珍品网</span>
                </a>
	            <div class="clear spacer10"></div>
	            <div style="text-align: center">
	                <a class="bButton-orange bButton-join" href="${points_cxt_path}/events/2012/v5/2b" target="_blank" style="margin-right: 20px;">我是网站，我要加入活动</a>
	                <a class="bButton-blue bButton-join" href="http://wpa.qq.com/msgrd?v=3&amp;uin=790715851&amp;site=qq&amp;menu=yes" target="_blank">我是&nbsp;V5Shop&nbsp;客户，我要加入活动</a>
	            </div>
	            <div class="clear"></div>
	        </div>
	        
	        <div class="clear spacer20"></div>
	        <div class="wrapper-prize">
	            <div class="hd-prize">
                    <a class="bLinkOrange right" href="${points_cxt_path}/shop/category/all" target="_blank">&gt;&gt;更多</a>
	            </div>
	            <div class="spacer20"></div>
	            <div class="card-prod left" prodId="1410">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1410" target="_blank" title="麦包包20元现金券"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/V/V5xt6TXqZwaQknWd.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1410" target="_blank" class="prod-title bLinkBlue heading3" title="麦包包20元现金券">麦包包20元现金券</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1410" target="_blank" class="prod-summary bLinkDark" 
	                    title="麦包包20元现金券，满200可用。 用户点击兑换之后，会拿到20元现金券的兑换码一个，凭借该兑换码，用户直接去麦包包官网下单购买，可享受满200元可直接减20元的优惠。">麦包包20元现金券，满200可用。 用户点击兑换之后，会拿到20元现金券的兑换码一个，凭借该兑换码，用户直接去麦包包官网下单购买，可享受满200元可直接减20元的优惠。 </a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">1</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.mbaobao.com/" target="_blank">麦包包</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1410" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="card-prod left" prodId="1400">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1400" target="_blank" title="聚尚网30元现金券"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/Q/Qo8oI497c6VNnlax.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1400" target="_blank" class="prod-title bLinkBlue heading3" title="聚尚网30元现金券">聚尚网30元现金券</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1400" target="_blank" class="prod-summary bLinkDark" 
	                    title="聚尚网是时尚名品限时特卖购物网站，海量国内外名品低至1折，中华保险承保100%正品，7天无理由退货，支持货到付款。 ">聚尚网是时尚名品限时特卖购物网站，海量国内外名品低至1折，中华保险承保100%正品，7天无理由退货，支持货到付款。 </a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">1</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.fclub.cn/" target="_blank">聚尚网</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1400" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="card-prod left" prodId="1408">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1408" target="_blank" title="NALA化妆品商城200-30"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/W/WHcAqv3B9sx3K88a.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1408" target="_blank" class="prod-title bLinkBlue heading3" title="NALA化妆品商城200-30">NALA化妆品商城200-30</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1408" target="_blank" class="prod-summary bLinkDark" 
	                    title="NALA化妆品商城200-30 现金券，全场使用，满200元抵30。2012年12月31日前均有效。 ">NALA化妆品商城200-30 现金券，全场使用，满200元抵30。2012年12月31日前均有效。</a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">1</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.nala.com.cn/" target="_blank">娜拉</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1408" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="card-prod left" prodId="1396">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1396" target="_blank" title="汉庭酒店200元入住大礼包"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/c/cYcAfhsXedCcqNGs.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1396" target="_blank" class="prod-title bLinkBlue heading3" title="汉庭酒店200元入住大礼包">汉庭酒店200元入住大礼包</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1396" target="_blank" class="prod-summary bLinkDark" 
	                    title="使用说明： 兑换成功可获得一个验证码，用户请凭借验证码到汉庭官网指定地址：http://www.htinns.com/reg/bshare，注册为汉庭e会员并绑定优惠券。 ">使用说明： 兑换成功可获得一个验证码，用户请凭借验证码到汉庭官网指定地址：http://www.htinns.com/reg/bshare，注册为汉庭e会员并绑定优惠券。</a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">1</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.htinns.com/reg/bshare" target="_blank">汉庭酒店</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1396" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="card-prod left" prodId="1404">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1404" target="_blank" title="钻石300元现金券"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/4/4IttamhwMPBu1v0r.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1404" target="_blank" class="prod-title bLinkBlue heading3" title="钻石300元现金券">钻石300元现金券</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1404" target="_blank" class="prod-summary bLinkDark" 
	                    title="用户凭bShare专享300元现金券的兑换码，到该店铺下单，将bShare专享300元现金券兑换码给到客服即可减价。 ">用户凭bShare专享300元现金券的兑换码，到该店铺下单，将bShare专享300元现金券兑换码给到客服即可减价。</a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">1</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.hunzuan.com/" target="_blank">鑫万福</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1404" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="card-prod left" prodId="1393">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1393" target="_blank" title="银泰（满398元减40元）"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/u/uzb8wq32Ze7fXHbl.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1393" target="_blank" class="prod-title bLinkBlue heading3" title="银泰（满398元减40元）">银泰（满398元减40元）</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1393" target="_blank" class="prod-summary bLinkDark" 
	                    title="银泰（满398元减40元） 2012-08-31到期">银泰（满398元减40元） 2012-08-31到期</a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">1</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.yintai.com/" target="_blank">银泰网</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1393" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="card-prod left" prodId="1368">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1368" target="_blank" title="港澳四天三晚畅享双人游"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/P/PAMWzGK8xPgpFJBh.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1368" target="_blank" class="prod-title bLinkBlue heading3" title="港澳四天三晚畅享双人游">港澳四天三晚畅享双人游</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1368" target="_blank" class="prod-summary bLinkDark" 
	                    title="原价2980元港澳四天三晚双人游VIP畅游卡由第一感觉网赞助，该《Vl P畅游卡》可免费畅游行程所列景点参观与门票">原价2980元港澳四天三晚双人游VIP畅游卡由第一感觉网赞助，该《Vl P畅游卡》可免费畅游行程所列景点参观与门票</a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">1,000</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.firstfeeling.cn/" target="_blank">第一感觉交友网</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1368" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="card-prod left" prodId="1346">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1346" target="_blank" title="卡当可爱骨头项链免费领取券"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/F/FUmrN75lm6mGLOvo.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1346" target="_blank" class="prod-title bLinkBlue heading3" title="卡当可爱骨头项链免费领取券">卡当可爱骨头项链免费领取券</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1346" target="_blank" class="prod-summary bLinkDark" 
	                    title="可爱骨头 合金项链 http://www.kadang.com/diy/detail3159.html?from=bSharejf">可爱骨头 合金项链 http://www.kadang.com/diy/detail3159.html?from=bSharejf</a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">1,000</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.kadang.com/" target="_blank">卡当网</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1346" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="card-prod left" prodId="1363">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1363" target="_blank" title="优雅田园风格纹牛皮休闲皮带(立减100元)"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/B/BDw0HdHlxKLrX6Zy.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1363" target="_blank" class="prod-title bLinkBlue heading3" title="优雅田园风格纹牛皮休闲皮带(立减100元)">优雅田园风格纹牛皮休闲皮带(立减100元)</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1363" target="_blank" class="prod-summary bLinkDark" 
	                    title="用户兑换成功后，将会获取由bShare赠与的电子密钥，用户凭借该密钥，可去梦芭莎网站购买该产品。">用户兑换成功后，将会获取由bShare赠与的电子密钥，用户凭借该密钥，可去梦芭莎网站购买该产品。</a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">23</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.moonbasa.com/" target="_blank">梦芭莎</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1363" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="card-prod left" prodId="1360">
	                <a class="prod-image" href="http://points.bshare.cn/shop/product/1360" target="_blank" title="豹纹字母印花T恤"><img 
	                    src="http://repo.bshare.cn/pointsImage/source/o/ol2OkLGzoGFq4jfO.jpg" /></a>
	                <div class="spacer10"></div>
	                <a href="http://points.bshare.cn/shop/product/1360" target="_blank" class="prod-title bLinkBlue heading3" title="豹纹字母印花T恤">豹纹字母印花T恤</a>
	                <div class="spacer5"></div>
	                <a href="http://points.bshare.cn/shop/product/1360" target="_blank" class="prod-summary bLinkDark" 
	                    title="用户兑换成功后，将会获取由bShare赠与的电子密钥，用户凭借该密钥，可去梦芭莎网站0元购买该T恤。 ">用户兑换成功后，将会获取由bShare赠与的电子密钥，用户凭借该密钥，可去梦芭莎网站0元购买该T恤。 </a>
	                <div class="spacer5"></div>
	                <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" 
	                    style="margin-left: 0; font-size:14px;">19</span>微积分</p>
	                <div class="clear spacer10"></div>
	                <p class="prod-provider"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.moonbasa.com/" target="_blank">梦芭莎</a></p>
	                <div class="spacer10"></div>
	                <div class="center"><a class="prod-button bButton-blue" href="http://points.bshare.cn/shop/product/1360" target="_blank">查看详细</a></div>
	                <div class="clear"></div>
	            </div>
	            <div class="clear"></div>
	        </div>
	        <div class="clear spacer20"></div>
	        
	        <div class="wrapper-footer">
	            <p>若在活动的过程中，有任何问题，您可以点击&nbsp;<a class="bLinkBlue" target="_blank" href="mailto:feedback@bshare.cn" 
	                title="feedback@bshare.cn">这里</a>&nbsp;给我们发送邮件或和我们的&nbsp;<a class="bLinkBlue" href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" 
	                target="_blank">在线客服</a>&nbsp;联络。本次活动最终解释权归&nbsp;<a class="bLinkBlue" href="${points_cxt_path}" target="_blank">微积分</a>&nbsp;所有</p>
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
        title: '分享送积分 好礼享不停',
        summary: '小小的分享，有精彩的回报',
        vUid: '<s:property value="%{#session.USER_ID}"/>', 
        vEmail: '<s:property value="%{#session.DISPLAY_NAME}"/>', 
        vTag: 'WEIJIFEN'
    });
});
</script>
</body>
</html>
