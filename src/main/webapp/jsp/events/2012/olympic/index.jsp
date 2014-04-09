<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%pageContext.setAttribute("bSharePointsUuid",com.buzzinate.common.util.ConfigurationReader.getString("bshare.points.uuid")); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Language" content="${curLang}" />
    <meta name="description" content="现在开始，只要您在展示有“伦敦2012助威”活动的网站中进行分享并为网站带来回流，即可从中获取助威积分，并兑换奖品，参与分享为伦敦2012助威加油。" />
    <meta name="keywords" content="伦敦2012助威 , 分享获积分, 微积分助威伦敦2012, bshare分享 , bShare分享获积分, bShare微积分" />
    <meta name="author" content="Buzzinate" />

    <title>玩赚"微积分"，为中国助威 - bShare携手站长助威伦敦2012 - <s:text name="bshare.points.title"/></title>

    <link rel="stylesheet" href="${points_css_path}/bsharePoints.css" type="text/css" />
    <style type="text/css">
body { background: #e9eaeb; }
.container-nav { background: #0097d2; }
.container-logo { display: none; }
.main-bottom-menu { background: #ddd !important; }
.main-bottom-menu .text-white, .web-base-links a, .main-bottom-copyright, .main-bottom-copyright a { color: #333 !important; }

.container-event { background: url(${points_image_path}/events/olympic/bkg-body.jpg) no-repeat; padding-top: 160px; width: 980px; position: relative; }
.partner-button { font-size: 12px; padding: 4px 15px; text-align: center; width: 100px; }
.wrapper-intro { margin-left: 20px; padding:20px 0px; width: 460px; color: #353535; }
.wrapper-prods, .wrapper-clients, .wrapper-parts, .wrapper-footer { padding: 20px 30px; color: #4b4b4b; overflow: hidden; }
.wrapper-rule { margin: 20px 30px; }
.table-header { width: 80px; }
.slide-prods { height: 366px; overflow: hidden; }
.card-prod { width: 152px; margin: 0 11px;_margin:0 10px; text-align: center;}
.slide-prods .card-prod { display: none; }
.prod-image { border: 1px solid #dadada; width: 150px; height: 150px; display: block; }
.prod-image img { display: block; margin: 0 auto; }
.card-prod a { text-decoration: none; }
.prod-title { height: 24px; line-height: 24px; display: block; overflow: hidden; word-wrap: break-word; word-break: break-all; }
.prod-summary { color: #555; font-size: 12px; height: 45px; line-height: 15px; display: block; overflow: hidden; word-wrap: break-word; word-break: break-all; }
.prod-points { font-size: 12px !important; }
.prod-button { padding: 6px 30px; font-size: 12px; margin-top: 10px; }
.prod-boss{font-size:12px;color:#666;height:16px;overflow:hidden;text-align:left;word-wrap:break-word;word-break:break-all;}
.prod-boss .tag{display:block;width:48px;float:left;}
.prod-boss .name{display:block;width:104px;overflow:hidden;float:left;}
.card-client{ width: 110px; text-align: center; margin: 10px 36px; color:#333; text-decoration:none;overflow:hidden;}
.card-client img { width: 110px; height: 46px; display: block; background: #fff; }
.wrapper-parts { padding-top: 0; }
.slideParts { height: 130px; overflow: hidden; }
.slidePartsCon { zoom: 1; }
.card-part { margin-bottom: 10px; width: 440px; padding-right: 20px; float: left; color:#333; white-space: nowrap; height: 16px;
    text-overflow: ellipsis; overflow: hidden; word-break: break-all; }
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
	
	<div class="container-center container-event">
	    <div class="wrapper-intro">
	        <p class="text-orange">玩赚"微积分"，为中国助威</p>
	        <div class="clear spacer10"></div>
	        <p style="text-indent:25px;line-height:26px;">现在开始，只要您在以下参与活动的网站中，进行任意一次分享，将网站推介给你的好友，并为网站带来点击。即可获取助威积分，积分还能兑换成各种奖品，参与分享为伦敦&nbsp;&nbsp;2012&nbsp;&nbsp;助威加油。
</p>
	        <p style="text-indent:25px;line-height:26px;">bShare 携手微积分与您一起为伦敦加油，为 &nbsp;&nbsp;2012&nbsp;&nbsp;加油，玩赚“微积分”，为中国助威。</p>
	    </div>
	    <div class="spacer100"></div>
	    <div class="clear spacer100"></div>
	    
        <div class="bshare-custom icon-medium right" style="margin-top: -50px;">
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
        
        <table class="wrapper-rule">
            <tr>
                <td class="table-header text-orange">时间周期：</td>
                <td>即日起&nbsp;-&nbsp;8.12<div class="clear spacer5"></div></td>
            </tr>
            <tr>
                <td class="table-header text-orange">奖励额度：</td>
                <td>2012&nbsp;积分<div class="clear spacer5"></div></td>
            </tr>
            <tr>
                <td class="table-header text-orange">发布者　：</td>
                <td><a class="bLinkBlue" href="http://www.bshare.cn" target="_blank">bShare</a><div class="clear spacer5"></div></td>
            </tr>
            <tr>
                <td class="table-header text-orange" colspan="2"><div class="spacer20 clear"></div>任务描述：<div class="clear spacer5"></div></td>
            </tr>
            <tr>
                <td colspan="2">
                    <p>1、在以下<a href="#participants" class="bLinkBlue" target="_self">任意网站</a>进行分享，并带来回流即可获取bShare送出的微积分。 </p>
                    <div class="spacer5 clear"></div>
                    <p>1.1 每5次回流可获取1个积分。 </p>
                    <div class="spacer5 clear"></div>
                    <p>1.2 每个网站每天可获取的积分上限为20个。 </p>
                    <div class="spacer5 clear"></div>
                    <p>1.3 用户每天参加的网站不限。 </p>
                    <div class="spacer15 clear"></div>
                    
                    <p>2、所获得微积分在奖品区可兑换成各种奖品。</p>
                    <div class="spacer5 clear"></div>
                    
                    <p>3、您也可以选择使用10个积分购买虚拟彩票，我们每周会在其中抽取中奖彩票发放奖品。 </p>
                </td>
            </tr>
        </table>
        <div class="clear"></div>
        
        <div class="wrapper-prods">
            <p class="text-orange left">奖品区：</p>
	        <a class="partner-button bButton-blue right" href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" target="_blank">加入奖品区</a>
            <div class="clear spacer15"></div>
            <div class="module-white-grey" style="padding: 20px;">
                <div class="fixed-prod">
                    <s:iterator value="#request.products" var="prod" status="status"><s:if test="%{#status.count <= 5}">
	                <div class="card-prod left" prodId="${prod.id}">
	                    <a class="prod-image" href="${points_cxt_path}/shop/product/${prod.id}" target="_blank" title="${prod.name}"><img src="${prod.thumbnail}" /></a>
	                    <div class="spacer10"></div>
	                    <a href="${points_cxt_path}/shop/product/${prod.id}" target="_blank" class="prod-title bLinkBlue heading3" title="${prod.name}">${prod.name}</a>
	                    <div class="spacer5"></div>
	                    <a href="${points_cxt_path}/shop/product/${prod.id}" target="_blank" class="prod-summary bLinkDark" title="${prod.desc}">${prod.desc}</a>
	                    <div class="spacer5"></div>
	                    <p class="prod-points heading4"><s:text name="bshare.points.need.points"><s:param value="%{#prod.currentPoints}"/></s:text></p>
			            <div class="clear spacer10"></div>
			            <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="${prod.merchant.homeURLPrefix}" target="_blank">${prod.merchant.name}</a></p>
	                    <div class="spacer10"></div>
	                    <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/${prod.id}" target="_blank">查看详细</a></div>
	                    <div class="clear"></div>
	                </div>
	                </s:if></s:iterator>
                </div>
                <div class="clear spacer30"></div>
                <div class="spacer1 clear" style="border-bottom: 1px solid #dadada;"></div>
                <div class="clear spacer15"></div>
                <div class="slide-prods">
                    <s:iterator value="#request.allProducts" var="prod" status="status">
	                <div class="card-prod left" prodId="${prod.id}">
	                    <a class="prod-image" href="${points_cxt_path}/shop/product/${prod.id}" target="_blank" title="${prod.name}"><img file="${prod.thumbnail}" /></a>
	                    <div class="spacer10"></div>
	                    <a href="${points_cxt_path}/shop/product/${prod.id}" target="_blank" class="prod-title bLinkBlue heading3" title="${prod.name}">${prod.name}</a>
	                    <div class="spacer15"></div>
	                    <a href="${points_cxt_path}/shop/product/${prod.id}" target="_blank" class="prod-summary bLinkDark" title="${prod.desc}">${prod.desc}</a>
	                    <div class="spacer5"></div>
	                    <p class="prod-points heading4"><s:text name="bshare.points.need.points"><s:param value="%{#prod.currentPoints}"/></s:text></p>
                        <div class="clear spacer10"></div>
                        <p class="prod-boss"><span class="tag">提供商：</span><a class="bLinkBlue name" href="${prod.merchant.homeURLPrefix}" target="_blank">${prod.merchant.name}</a></p>
                        <div class="spacer10"></div>
	                    <div class="center"><a class="prod-button bButton-blue" href="${points_cxt_path}/shop/product/${prod.id}" target="_blank">查看详细</a></div>
	                    <div class="clear"></div>
	                </div>
	                </s:iterator>
	                <div class="clear"></div>
                </div>
                <div class="clear spacer15"></div>
            </div>
        </div>
        <div class="clear"></div>
        
        <div class="wrapper-clients">
            <p class="text-orange left">参与活动网站</p>
            <a class="partner-button bButton-blue right" href="${main_cxt_path}/olympic" target="_blank">加入助威网站</a>
            <div class="clear spacer15"></div>
            <a class="card-client left" title="A5站长网" href="http://www.admin5.com/browse/177/index.shtml" target="_blank">
                <img src="${points_image_path}/events/olympic/clients/a5.png" />
                <div class="clear spacer10"></div>
                <span>A5站长网</span>
            </a>
            <a class="card-client left" title="chinaZ" href="http://bbs.chinaz.com/Club/list-1.html" target="_blank">
                <img src="${points_image_path}/events/olympic/clients/chinaz.png" />
                <div class="clear spacer10"></div>
                <span>chinaZ</span>
            </a>
            <a class="card-client left" title="强生" href="http://www.jnj.com.cn/" target="_blank">
                <img src="${points_image_path}/events/olympic/clients/qiangsheng.png" />
                <div class="clear spacer10"></div>
                <span>强生</span>
            </a>
            <a class="card-client left" title="Hishop" href="http://www.hishop.com.cn" target="_blank">
                <img src="${points_image_path}/events/olympic/clients/hishop.png" />
                <div class="clear spacer10"></div>
                <span>Hishop</span>
            </a>
            <a class="card-client left" title="深圳之窗" href="http://www.sz.net.cn/" target="_blank">
                <img src="${points_image_path}/events/olympic/clients/shenzheng.png" />
                <div class="clear spacer10"></div>
                <span>深圳之窗</span>
            </a>
            <a class="card-client left" title="中国娱乐网67.com" href="http://www.67.com/" target="_blank">
                <img src="${points_image_path}/events/olympic/clients/yule.png" />
                <div class="clear spacer10"></div>
                <span>中国娱乐网</span>
            </a>
            <a class="card-client left" title="中国日报" href="http://2012.chinadaily.com.cn/" target="_blank">
                <img src="${points_image_path}/events/olympic/clients/chinadaily.png" />
                <div class="clear spacer10"></div>
                <span>中国日报</span>
            </a>
            <a class="card-client left" title="大宝" href="http://www.dabao.com/" target="_blank">
                <img src="${points_image_path}/events/olympic/clients/dabao.png" />
                <div class="clear spacer10"></div>
                <span>大宝</span>
            </a>
	        <div class="clear"></div>
        </div>
        <div class="clear"></div>
        
        <div id="participants" class="wrapper-parts">
            <div class="spacer1 clear" style="border-bottom: 1px dashed #ccc;"></div>
            <div class="clear spacer20"></div>
            <div class="slideParts">
            	<div class="slidePartsCon">
					<s:iterator value="#request.activities" var="activity" status="status">
		            <a class="card-part bLinkDark left" href="${activity.publisherSitePrefix}" target="_blank" title="${activity.publisherName}">${activity.publisherName}</a>
		            </s:iterator>
		            <div class="clear"></div>
				</div>
            </div>
        </div>
        <div class="clear"></div>
        
        <div class="wrapper-footer">
            <div class="clear spacer20"></div>
            <p>若在活动的过程中，有任何问题，您可以点击&nbsp;<a class="bLinkBlue" target="_blank" href="mailto:feedback@bshare.cn" 
                title="feedback@bshare.cn">这里</a>&nbsp;给我们发送邮件或和我们的&nbsp;<a class="bLinkBlue" href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" 
                target="_blank">在线客服</a>&nbsp;联络。本次活动最终解释权归&nbsp;<a class="bLinkBlue" href="${points_cxt_path}" target="_blank">微积分</a>&nbsp;所有</p>
        </div>
        <div class="clear spacer30"></div>
	</div>
    <div class="clear"></div>
    
    <%@ include file="/jsp/common/bottomMenu.jsp"%>
    
<script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/button.js#uuid=${bSharePointsUuid}&amp;style=-1"></script>
<script type="text/javascript" charset="utf-8" src="${static_cxt_path}/b/bshareC0.js"></script>
<script type="text/javascript" charset="utf-8">
$(function() {
    bShare.addEntry({
    	title: '玩赚"微积分"，为中国助威',
        summary: '现在开始，只要您在展示有“伦敦2012助威”活动的网站中进行分享并为网站带来回流，即可从中获取助威积分，并兑换奖品，参与分享为伦敦2012助威加油。',
        vUid: '<s:property value="%{#session.USER_ID}"/>', 
        vEmail: '<s:property value="%{#session.DISPLAY_NAME}"/>', 
        vTag: 'WEIJIFEN'
    });
});
</script>
<script type="text/javascript" charset="utf-8">
var IMAGE_PER_SLIDE = 5, PARTS_PER_SLIDE = 5, PARTS_HEIGHT = 130;
function initProdSlide() {
	var prodIndex = 0, prodSlides = $(".slide-prods .card-prod");
	$(".fixed-prod .card-prod").each(function () {
		if ($(".slide-prods .card-prod[prodId=" + $(this).attr("prodId") + "]").length > 0) {
			$(".slide-prods .card-prod[prodId=" + $(this).attr("prodId") + "]").remove();
		}
	});
    if ($(".slide-prods .card-prod").length <= IMAGE_PER_SLIDE) {
        return;
    }
	prodSlides = $(".slide-prods .card-prod");
	var prodSlide = function () {
	    prodSlides.hide();
	    var exceeded = (prodIndex + 1) * IMAGE_PER_SLIDE > prodSlides.length;
	    var max = exceeded ? prodSlides.length : (prodIndex + 1) * IMAGE_PER_SLIDE;
	    for (var i = prodIndex * IMAGE_PER_SLIDE; i < max; ++i) {
	        var prodImg = prodSlides.eq(i).find("img");
	        if (!prodImg.attr("src")) {
	            prodImg.attr("src", prodImg.attr("file"));
	        }
	        prodSlides.eq(i).fadeIn();
	    }
	    prodIndex = exceeded ? 0 : prodIndex + 1;
	    setTimeout(prodSlide, 5000);
	};
	prodSlide();
}

function initPartSlide(){
	var lens = $(".slidePartsCon a").length;
	if (lens <= 10) {
		return;
	}
	var partIndex = 0, lines = Math.ceil(lens/10);
    
    var partSlide = function () {
        if (partIndex >= lines) {
            partIndex = 0;
            $(".slidePartsCon").css({ "margin-top": PARTS_HEIGHT + "px" });
        }
        var offsetTop = partIndex * PARTS_HEIGHT / -1;
        $(".slidePartsCon").animate({
            marginTop: offsetTop + "px"
        }, 500);
        partIndex += 1;
        setTimeout(partSlide, 5000);
    };
    partSlide();
}

$(function() {
	initProdSlide();
	initPartSlide();
});
</script>
</body>
</html>
