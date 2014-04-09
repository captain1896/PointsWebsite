<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
pageContext.setAttribute("bSharePointsUuid",com.buzzinate.common.util.ConfigurationReader.getString("bshare.points.uuid"));
%>
<meta name="description" content="现在在微积分参与由${request.activity.publisherName}发起的${request.activity.name}即可获取微积分，更多积分活动尽在微积分网站。" />
<meta name="keywords" content="${request.activity.name}, ${request.activity.publisherName}, 参与活动赚取积分, 微积分, 分享获取积分, 积分兑换商品" />
<title>${request.activity.name} - 所有活动 - <s:text name="bshare.points.title"/></title>

<style>
    .module-white-grey { padding: 20px; }
    .container-activity { width: 720px; position: relative; }
    .card-activity { zoom: 1; overflow: hidden; padding-left: 20px; color: #333; position: relative; height: 122px; }
    .card-activity p { font-size: 12px; margin: 0 0 7px;}
    .activity-image { width: 120px; height: 120px; border: 1px solid #dadada; }
    .activity-image img { display: block; margin: auto; }
    .activity-title { height: 24px; line-height: 24px; overflow: hidden; }
    .activity-button { position: absolute; right: 0; bottom: 0; padding: 6px 51px; font-size: 12px; cursor: default; }
    .activity-button:hover { opacity: 1.0; border-color: #42C1F4; }
    .separator { background: #dadada; }
    .bInputLabel { width: 100px; }
    
    .wrapper-intro p { word-wrap: break-word; line-height: normal !important; }
    .intro-content { padding: 20px; margin-top: -1px; }
    
    #prodList { background: url(${points_image_path}/bkg-grey-white.gif) repeat-x #fff; width: 200px; border: 1px solid #ddd; position: relative; }
    .text-vert-align { vertical-align: text-bottom; font-size: 12px; }
    .container-prods .wrapper-header { left: 5px !important; }
    
    .activity-state {color: #5d5d5d;font-size: 12px;position: absolute;right: 20px;top: 60px;}
    .activity-state strong{color: #1e9ede; }
    .shareProgressDiv{ font-size:12px;}
    .shareProgressDiv p{ font-size:12px; float:left;}
    .shareProgressDiv .progressItem{ color:#5d5d5d;}
    .shareProgressDiv table { float:right; }    
    .shareProgressDiv table td { padding:0 0 3px 3px; font-size:12px; } 
    .progressPre{ width:147px; height:12px; display:block; background:url(${points_image_path}/allProgress.jpg) no-repeat 0 0; position:relative;  }
    .allProgress{ display:none;}
    .presProgress{ width:147px; height:12px; display:block; background:url(${points_image_path}/presProgress.jpg) no-repeat 0 0; display: block; text-indent:-9999px; float:left}
    .progressPre span{ width:40px; line-height:12px; overflow:hidden; text-align:center; position:absolute; z-index:100; margin:0 auto; left:50%; margin-left:-20px; font-size:10px; color: #444; }
    
</style>

<div class="container-center">
	<div class="container-breadcrumbs">
	    <a class="bLinkDark" href="${points_cxt_path}"><s:text name="bshare.points.title"/></a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/shop/activities">所有活动</a>
	    <span>&gt;</span>
	    <a class="bLinkDark" href="${points_cxt_path}/shop/activity/${request.activity.id}">${request.activity.name}</a>
	</div>
	<div class="spacer20 clear"></div>
	
	<div class="module-white-grey container-activity left">
	    <div class="wrapper-activity">
	        <div class="activity-title text-blue heading1">${request.activity.name}</div>
            <div class="clear spacer15"></div>
            <img src="${points_image_path}/preview-button.jpg" />
            <div class="clear spacer15"></div>
	        <div class="activity-image left"><img title="${request.activity.name}" src="${activity.picUrl}" /></div>
	        <div class="card-activity">
	            <s:iterator value="#request.activity.pointRules" var="rule" status="status">
		              <!--egedo -->
                        <s:if test="%{#rule.shareRule}">
                            <div class="shareProgressDiv">
                            <p>
                            <span class=" bInputLabel">分享奖励</span>
                            <span>：</span>
                                                                                                                每<span class="text-blue keyword " style="font-size:14px;">${rule.num}</span>次分享可获
                                <span class="text-blue keyword " style="font-size:14px;">${rule.points}</span>
                                <span><s:text name="bshare.points.point"/></span></p>
                         <div class="clear"></div>   
                            </div>
                      </s:if>		              
				</s:iterator>
	            <s:iterator value="#request.activity.pointRules" var="rule" status="status">
		             <!-- egedo --> 
                     <s:if test="%{#rule.clickBackRule}">
                         <div class="shareProgressDiv">
                            <p>
                            <span class="text-vert-align bInputLabel">回流奖励</span>
                            <span class="text-vert-align">：</span>
                                每<span class="text-blue keyword text-vert-align" style="font-size:14px;">${rule.num}</span>次回流可获
                                <span class="text-blue keyword text-vert-align" style="font-size:14px;">${rule.points}</span>
                                <span class="text-vert-align"><s:text name="bshare.points.point"/></span>
                                
                        </p>
                        <div class="clear"></div>   
                        </div>
                      </s:if>
		              
                </s:iterator>
	            <p>
	                <span class="text-vert-align bInputLabel">总投放<s:text name="bshare.points.point"/></span>
	                <span class="text-vert-align">：</span>
	                <span><s:text name="bshare.points.number.format"><s:param value="#request.activity.totalPoints"></s:param></s:text>&nbsp;&nbsp;<s:text name="bshare.points.point"/></span>
	            </p>
	            <p>
	                <span class="text-vert-align bInputLabel">剩余<s:text name="bshare.points.point"/></span>
	                <span class="text-vert-align">：</span>
	                <span><s:text name="bshare.points.number.format"><s:param value="#request.activity.leftPoints"></s:param></s:text>&nbsp;&nbsp;<s:text name="bshare.points.point"/></span>
	            </p>
	            <p>
	                <span class="text-vert-align bInputLabel">活动时间</span>
	                <span class="text-vert-align">：</span>
	                <span><s:date name="#request.activity.startDate" format="yyyy-MM-dd"/> <s:text name="bshare.shop.activity.date.mid"/><s:date name="#request.activity.endDate" format="yyyy-MM-dd"/></span>
	            </p>
	            <a class="activity-button bButton-blue" href="javascript:;">立即参加</a>
	        </div>
	    </div>
	    <div class="spacer30 clear"></div>
        <div class="spacer1 clear separator"></div>
	    <div class="wrapper-intro">
            <div id="activityIntro" class="intro-content">
                <p class="heading3 text-blue">活动描述</p>
                <div class="spacer10"></div>
                <p style="overflow: hidden; word-wrap: break-word; word-break:break-all;">${request.activity.description}</p>
                <div class="spacer10"></div>
                <p style="font-size: 12px;"><s:text name="bshare.shop.activity.extrainfo"><s:param>${request.activity.publisherSitePrefix}</s:param><s:param>${request.activity.publisherName}</s:param></s:text></p>
            </div>
            <div class="spacer10"></div>
            <div class="spacer1 clear" style="border-bottom: 1px dashed #dadada;"></div>
            <div class="spacer10"></div>
            <div id="activityRule" class="intro-content">
                <p class="heading3 text-blue">活动规则</p>
                <div class="spacer10"></div>
                	<ul>
                		<s:iterator value="#request.activity.pointRules" var="rule" status="status">
                			<s:if test="%{#rule.shareRule}">
		                		<li>用户每<span class="text-blue">${rule.num}</span>次分享可获取<span class="text-blue">${rule.points}</span>微积分，每名用户每天可获取上限为<span class="text-blue">${activity.maxSharePoints}</span>个的分享微积分（即成功分享到社交网络平台的次数）。</li>
		                	</s:if>
							<s:if test="%{#rule.clickBackRule}">
		                		<li>用户每<span class="text-blue">${rule.num}</span>次回流可获取<span class="text-blue">${rule.points}</span>微积分，每名用户每天可获取上限为<span class="text-blue">${activity.maxClickBackPoints}</span>个的回流 微积分（即分享到社交网络平台后，用户点击分享链接返回到分享页面的浏览次数）。</li>
		                	</s:if>
                		</s:iterator>
	                <li>仅当分享到新浪微博、腾讯微博、QQ空间、搜狐微博、网易微博、人人网、开心网、天涯微博时方可获取<s:text name="bshare.points.point"/>。</li>
	                <li>
	                		<p>使用一键通一次分享到多个平台算多次分享行为。</p>
		                <!-- TODO for point rule total limit one day. -->
		                <p>例：</p>
		                
                			<s:iterator value="#request.activity.pointRules" var="rule" status="status">
                				<s:if test="%{#rule.shareRule}">
				                	<p>用户A当日将一篇内容分享了<span class="text-blue">${rule.num}</span>次到新浪平台，则可获得<span class="text-blue">${rule.points}</span>微积分。若当日获取的分享微积分达到<span class="text-blue">${activity.maxSharePoints}</span>个分享微积分，则无法再获取分享微积分。</p>
                				</s:if>
                				<s:if test="%{#rule.clickBackRule}">
				                	<p>用户A当日将一篇内容分享到了新浪及腾讯平台，而两边总共带来了<span class="text-blue">${rule.num}</span>次回流，则可获得<span class="text-blue" style="margin: 0 5px;">${rule.points}</span><s:text name="bshare.points.point"/>。
				                	若当日获取的回流<s:text name="bshare.points.point"/>达到<span class="text-blue" style="margin: 0 5px;"><s:text name="bshare.points.number.format"><s:param value="activity.maxClickBackPoints"></s:param></s:text></span>个回流<s:text name="bshare.points.point"/>，则无法再获取回流<s:text name="bshare.points.point"/>。</p>
                				</s:if>
                			</s:iterator>
	                	</li>
                	</ul>
                <div class="spacer10"></div>
                <p class="text-blue heading4">主办方：</p>
                <div class="clear"></div>
                <p><a class="bLinkBlue" target="_blank" href="${request.activity.publisherSitePrefix}">${request.activity.publisherName}</a></p>
            </div>
	        <div class="spacer20"></div>
	    </div>
	</div>
	
</div>
