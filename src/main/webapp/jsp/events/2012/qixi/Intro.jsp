<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<meta name="description" content="七夕情人节约惠微积分是bShare推出的一档节日优惠活动只要您在活动期间进行分享便可获得积分兑换成各种礼物" />
<meta name="keywords" content="七夕活动,七夕情人节,七夕情人节约惠微积分" />
<meta name="author" content="Buzzinate" />
<title>七夕活动,七夕情人节，约惠微积分，七夕约惠微积分分享有好礼 - <s:text name="bshare.points.title"/></title>


<style>
.text-pink { color: #ff0036; }
.text-note { font-size: 12px; }
.container-intro { padding: 20px; }
.introTable { table-layout: fixed; }
.introTable td { padding: 5px 0; text-align: left; }
.introTable img { border: 1px solid #dadada; }
.table-header { width: 80px; }
</style>

<div class="container-center">
    <div class="module-white-grey container-intro">
	    <div class="wrapper-image"><img src="${points_image_path}/events/qixi/banner.jpg" /></div>
	    <div class="clear spacer20"></div>
	    <table class="introTable">
            <tr>
                <td class="table-header text-pink">时间周期： </td>
                <td>8.23&nbsp;–&nbsp;9.22</td>
            </tr>
            <tr>
                <td class="table-header text-pink">发布者　：</td>
                <td>bShare</td>
            </tr>
            <tr>
                <td colspan="2" class="text-pink"><div class="spacer15 clear"></div>参赛方式：</td>
            </tr>
            <tr>
                <td colspan="2">bShare微积分平台联合汉庭酒店，在七夕期间（<span class="text-pink">2012年8月23日—9月22日</span>）
                在各大网站发起“<span class="text-pink">分享送汉庭酒店200元入住大礼包</span>”活动。凡在活动期间，在合作网站上将合作网站的内容分享到指定的八大平台（新浪微博、腾讯微博、QQ空间、sohu微博、网易微博、人人网、开心网、天涯微博）的所有用户，
                只要用户分享的内容链接被他人（自己点击无效）点击了5次回到原分享网站，即可获得200元入住大礼包，全国均可享受。</td>
            </tr>
            <tr>
                <td colspan="2" class="text-pink"><div class="spacer15 clear"></div>凡参与此活动的网站需具体以下条件：</td>
            </tr>
            <tr>
                <td colspan="2">
                    <p>1. 本身网站已安装好bShare Plus分享代码；</p>
                    <div class="spacer5 clear"></div>
                    <p>2. 网站在微积分平台购买积分、发起活动；1元=100个微积分；</p>
                    <div class="spacer5 clear"></div>
                    <p>3. 网站PV>100万/天（可酌情选择）；</p>
                    <div class="spacer5 clear"></div>
                    <p>4. 网站相应位置，会有一个活动介绍页面，详细介绍此次活动，让用户知晓此次活动，更主动来参加此次活动，从而为网站带来流量的提升。</p>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="text-pink"><div class="spacer15 clear"></div>网站参与活动详细流程：</td>
            </tr>
            <tr>
                <td colspan="2">
                    <p>1. 网站若已安装bShare分享代码，先检查自己网站中的分享代码是否为bShare Plus；普通的bShare代码中含有buttonLite.js，而bShare Plus分享代码中含有button.js；可将buttonLite.js直接修改成button.js即可由普通分享代码变为bShare Plus。</p>
                    <div class="spacer15 clear"></div>
                    <p class="text-pink text-note">检查方法：</p>
                    <div class="spacer5 clear"></div>
                    <p class="text-note">A. 打开自己的网站，随意打开一个添加有bShare分享按钮的页面：</p>
                    <div class="spacer5 clear"></div>
                    <p class="text-note">B. 点击鼠标右键，选择“查看网页源代码（V）”，进入源代码页面，ctrl+F（查询功能），在页面最右上角出现的的查询框内输入button.js；</p>
                    <div class="spacer5 clear"></div>
                    <p class="text-note">若出现该代码，则证明您页面安装的是plus的分享代码；</p>
                    <div class="spacer5 clear"></div>
                    <p class="text-note">若查询出现buttonLite.js，则证明您使用的是bShare普通分享代码。需将buttonLite.js修改成button.js即可；</p>
                    <div class="spacer15 clear"></div>
                    <p>2. 安装好bShare plus分享代码后，登录<a class="bLinkBlue" target="_blank" 
                        href="${points_cxt_path}/shop">bShare微积分平台页面</a>，进入<a class="bLinkBlue" target="_blank" 
                        href="${points_cxt_path}/help/pRule">站长用户使用说明</a>，点击第2步的提示即可自动转换为站长用户，可以充值微积分、发起活动了。如下图：</p>
                    <div class="spacer15 clear"></div>
                    <img src="${points_image_path}/events/qixi/intro1.jpg" />
                    <div class="spacer15 clear"></div>
                    <p>3. 充值微积分，一个微积分可兑换一个200元汉庭酒店大礼包，网站根据自己网站用户需求状况确定需要发放多少个汉庭酒店的大礼包。</p>
                    <div class="spacer15 clear"></div>
                    <p>4. 充值成功，进入<a class="bLinkBlue" target="_blank" 
                        href="${points_cxt_path}/publisher/activity/list">活动管理页面</a>，发起活动；奖励规则、活动描述可以自己设定；除“汉庭200元入住大礼包”，亦可选择发放其他礼品；</p>
                    <div class="spacer15 clear"></div>
                    <p>5. 在自己网站分享按钮旁设置一个说明，介绍此次“分享送酒店”活动，或者在网站显眼位置，引导用户来参加“分享送酒店”，进行主动分享。案例如下：</p>
                    <div class="spacer15 clear"></div>
                    <img src="${points_image_path}/events/qixi/intro2.jpg" />
                    <div class="spacer15 clear"></div>
                    <p>6. 网站提供自己网站的logo和网站链接给到bShare相应工作人员，放到bShare活动页面，引导bShare网站的注册用户去各大发起活动的网站参与分享、获得大礼包。</p>
                </td>
            </tr>
        </table>
        <div class="spacer20 clear"></div>
        <a class="bButton-blue right" style="padding: 5px 25px; text-align: center;" href="${points_cxt_path}/events/qixi2012" target="_blank">返回活动页</a>
        <div class="spacer20 clear"></div>
    </div>
</div>
