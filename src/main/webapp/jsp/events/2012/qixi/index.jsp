<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%pageContext.setAttribute("bSharePointsUuid",com.buzzinate.common.util.ConfigurationReader.getString("bshare.points.uuid")); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Language" content="${curLang}" />
	<meta name="description" content="七夕情人节约惠微积分是bShare推出的一档节日优惠活动只要您在活动期间进行分享便可获得积分兑换成各种礼物" />
	<meta name="keywords" content="七夕活动,七夕情人节,七夕情人节约惠微积分" />
	<meta name="author" content="Buzzinate" />
	<title>七夕活动,七夕情人节，约惠微积分，七夕约惠微积分分享有好礼 - <s:text name="bshare.points.title"/></title>

    <link rel="stylesheet" href="${points_css_path}/bsharePoints.css" type="text/css" />
    <style type="text/css">
body { background: #ffeded; }
.text-pink { color: #ff0036; }
.container-nav { background: #0097d2; }
.container-logo { display: none; }
.bButton-pink { vertical-align: middle; display: inline-block; *display: inline; zoom: 1; text-decoration: none; padding: 4px 15px; width: 100px; text-align: center; font-size: 12px;
    font-size: 14px; cursor: pointer; color: #000; border: 1px solid #f9295a; background: #ed2c57; 
    background: -webkit-gradient(linear, 0% 40%, 0% 70%, from(#ed2c57), to(#fe939c)); 
    background: -moz-linear-gradient(top, #ed2c57, #fe939c); 
    filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFED2C57',EndColorStr='#FFFE939C'); 
    -moz-border-radius: 3px; -webkit-border-radius: 3px; border-radius: 3px; color: #fff; }
.bButton-pink:hover { background: #f04065; background: -webkit-gradient(linear, 0% 40%, 0% 70%, from(#f04065), to(#feb6bd)); 
    background: -moz-linear-gradient(top, #f04065, #feb6bd); 
    filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFF04065',EndColorStr='#FFFEB6BD'); }

.container-event { background: url(${points_image_path}/events/qixi/bkg-body.jpg) no-repeat #ffeded; padding-top: 160px; width: 980px; }
.wrapper-intro { margin-left: 30px; padding: 40px 0px; width: 320px; }
.wrapper-intro p { text-indent: 25px; line-height: 28px; }
.wrapper-prods, .wrapper-clients, .wrapper-parts, .wrapper-footer { padding: 20px 30px; color: #4b4b4b; overflow: hidden; }
.wrapper-rule { margin: 20px 30px; text-align: left; table-layout: fixed; }
.table-header { width: 80px; }
.card-prod { width: 152px; margin: 0 11px; _margin: 0 10px; text-align: center;}
.prod-image { border: 1px solid #dadada; width: 150px; height: 150px; display: block; }
.prod-image img { display: block; margin: 0 auto; }
.card-prod a { text-decoration: none; }
.prod-title { height: 24px; line-height: 24px; display: block; overflow: hidden; word-wrap: break-word; word-break: break-all; }
.prod-summary { color: #555; font-size: 12px; height: 45px; line-height: 15px; display: block; overflow: hidden; word-wrap: break-word; word-break: break-all; }
.prod-points { font-size: 12px !important; }
.prod-button { padding: 6px 30px; font-size: 12px; margin-top: 10px; }
.prod-boss { font-size: 12px; color: #666; height: 16px; overflow: hidden; text-align: left; word-wrap: break-word; word-break: break-all; }
.prod-boss .tag { display: block; width: 48px; float: left; }
.prod-boss .name {display: block; width: 104px; overflow: hidden; float: left; }
.card-client { width: 110px; text-align: center; margin: 10px 36px; color: #333; text-decoration: none; overflow: hidden; }
.card-client img { width: 110px; height: 46px; display: block; background: #fff; }
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
	<div class="container-center">
	    <noscript>
	        <span style="color: red;"><strong><s:text name="bshare.no.js"/></strong></span>
	        <div class="spacer10"></div>
	    </noscript>
	</div>
	
	<%@ include file="/jsp/common/topMenu.jsp"%>
	
    <div class="clear spacer20"></div>
	<div class="container-center container-event">
        <div class="wrapper-intro">
            <div class="clear spacer10"></div>
            <p class="text-pink">亲，今年七夕你约“惠”了吗，微积分分享就有好礼送噢！</p>
            <div class="clear spacer5"></div>
            <p class="text-pink">现在开始，只要您在以下参与活动的网站中进行任意一次分享，通过微博、空间等社交平台将网站展现给你的好友，获取点击就有积分送，积分可以兑换各种礼物。</p>
            <div class="clear spacer5"></div>
            <p class="text-pink">分享，每一秒都是新状态，好状态带来桃花朵朵开。bShare微积分与你共度甜蜜情人节！</p>
        </div>
        <div class="spacer15"></div>
        <div class="clear spacer50"></div>
        
        <div class="bshare-custom icon-medium" style="margin: -50px 0 0 5px;">
            <a title="分享到腾讯微博" class="bshare-qqmb" href="javascript:void(0);"></a>
            <a title="分享到新浪微博" class="bshare-sinaminiblog" href="javascript:void(0);"></a>
            <a title="分享到QQ空间" class="bshare-qzone" href="javascript:void(0);"></a>
            <a title="分享到搜狐微博" class="bshare-sohuminiblog" href="javascript:void(0);"></a>
            <a title="分享到网易微博" class="bshare-neteasemb" href="javascript:void(0);"></a>
            <a title="分享到人人网" class="bshare-renren" href="javascript:void(0);"></a>
            <a title="分享到开心" class="bshare-kaixin001" href="javascript:void(0);"></a>
            <a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a>
            <span class="BSHARE_COUNT bshare-share-count">0</span>
        </div>
        
        <div class="spacer15"></div>
        <table class="wrapper-rule">
            <tr>
                <td class="table-header text-pink">时间周期：</td>
                <td>8.23&nbsp;–&nbsp;9.22<div class="clear spacer10"></div></td>
            </tr>
            <tr>
                <td class="table-header text-pink">发布者　：</td>
                <td><a class="bLinkDark" href="http://www.bshare.cn" target="_blank">bShare</a><div class="clear spacer10"></div></td>
            </tr>
            <tr>
                <td class="table-header text-pink" colspan="2">参与方式：<div class="clear spacer10"></div></td>
            </tr>
            <tr>
                <td colspan="2">
                    <p>1、 打开以下任意网站，点击分享按钮，将任意网页分享到新浪微博、腾讯微博、QQ空间、网易微博、搜狐微博、人人网、天涯社区或开心网等8大平台的至少一个平台；</p>
                    <div class="spacer10 clear"></div>
                    <p>2、   分享出去的链接， 每5次点击，可获取1个微积分。</p>
                    <div class="spacer10 clear"></div>
                    <p>3、   每人每个网站每天最多可获取20个积分， 每天参加的网站数量不限。 </p>
                    <div class="spacer10 clear"></div>
                    <p>4、   所获得的微积分在奖品区可兑换成各种奖品。</p>
                    <div class="spacer10 clear"></div>
                    <p>5、   10个积分可购买虚拟彩票，bShare每周会抽取彩票发放奖品。</p>
                </td>
            </tr>
        </table>
        <div class="clear"></div>
        
        <div class="wrapper-prods">
            <p class="text-pink left">奖品区：</p>
            <a class="partner-button bButton-pink right" href="${points_cxt_path}/shop/category/all" target="_blank">更多奖品</a>
            <div class="clear spacer15"></div>
            <div class="module-white-grey" style="padding: 20px;">
                <div class="fixed-prod">
                    <div class="card-prod left" prodId="1396">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1396" target="_blank" title="汉庭酒店200元入住大礼包"><img src="http://repo.bshare.cn/pointsImage/thumbnail/c/cYcAfhsXedCcqNGs.jpg" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1396" target="_blank" class="prod-title bLinkBlue heading3" title="汉庭酒店200元入住大礼包">汉庭酒店200元入住大礼包</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1396" target="_blank" class="prod-summary bLinkDark" title="汉庭酒店200元入住大礼包">汉庭酒店200元入住大礼包</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">4,500</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.htinns.com/" target="_blank">腾讯</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1396" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="card-prod left" prodId="1361">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1361" target="_blank" title="纯真闪闪星荷叶下摆长袖T恤"><img src="http://repo.bshare.cn/pointsImage/thumbnail/l/lzLXX2tRvW5vDNkG.jpg" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1361" target="_blank" class="prod-title bLinkBlue heading3" title="纯真闪闪星荷叶下摆长袖T恤">纯真闪闪星荷叶下摆长袖T恤</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1361" target="_blank" class="prod-summary bLinkDark" title="用户兑换成功后，将会获取由bShare赠与的电子密钥，用户凭借该密钥，可去梦芭莎网站0元购买该戒指。 兑换流程： 用户点击如下商品链接：http://union.moonbasa.com/rd/rd.aspx?e=-999&amp;adtype=5&amp;unionid=bshare&amp;subunionid=&amp;other=&amp;url=http://lady.moonbasa.com/p-032012158.html；点击购买，进入购买流程，在付款时输入在bShare获得的密钥，价格会自动调整为0。 
注意： 用户需遵循梦芭莎网站协定，自行承担商品运费，若购物总金额超过59元，梦芭莎免费包邮。">用户兑换成功后，将会获取由bShare赠与的电子密钥，用户凭借该密钥，可去梦芭莎网站0元购买该戒指。 兑换流程： 用户点击如下商品链接：http://union.moonbasa.com/rd/rd.aspx?e=-999&amp;adtype=5&amp;unionid=bshare&amp;subunionid=&amp;other=&amp;url=http://lady.moonbasa.com/p-032012158.html；点击购买，进入购买流程，在付款时输入在bShare获得的密钥，价格会自动调整为0。 
注意： 用户需遵循梦芭莎网站协定，自行承担商品运费，若购物总金额超过59元，梦芭莎免费包邮。</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">190</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://union.moonbasa.com/rd/rd.aspx?e=-999&adtype=0&unionid=bshare" target="_blank">梦芭莎</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1361" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="card-prod left" prodId="1370">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1370" target="_blank" title="大宝清爽保湿防晒露75g"><img src="http://repo.bshare.cn/pointsImage/thumbnail/6/680QmOkuvfZ2hlyw.png" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1370" target="_blank" class="prod-title bLinkBlue heading3" title="大宝清爽保湿防晒露75g">大宝清爽保湿防晒露75g</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1370" target="_blank" class="prod-summary bLinkDark" title="产品质地轻薄透气，易涂抹，无粘腻感。蕴含天然海藻萃取精华，富含多种海洋矿物，清爽防晒。同时抵御紫外线UVA、UVB（SPF20，PA++），减少肌肤晒伤，晒黑。添加SOD（超氧化物歧化酶）、保湿配方，持续保湿滋润。产品质地温和，适合与家人分享，建议每天使用。">产品质地轻薄透气，易涂抹，无粘腻感。蕴含天然海藻萃取精华，富含多种海洋矿物，清爽防晒。同时抵御紫外线UVA、UVB（SPF20，PA++），减少肌肤晒伤，晒黑。添加SOD（超氧化物歧化酶）、保湿配方，持续保湿滋润。产品质地温和，适合与家人分享，建议每天使用。</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">1,990</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.dabao.com/" target="_blank">大宝</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1370" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="card-prod left" prodId="1345">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1345" target="_blank" title="黄小琥演唱会门票"><img src="http://repo.bshare.cn/pointsImage/thumbnail/N/NvkIdDz0hwvmBGFE.jpg" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1345" target="_blank" class="prod-title bLinkBlue heading3" title="黄小琥演唱会门票">黄小琥演唱会门票</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1345" target="_blank" class="prod-summary bLinkDark" title="黄小琥演唱会门票，由聚橙网友情赞助。仅限成都和深圳演唱会可参加。
黄小琥&ldquo;对爱期待&rdquo;现场音乐会专题&gt;&gt;  http://www.juooo.com/zhuanti/2012hxh  
详细介绍： 　
她是台湾&ldquo;Pub女王&rdquo;、&ldquo;Live天后&rdquo; 、她是人人敬畏的&ldquo;灭绝师太&rdquo; 、她是华语乐坛的灵魂歌手、一曲《没那么简单》让人见识她的浑厚嗓音、她是黃小琥、从迷茫爱的可能，到思索爱的顺其自然、在痛里，逆流而上、在伤里，破茧而出、说到台湾的&ldquo;Pub女王&rdquo;、&ldquo;Live天后&rdquo;，人们不难想到黄小琥，这位在台湾甚至整个华语乐坛都具有很高声誉的灵魂歌手。出道二十余年依然在歌坛屹立不倒，在众多艺人当中已不多见。而黄小琥独特的嗓音和强大的现场感染力，更使得一批忠实的Fans为她倾倒。
演出订票： http://www.juooo.com/show/1882/info  
">黄小琥演唱会门票，由聚橙网友情赞助。仅限成都和深圳演唱会可参加。
黄小琥&ldquo;对爱期待&rdquo;现场音乐会专题&gt;&gt;  http://www.juooo.com/zhuanti/2012hxh  
详细介绍： 　
她是台湾&ldquo;Pub女王&rdquo;、&ldquo;Live天后&rdquo; 、她是人人敬畏的&ldquo;灭绝师太&rdquo; 、她是华语乐坛的灵魂歌手、一曲《没那么简单》让人见识她的浑厚嗓音、她是黃小琥、从迷茫爱的可能，到思索爱的顺其自然、在痛里，逆流而上、在伤里，破茧而出、说到台湾的&ldquo;Pub女王&rdquo;、&ldquo;Live天后&rdquo;，人们不难想到黄小琥，这位在台湾甚至整个华语乐坛都具有很高声誉的灵魂歌手。出道二十余年依然在歌坛屹立不倒，在众多艺人当中已不多见。而黄小琥独特的嗓音和强大的现场感染力，更使得一批忠实的Fans为她倾倒。
演出订票： http://www.juooo.com/show/1882/info  
</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">10,000</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://juooo.com/" target="_blank">聚橙网</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1345" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="card-prod left" prodId="1394">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1394" target="_blank" title="强生婴儿强生驱蚊液100ml"><img src="http://repo.bshare.cn/pointsImage/thumbnail/3/3EU04cfUAnzhHNk6.jpg" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1394" target="_blank" class="prod-title bLinkBlue heading3" title="强生婴儿强生驱蚊液100ml">强生婴儿强生驱蚊液100ml</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1394" target="_blank" class="prod-summary bLinkDark" title="功效：有效防蚊可达5小时，不含酒精。
使用方法：将驱蚊液倒在手中，涂抹于易受蚊子叮咬处即可，每四小时涂抹，防蚊效果更佳。
">功效：有效防蚊可达5小时，不含酒精。
使用方法：将驱蚊液倒在手中，涂抹于易受蚊子叮咬处即可，每四小时涂抹，防蚊效果更佳。
</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">920</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.jnj.com.cn/" target="_blank">强生</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1394" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="clear spacer30"></div>
                    <div class="spacer1 clear" style="border-bottom: 1px solid #dadada;"></div>
                    <div class="clear spacer15"></div>
                    
                    <div class="card-prod left" prodId="1348">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1348" target="_blank" title="卡当单品30元现金抵用券"><img src="http://repo.bshare.cn/pointsImage/thumbnail/2/25MCPfZJBVdqjuWn.jpg" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1348" target="_blank" class="prod-title bLinkBlue heading3" title="卡当单品30元现金抵用券">卡当单品30元现金抵用券</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1348" target="_blank" class="prod-summary bLinkDark" title="卡当锁爱钛钢情侣项链30元抵用券(包邮)  

http://www.kadang.com/diy/detail1595-2.html?from=bSharejf">卡当锁爱钛钢情侣项链30元抵用券(包邮)  

http://www.kadang.com/diy/detail1595-2.html?from=bSharejf</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">10</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.kadang.com/" target="_blank">卡当网</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1348" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="card-prod left" prodId="1354">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1354" target="_blank" title="麦德龙10元现金券"><img src="http://repo.bshare.cn/pointsImage/thumbnail/8/8vcAcldaFAgdeuCM.jpg" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1354" target="_blank" class="prod-title bLinkBlue heading3" title="麦德龙10元现金券">麦德龙10元现金券</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1354" target="_blank" class="prod-summary bLinkDark" title="麦德龙10元现金抵用券，凭此券可直接去麦德龙商城购物，享受全场购物满100减10元的现金抵扣优惠。">麦德龙10元现金抵用券，凭此券可直接去麦德龙商城购物，享受全场购物满100减10元的现金抵扣优惠。</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">150</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.metromall.com.cn/#r-pbShare" target="_blank">麦德龙</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1354" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="card-prod left" prodId="1352">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1352" target="_blank" title="热带海风野性气质撞色斜挎女包"><img src="http://repo.bshare.cn/pointsImage/thumbnail/g/ggwDivzEDOqqirkQ.jpg" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1352" target="_blank" class="prod-title bLinkBlue heading3" title="热带海风野性气质撞色斜挎女包">热带海风野性气质撞色斜挎女包</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1352" target="_blank" class="prod-summary bLinkDark" title="热带海风野性气质撞色斜挎女包">热带海风野性气质撞色斜挎女包</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">13,000</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.forbag.cn/" target="_blank">寻包网</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1352" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="card-prod left" prodId="1351">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1351" target="_blank" title="梦之境休闲甜美单肩包"><img src="http://repo.bshare.cn/pointsImage/thumbnail/g/g3hmBoe460eK56Fk.jpg" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1351" target="_blank" class="prod-title bLinkBlue heading3" title="梦之境休闲甜美单肩包">梦之境休闲甜美单肩包</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1351" target="_blank" class="prod-summary bLinkDark" title="梦之境休闲甜美单肩包">梦之境休闲甜美单肩包</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">15,000</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.forbag.cn/" target="_blank">寻包网</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1351" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="card-prod left" prodId="1350">
                        <a class="prod-image" href="${points_cxt_path}/shop/product/1350" target="_blank" title="卡当单品50元现金抵用券"><img src="http://repo.bshare.cn/pointsImage/thumbnail/E/ETmYgS8Pjt8kbOJx.jpg" /></a>
                        <div class="spacer10"></div>
                        <a href="${points_cxt_path}/shop/product/1350" target="_blank" class="prod-title bLinkBlue heading3" title="卡当单品50元现金抵用券">卡当单品50元现金抵用券</a>
                        <div class="spacer5"></div>
                        <a href="${points_cxt_path}/shop/product/1350" target="_blank" class="prod-summary bLinkDark" title="天然南非AA级红虎眼情侣手链(包邮）

http://www.kadang.com/diy/detail3925.html?from=bSharejf">天然南非AA级红虎眼情侣手链(包邮）

http://www.kadang.com/diy/detail3925.html?from=bSharejf</a>
                        <div class="spacer5"></div>
                        <p class="prod-points heading4"><span class="text-blue" style="display: block;margin-bottom: 5px;">兑换：</span><span class="text-blue keyword" style="margin-left: 0; font-size:14px;">10</span>微积分</p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="http://www.kadang.com/" target="_blank">卡当网</a></p>
                        <div class="spacer10"></div>
                        <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/1350" target="_blank">查看详细</a></div>
                        <div class="clear"></div>
                    </div>

                </div>
                <div class="clear spacer15"></div>
            </div>
        </div>
        <div class="clear"></div>
        
        <div class="wrapper-clients">
            <p class="text-pink left">参与活动网站</p>
            <a class="bButton-pink right" href="${points_cxt_path}/intro/qixi2012" target="_blank">加入参与网站</a>
            <div class="clear spacer15"></div>
            <a class="card-client left" title="chinaZ" href="http://bbs.chinaz.com/Club/list-1.html" target="_blank">
                <img src="${points_image_path}/events/qixi/clients/chinaz.png" />
                <div class="clear spacer10"></div>
                <span>chinaZ</span>
            </a>
            <a class="card-client left" title="A5站长网" href="http://www.admin5.com/browse/177/index.shtml" target="_blank">
                <img src="${points_image_path}/events/qixi/clients/a5.png" />
                <div class="clear spacer10"></div>
                <span>A5站长网</span>
            </a>
            <a class="card-client left" title="车主之家" href="http://www.16888.com/" target="_blank">
                <img src="${points_image_path}/events/qixi/clients/16888.png" />
                <div class="clear spacer10"></div>
                <span>车主之家</span>
            </a>
            <a class="card-client left" title="中国娱乐网" href="http://www.67.com" target="_blank">
                <img src="${points_image_path}/events/qixi/clients/67.png" />
                <div class="clear spacer10"></div>
                <span>中国娱乐网</span>
            </a>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
        
	    <div class="wrapper-footer">
	        <div class="clear spacer20"></div>
	        <p>若在活动的过程中，有任何问题，您可以点击&nbsp;<a class="bLinkBlue" target="_blank" href="mailto:feedback@bshare.cn" 
	            title="feedback@bshare.cn">这里</a>&nbsp;给我们发送邮件或和我们的&nbsp;<a class="bLinkBlue" href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" 
	            target="_blank">在线客服</a>&nbsp;联络。本次活动最终解释权归&nbsp;<a class="bLinkBlue" href="${points_cxt_path}" target="_blank">微积分</a>&nbsp;所有</p>
	    </div>
	    <div class="clear"></div>
	</div>
    <div class="clear spacer30"></div>
    <%@ include file="/jsp/common/bottomMenu.jsp"%>
    
<script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/button.js#uuid=${bSharePointsUuid}&amp;style=-1"></script>
<script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/bshareC0.js"></script>
<script type="text/javascript" charset="utf-8">
$(function() {
    bShare.addEntry({
    	title: '七夕情人节 约“惠”微积分',
        summary: '亲，今年七夕你约“惠”了吗，微积分分享就有好礼送噢！',
        vUid: '<s:property value="%{#session.USER_ID}"/>', 
        vEmail: '<s:property value="%{#session.DISPLAY_NAME}"/>', 
        vTag: 'WEIJIFEN'
    });
});
</script>
<script type="text/javascript" charset="utf-8">

</script>
</body>
</html>
