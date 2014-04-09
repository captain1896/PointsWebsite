<%@ include file="/jsp/common/init.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<title><s:if test="%{#request.activity.id}"><s:text name="bshare.points.activity.edit"/></s:if><s:else><s:text name="bshare.points.activity.add"/></s:else> - <s:text name="bshare.points.publisher"/> - <s:text name="bshare.points.title"/></title>

<link rel="stylesheet" href="${js_path}/ueditor/themes/default/ueditor.css" type="text/css" />
<style>
    /* activityEditor */
    #activityEditor input, #activityEditor select { width: 300px; margin-left: 0px; padding: 3px; 
        font-size: 12px; border-width: 1px; border-style: solid; border-color: #939393 #c8c8c8 #c8c8c8; }
    #activityEditor input { height: 18px; }
    #activityEditor input[type=radio] { margin: 0; height: 14px; width: 14px; }
    #activityEditor select { width: 228px; height: 25px; }
    #activityEditor table { width: 100%; font-size: 12px; color: #434343; table-layout: fixed; }
    #activityEditor table td { padding: 10px 0; vertical-align: top; line-height: 28px; }
    
    #activityEditor .div-gradient-linear-light { padding: 10px 20px; border-radius: 0 0 5px 5px; }
    #activityEditor .date { width: 135px; }
    #activityEditor .msg-error, #activityEditor .msg-error2 { color: red; font-size: 12px; }
    #activityEditor .help-popup-img { margin: 8px 5px 0 0; vertical-align: top; }
    #activityEditor .icon-upload-image { display: inline-block; vertical-align: middle; }
    #activityEditor .bTable th, #activityEditor .bTable td { text-align: center; padding: 3px 0; border: 1px solid #dadada; }
    #activityEditor .wrapper-editor { padding: 20px 0; font-size: 12px; }
    #activityEditor .edui-editor { width: auto; }
    #activityEditor .edui-editor-wordcount { padding: 5px; }
    #activityEditor .word-break { word-wrap: break-word; }
    
    #previewImage { position: absolute; top: 0; left: 0; z-index: 9999; width: auto; padding: 5px; }
    #ruleTable .bLinkDark { display: inline-block; width: 80px; text-align: center; cursor: pointer; }
    
    /* common dialogs */
    .bOverlay { position: fixed; _position: absolute; padding-top: 5px; top: 10% !important; }
    .bOverlay .close { color: #fff; display: block; position: static; text-align: right; width: 100%; }
    .bOverlay .close:hover { color: #ddd; }

    /* dialogUpload */
    #dialogUpload .body { *width: 470px; }
    #dialogUpload .preview-image { width: auto; height: 120px; padding: 20px; border: 1px solid #dadada; text-align: center; 
        background: url(${points_image_path}/bkg-uploader.jpg) repeat; }
    #dialogUpload .preview-image img { border: 1px solid #dadada; }
    #dialogUpload .preview-thumb { width: 90px; height: 90px; margin-left: 20px; }
    #message { height: 15px; line-height: 15px; }
    #showImage { border: 1px solid #ddd; text-align: center; width: 120px; height: 120px; margin: 0 auto; }
    
    /* dialogRule */
    #dialogRule { width: 680px; }
    #dialogRule input, #dialogRule select { margin: 0 5px; }
    #dialogRule ul { list-style: none; font-size: 12px; line-height: 200%; }
    #rulePreviewDiv { padding-top: 15px; padding-left: 30px; }
</style>

<div id="activityEditor" class="container-center">
    <%@ include file="/jsp/common/statsComm.jsp" %>

    <div class="module-white-grey module-backend container-activity">
    <form id="editorForm" name="editorForm" action="${points_cxt_path}/publisher/activity/create" method="POST">
        <div class="div-gradient-linear-light heading3 text-blue">
            <s:if test="%{#request.activity.id}"><s:text name="bshare.points.activity.edit" /></s:if><s:else><s:text name="bshare.points.activity.action.add.full" /></s:else>
        </div>
        <div class="wrapper-editor">
            <input type="hidden" name="activity.id" value="${activity.id}"/>
            <input type="hidden" name="activity.publisherId" value="${activity.publisherId}"/>            
            <table>
                <colgroup>
                    <col style="width: 90px; *width: 80px;" />
                    <col style="width: 20px;" />
                    <col style="width: 400px;" />
                    <col style="width: 90px; *width: 80px;" />
                    <col style="width: 20px;" />
                    <col style="width: 308px;" />
                </colgroup>
                <tr>
                    <td>
                        <span><s:text name="bshare.points.activity.uuid" /></span>
                    </td>
                    <td>
                        <span title="请确保选择的uuid与按钮uuid一致，否则活动将无法正常显示" class="help-popup-img"></span>
                    </td>
                    <td colspan=4>
                        <s:if test="%{#request.activity.id}">
                            <input type="text" id="publisherUuid" name="activity.publisherUuid" readonly="readonly" style="width: 814px;" 
                                value="${activity.publisherUuid}" />
                        </s:if>
                        <s:else>
                            <s:select id="publisherUuid" label="publisherUuid" name="activity.publisherUuid" list="%{#request.siteSelector}" style="width: 824px;" />
                        </s:else>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span><s:text name="bshare.points.activity.name" /></span>
                    </td>
                    <td>
                        <span title="<s:text name='bshare.points.activity.name.tip'/>" class="help-popup-img"></span>
                    </td>
                    <td><input name="activity.name" type="text" maxlength=20 required="required" value="${activity.name}" /></td>
                    <td>
                        <span>活动简介</span>
                    </td>
                    <td>
                        <span title="<s:text name='bshare.points.activity.activityInfo.tip'/>" class="help-popup-img"></span>
                    </td>
                    <td><input name="activity.activityInfo" type="text" maxlength=50 value="${activity.activityInfo}" /></td>
                </tr>
                <tr>
                    <td>
                        <span><s:text name="bshare.points.activity.publishername" /></span>
                    </td>
                    <td>
                        <span title="<s:text name='bshare.points.activity.publishername.tip'/>" class="help-popup-img"></span>
                    </td>
                    <td><input name="activity.publisherName" type="text" maxlength=50 value="${activity.publisherName}" required="required" /></td>
                    <td>
                        <span><s:text name="bshare.points.activity.publishersite" /></span>
                    </td>
                    <td>
                        <span title="<s:text name='bshare.points.activity.publishersite.tip'/>" class="help-popup-img"></span>
                    </td>
                    <td><input id="publisherSite" name="activity.publisherSite" type="_url" maxlength=100 required="required" value="${activity.publisherSite}" /></td>
                </tr>
                <tr>
                    <td>
                        <span><s:text name="bshare.points.activity.domain" /></span>
                    </td>
                    <td>
                        <span title="<s:text name='bshare.points.activity.domain.tip'/>" class="help-popup-img"></span>
                    </td>
                    <td><input name="activity.domain" type="_url" maxlength=100 value="${activity.domain}" /></td>
                    <td>
                        <span><s:text name="bshare.points.activity.url" /></span>
                    </td>
                    <td>
                        <span title="<s:text name='bshare.points.activity.url.tip'/>" class="help-popup-img"></span>
                    </td>
                    <td><input name="activity.url" type="_url" required="required" maxlength=200 value="${activity.url}" /></td>
                </tr>
                <tr>
                    <td>
                        <span><s:text name="bshare.points.date.range" /></span>
                    </td>
                    <td></td>
                    <td>
                        <div class="left statsSelectorDivItem">
                            <input id="datePickerStart" name="activity.startDateStr" type="date" required="required"
                            value="${activity.startDateStr}" data-value="${activity.startDateStr}" <s:if test="%{#request.activity.activityType.code != 1&&#request.activity.id>0&&#request.update!='confilct'}">readonly='readonly'</s:if> min="${today}" max="${activity.endDateStr}" />
                        </div>
                        <div class="left" style="text-align:center;width:22px;line-height:26px;">
                            <span>-</span>
                        </div>
                        <div class="left statsSelectorDivItem">
                            <input id="datePickerEnd" name="activity.endDateStr" type="date" required="required"
                            value="${activity.endDateStr}" data-value="${activity.endDateStr}" min="${minDay}" max="${limitDay}" />
                        </div>
                    </td>
                    <td>
                        <span><s:text name="bshare.points.activity.status" /></span>
                    </td>
                    <td></td>
                    <td>
                        <input name="activity.type" type="radio" style="*width: 14px" value="1" checked="checked" />
                        <span style="margin-right: 15px;"><s:text name="bshare.points.activity.status.onging" /></span>
                        <input name="activity.type" type="radio" style="*width: 14px" value="3" />
                        <span style="margin-right: 15px;"><s:text name="bshare.points.activity.status.suspend" /></span>
                        	<input type="hidden" id="activityType" value="${activity.activityType.code}" />
                    </td>
                </tr>
                <tr>
                    <td><span>活动图片</span></td>
                    <td></td>
                    <td colspan=4 style="position: relative;">
                        <a id="uploadTrigger" class="icon-upload-image" href="javascript:;"><img src="${points_image_path}/icons/upload-image.gif" /></a>
                        <label style="margin-left: 10px;">上传图片</label>
                        <span class="field-tip" style="margin-left: 20px;">尺寸：120*120，大小：不超过50K，格式：jpg或png</span>
                        <div class="clear"></div>
                        <div style="position: relative;">
                            <div id="previewImage" class="bOverlay">
	                            <div class="body">
	                                <img src="" />
	                            </div>
	                        </div>
                        </div>
                        <input id="pic" name="activity.pic" type="hidden" defaultValue="${activity.pic}" defaultImageUrl="${activity.picUrl}" 
                        	imageUrl="${activity.picUrl}" value="${activity.pic}" />
                    </td>
                </tr>
                <tr>
                    <td><span>活动规则设置</span></td>
                    <td></td>
                    <td colspan=4>
                        <a id="ruleTrigger" class="bButton-blue trigger-rule" style="padding: 0 20px;">添加规则</a>
                    </td>
                </tr>
                <tr>
                    <td colspan=6>
	                    <table id="ruleTable" class="bTable">
	                        <colgroup>
	                            <col style="width: 25%;">
	                            <col style="width: 50%;">
	                            <col style="width: 25%;">
	                        </colgroup>
	                        <tr>
	                            <th>规则名称</th><th>规则描述</th><th>操作</th>
	                        </tr>
	                    </table>
	                    <input type="hidden" name="rulesAsJson" id="rulesAsJson" />
                    </td>
                </tr>
                <tr>
                    <td><span><s:text name="bshare.points.activity.points.put" /></span></td>
                    <td></td>
                    <td colspan=4>
                			<s:if test="%{#request.activity.id}">
	                        <input name="activity.increasePoints" class="bInput" type="number" required="required" value="${activity.increasePoints}" 
	                            style="width: 100px; margin-right: 5px;" max="<s:property value="getText('{0,number,#}', {(account.availablePoints-account.availablePoints%100)/100})"/>" 
	                            min="0" value="" <s:if test="account.availablePoints < 100">disabled</s:if> />* 100&nbsp;个微积分&nbsp;&nbsp;&nbsp;&nbsp;帐户余额：<span>${account.availablePoints}</span>个积分
							</s:if>
							<s:else>
								<input name="activity.totalPoints" class="bInput" type="number" required="required" value="${activity.totalPoints}" 
	                            style="width: 100px; margin-right: 5px;" max="<s:property value="getText('{0,number,#}', {(account.availablePoints-account.availablePoints%100)/100})"/>" 
	                            min="1" value="" <s:if test="account.availablePoints < 100">disabled</s:if> />* 100&nbsp;个微积分&nbsp;&nbsp;&nbsp;&nbsp;帐户余额：<span>${account.availablePoints}</span>个积分
							</s:else>
                    </td>
                </tr>
                <s:if test="%{#request.activity.id}">
                <tr>
                    <td><span><s:text name="bshare.points.activity.points.used" /></span></td>
                    <td></td>
                    <td colspan=4>
                        <input readonly="readonly" name="activity.usedPoints" style="width: 100px; margin-right: 5px;" value="${activity.usedPoints}" />
	                    <a class="text-blue" href="${points_cxt_path}/publisher/activity/pointRecords?id=${activity.id}" 
	                       target="_blank"><s:text name="bshare.points.view.details"/></a>
                    </td>
                </tr>
                <tr>
                    <td><span><s:text name="bshare.points.activity.points.put.total" /></span></td>
                    <td></td>
                    <td colspan=4>
                    <s:if test="%{#request.activity.id}">
                        <input id="totalInputPoints" name="activity.totalPoints" readonly="readonly" style="width: 100px; margin-right: 5px;" value="${activity.totalPoints}" />
                    </s:if>
                    </td>
                </tr>
                </s:if>
                <tr>
                    <td><span><s:text name="bshare.points.activity.description" /></span></td>
                    <td><span title="<s:text name='为保证您活动的显示效果，字数请控制在500字以内'/>" class="help-popup-img"></span></td>
                    <td colspan=4></td>
                </tr>
            </table>
            <div class="clear"></div>
            <div class="wrapper-desc">
                <script type="text/plain" id="ueditor">${activity.description}</script>
                <input name="activity.description" id="description" type="hidden" value="" />
            </div>
            <div class="clear spacer15"></div>
            <div class="hint-button" style="">
                <p>活动启动后活动页面的按钮将会出现奖字图标，如下图所示。为了让活动效果更好，您可以为活动页面<a href="${main_cxt_path}/help/install" target="_blank" class="bLinkBlue">更换按钮</a>，若有其他按钮需求请联络<a 
                    href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" target="_blank" class="bLinkBlue">客服</a>。</p>
                <div class="clear spacer10"></div>
                <img src="${points_image_path}/preview-promot.jpg" />
            </div>
            <div class="clear spacer30"></div>
            <div class="wrapper-button" style="text-align: right;">
                <a id="previewActivity" class="bButton-blue" href="javascript:;" style="padding: 5px 30px;">预览</a>
                <a id="saveActivity" class="bButton-blue" href="javascript:;" style="padding: 5px 30px; margin: 0 20px;">保存</a>
            </div>
        </div>
        <div class="clear spacer20"></div>
    </form>
    </div>

    <div id="dialogUpload" class="bOverlay">
        <a class="close">X</a>
        <div class="body">
            <input type="button" id="imageFileUpload" class="bButton" style="vertical-align: bottom; font-size: 12px; width: 100px; text-align: center; line-height: 28px; height: 26px; padding: 0px;" value="上传" />
            <a id="confirmImage"　href="javascript;" class="bButton-blue" style="vertical-align: bottom; font-size: 12px; width: 100px; text-align: center; line-height: 28px; height: 26px; padding: 0px; margin-left: 20px; ">确定</a>
            <div class="clear spacer5"></div>
            <p class="field-tip">尺寸：120*120，大小：不超过50K，格式：jpg或png</p>
            <div class="clear spacer5"></div>
            <div id="msgUpload" class="msg-error"></div>
            <div class="clear spacer15"></div>
            <div id="showImage" class="preview-image"></div>
            <div class="clear spacer15"></div>
        </div>
    </div>
    <div id="dialogRule" class="bOverlay">
        <a class="close">X</a>
        <div class="body">
            <table><tr>
                <td><table>
	                <tr>
	                    <td style="width: 90px;">奖励方式</td>
	                    <td>
	                        <input name="pointsRuleType" type="radio" style="*width: 14px" added=false value="SHARE" />
	                        <span style="margin-right: 15px;">分享获奖励</span>
	                    </td>
	                    <td>
	                        <input name="pointsRuleType" type="radio" style="*width: 14px" added=false value="CLICKBACK" checked="checked" />
	                        <span style="margin-right: 15px;">回流获奖励</span>
	                    </td>
	                </tr>
	                <tr>
	                    <td>奖励条件</td>
	                    <td colspan=2>用户每
	                        <input name="num" type="number" required="required" style="width: 40px;" value="${rule.num}"
	                            min="1" max="99" />次<span id="rewardString"></span>即可获取奖励
	                    </td>
	                </tr>
	                <tr>
	                    <td>上限设置</td>
	                    <td colspan=2>每个用户单日最多获取奖励
	                        <input name="limitPoints" type="number" required="required" style="width: 40px;" value="${rule.limitPoints}" min="1" max="99" />次
	                    </td>
	                </tr>
                    <tr>
                        <td>奖励内容设置</td>
                        <td colspan=2>
                            <input name="rewardType" type="hidden" value="points" rel="#pointsReward" />
                            <div id="pointsReward" class="reward-value">每次奖励<input name="points" type="number" required="required" 
                                style="width: 40px;" value="${rule.points}" min="1" max="99" />个微积分
                                <div class="clear spacer10"></div>
                            </div>
                        </td>
                    </tr>
                    <!-- <sec:authorize ifNotGranted="ROLE_POINTS_MERCHANT">
	                </sec:authorize>
                    <sec:authorize ifAnyGranted="ROLE_POINTS_MERCHANT">
                    <tr>
                        <td>奖励内容设置</td>
                        <td>
                            <input name="rewardType" type="radio" style="*width: 14px" value="points" checked="checked" rel="#pointsReward" />
                            <span style="margin-right: 15px;">奖励微积分</span>
                        </td>
                        <td>
                            <input name="rewardType" type="radio" style="*width: 14px" value="product" rel="#prodReward" />
                            <span style="margin-right: 15px;">奖励指定商品</span>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan=2>
                            <div id="pointsReward" class="reward-value hidden"> 每次奖励
                                <input name="points" type="number" required="required" style="width: 60px;" value="${rule.points}" 
                                    min="1" max="99" />个微积分
                                <div class="clear spacer10"></div>
                            </div>
                            <div id="prodReward" class="reward-value hidden">每次奖励
                                <input name="points" type="number" required="required" style="width: 60px;" value="${rule.ruleLimit}" 
                                    min="1" max="100" />个
                                <select name="rewardProds" id="rewardProds" list="%{#request.rewardProds}" style="width: 100px;"></select>
                                <a id="refreshTrigger" href="javascript:;" title="刷新商品列表" style="display: inline-block; margin-right: 5px; vertical-align: middle;">
                                    <img src="${points_image_path}/icons/refresh-grey.gif" /></a>商品
                                <div class="clear spacer10"></div>
                                <div id="prodCost" class="field-tip left">等值于<span id="pointsValue"></span>个微积分</div>
                                <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=800087176&amp;site=qq&amp;menu=yes" 
                                target="_blank" class="bLinkBlue left" style="margin-left: 20px; text-decoration: underline;">我要添加商品</a>
                            </div>
                        </td>
                    </tr>
                    </sec:authorize>
                    -->
	            </table></td>
                <td>
		            <div id="rulePreviewDiv">
		                <p class="heading4 text-blue">活动规则预览：</p>
		                <ul>
		                    <li class="item-rule" rel="SHARE">用户每&nbsp;<span class="pNum word-break text-blue"></span>&nbsp;次分享可获取&nbsp;<span 
		                        class="pValue word-break text-blue"></span>&nbsp;微积分，每名用户每天可获取上限为&nbsp;<span 
		                        class="pTotal word-break text-blue">${activity.activityLimitRule.shareLimitNo}</span>&nbsp;个的分享微积分（即成功分享到社交网络平台的次数）。</li>
		                    <li class="item-rule" rel="CLICKBACK">用户每&nbsp;<span class="pNum word-break text-blue"></span>&nbsp;次回流可获取&nbsp;<span 
		                        class="pValue word-break text-blue"></span>&nbsp;微积分，每名用户每天可获取上限为&nbsp;<span 
		                        class="pTotal word-break text-blue"></span>&nbsp;个的回流 微积分（即分享到社交网络平台后，用户点击分享链接返回到分享页面的浏览次数）。</li>
		                    <li>仅当分享到新浪微博、腾讯微博、QQ空间、搜狐微博、网易微博、人人网、开心网、天涯微博时方可获取<s:text name="bshare.points.point"/>。</li>
		                    <li>
		                        <p>使用一键通一次分享到多个平台算多次分享行为。</p>
		                    </li>
		                </ul>
		            </div>
                </td>
            </tr></table>
            <div class="clear spacer15"></div>
            <div class="clear spacer1" style="background: #dadada;"></div>
            <div class="clear spacer15"></div>
            <div class="wrapper-button" style="text-align: center">
                <a id="saveRule" class="bButton-blue" href="javascript:;" style="padding: 5px 20px;">保存</a>
            </div>
        </div>
    </div>

</div>

<script type="text/javascript" charset="utf-8" src="${js_path}/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="${js_path}/ueditor/editor.js"></script>
<script type="text/javascript" charset="utf-8" src="${js_path}/libs/ajaxupload.js"></script>
<script type="text/javascript" charset="utf-8" src="${js_path}/libs/json2-min.js"></script>
<script type="text/javascript" charset="utf-8">
<s:if test="%{#request.activity.id}">
var isNew = false;
var start = ${activity.used};
</s:if><s:else>
var isNew = true;
var start = false;
</s:else>

var ueditor;
var isSubmitting = false;
var prodList = {}; // ${request.prodList}
var REWARD_OPTION_LOCALE = {
    "SHARE": "分享",
    "CLICKBACK": "回流"
};
var REWARD_TYPE_LOCALE = {
    "points": "积分",
    "product": "商品"
};
var rules = ${request.rulesAsJson};
var defaultRule = {
    num: 5,
    limitPoints: 99,
    rewardType: "points",
    points: 1
};

var REQIRED_ERROR = '<s:text name="bshare.field.error.required"/>',
    MAX_LENGTH_ERROR = '<s:text name="bshare.field.error.text.exceeds"/>',
    INVALID_NUMBER_ERROR = '<s:text name="bshare.field.error.number"/>',
    INVALID_URL_ERROR = '<s:text name="bshare.field.error.url"/>',
    EXCEEDS_NUMBER_ERROR = '<s:text name="bshare.field.error.number.exceeds"/>',
    REQIRED_RULE_ERROR = '请设置奖励规则';

function initRules() {
	if (!start) {
		return;
	}
	for (var i = 0; i < rules.length; ++i) {
		rules[i].disabled = true;
	}
}

function initImageUploader() {
    new AjaxUpload('#imageFileUpload', { 
        action: '${points_cxt_path}/uploadFile?type=points_activity', autoSubmit: true, name: 'tempFile', responseType: "json",
        onChange: function(file, extension){},
        onSubmit: function(file, extension) {
            hideStatusMessage();
            $("#msgUpload").empty().html("");
            if (!(extension && /^(jpg|png|jpeg)$/i.test(extension))){
                $("#msgUpload").html('<s:text name="bshare.create.invalid.image.file"/>');
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
				var filename = response.contents.filename;
				initShowImage(imgUrl);
				$("#pic").val(filename).attr("imageUrl", imgUrl);
				$("#msgUpload").empty().html("");
			} else {
				$("#msgUpload").html(response.message);
			}
        }
    });
}

function initShowImage(imgUrl) {
	var preview = "<img src='"+ imgUrl +"'/>" + "<img class='preview-thumb' src='"+ imgUrl +"'/>";
	$("#showImage").html(preview);
}

function initTextEditor() {
	ueditor = new UE.ui.Editor();
	ueditor.render('ueditor');
}

function initOverlays() {
    // uploader overlay
    $("#dialogUpload").overlay({
        top: '30%',
        mask: {
            color: '#e9e9e9',
            loadSpeed: 200,
            opacity: 0.5
        },
        closeOnClick: false,
        onLoad: function(e) {
        	if (!!$("#pic").attr("imageUrl")) {
        		initShowImage($("#pic").attr("imageUrl"));
        	}
        },
        onBeforeClose: function(e) {
            hideStatusMessage();
            clearMessage();
        }
    });
    
    // rule overlay
    $("#dialogRule").overlay({
        top: '30%',
        mask: {
            color: '#e9e9e9',
            loadSpeed: 200,
            opacity: 0.5
        },
        closeOnClick: false,
        onLoad: function(e) {
        	
        },
        onBeforeClose: function(e) {
            hideStatusMessage();
            clearMessage();
        }
    });
    
    // image overview
    $("#previewImage img").attr("src", $("#pic").attr("imageUrl"));
}

function initDialogRule(rule) {
	$("input[name=pointsRuleType][value=" + rule.pointsRuleType + "]").trigger("click");
	$("input[name=num]").val(rule.num);
    $("input[name=limitPoints]").val(rule.limitPoints);
    if ($("input[name=rewardType]").eq(0).attr("type") === "radio") {
    	$("input[name=rewardType][value=" + rule.rewardType + "]").trigger("click");
    }
    $("input[name=points]").val(rule.points);
    initPreviewRule();
}

function viewRule(target) {
	var index = $(target).closest("tr")[0].rowIndex;
    initDialogRule(rules[index - 1]);
    $("#dialogRule :input").attr("disabled", "disabled");
    $("#saveRule").text("关闭");
    $("#dialogRule").data("overlay").load();
}

function editRule(target) {
	var index = $(target).closest("tr")[0].rowIndex;
	initDialogRule(rules[index - 1]);
    $("input[name=pointsRuleType]").attr("disabled", "disabled");
	$("#dialogRule").data("overlay").load();
}

function deleteRule(target) {
	var index = $(target).closest("tr")[0].rowIndex;
	$(target).closest("table").find("tr").eq(index).remove();
    $("input[name=pointsRuleType][value=" + rules[index - 1].pointsRuleType + "]").attr("added", false).removeAttr("disabled");
    initRuleTrigger();
    rules.splice(index - 1, 1);
}

function initRuleTrigger() {
    if ($("input[name=pointsRuleType][added=false]").length === 0) {
        $("#ruleTrigger").hide();
    } else {
    	$("#ruleTrigger").show();
    }
}

function initRuleTable() {
	if (rules.length === 0) {
		return;
	}
	var ruleTable = $("#ruleTable");
	ruleTable.find("tr.row-rule").remove();
	$("input[name=pointsRuleType]").attr("added", false);
	for (var i = 0; i < rules.length; ++i) {
		var rule = rules[i], ruleRow = $('<tr class="row-rule"></tr>');
		ruleRow.append('<td>' + REWARD_OPTION_LOCALE[rule.pointsRuleType] + '获取' + REWARD_TYPE_LOCALE[rule.rewardType] + '</td>');
		ruleRow.append('<td>用户每&nbsp;' + rule.num + '&nbsp;次' + REWARD_OPTION_LOCALE[rule.pointsRuleType] + '，可获取&nbsp;' + 
        	    rule.points + '&nbsp;' + REWARD_TYPE_LOCALE[rule.rewardType] + '</td>');
		if (!rule.disabled) {
			ruleRow.append('<td><a onclick="return editRule(this);" class="bLinkDark">编辑</a>|' +
            '<a onclick="return deleteRule(this);" class="bLinkDark">删除</a></td>');
		} else {
			ruleRow.append('<td><a onclick="return viewRule(this);" class="bLinkDark">查看</a></td>');
		}
		ruleRow.appendTo(ruleTable);
        $("input[name=pointsRuleType][value=" + rule.pointsRuleType + "]").attr("added", true).attr("disabled", "disabled");
	}
}

function initProdList() {
	var rewardProds = $("#rewardProds");
	rewardProds.find("option").remove();
	for (var prod in prodList) {
		rewardProds.append('<option value="' + prod + '" cost=' + prodList[prod].cost + '>' + prodList[prod].localName + '</option>');
	}
	if (rewardProds.find("option").length === 0) {
		rewardProds.append('<option value="">请先添加商品</option>');
		$("#prodCost").hide();
	} else {
		$("#prodCost").show();
	}
}

function initPreviewRule() {
	validateInputs($("#dialogRule")[0]);
    if ($("#dialogRule").find(".invalid").length > 0) {
        return;
    }
	$(".pOption").text(REWARD_OPTION_LOCALE[$("input[name=pointsRuleType]:checked").val()]);
    $(".pNum").text($("input[name=num]").val());
    $(".pTotal").text(parseInt($("input[name=limitPoints]").val()) * parseInt($("input[name=points]").val()));
    if ($("input[name=rewardType]").eq(0).attr("type") === "radio") {
    	$(".pType").text(REWARD_TYPE_LOCALE[$("input[name=rewardType]:checked").val()]);
    } else {
    	$(".pType").text(REWARD_TYPE_LOCALE[$("input[name=rewardType]").val()]);
    }
    $(".pValue").text($("input[name=points]").val());
    $("li.item-rule").hide();
    $("li.item-rule[rel=" + $("input[name=pointsRuleType]:checked").val() + "]").show();
}

function initEvents() {
	$("#dialogRule :input").click(function () {
		initPreviewRule();
	}).keyup(function () {
		initPreviewRule();
	});
	
	$("#dialogUpload .close").click(function () {
		$("#pic").val($("#pic").attr("defaultValue")).attr("imageUrl", "");
		$("#pic").attr("imageUrl", $("#pic").attr("defaultImageUrl"));
		$("#previewImage img").attr("src", $("#pic").attr("imageUrl"));
		$("#dialogUpload").data("overlay").close();
	});
	
	$("#confirmImage").click(function () {
		$("#pic").attr("defaultValue", $("#pic").val());
		$("#pic").attr("defaultImageUrl", $("#pic").attr("imageUrl"));
		$("#previewImage img").attr("src", $("#pic").attr("imageUrl"));
        $("#dialogUpload").data("overlay").close();
    });
	
    $("#uploadTrigger").click(function () {
        $("#dialogUpload").data("overlay").load();
    });
    
    $("#uploadTrigger").hover(function () {
        if (!$("#pic").attr("imageUrl")) {
            return;
        }
        $("#previewImage").show();
    });
    
    $("#uploadTrigger").mouseout(function () {
        setTimeout(function () {
            $("#previewImage").hide();
        }, 500);
    });
    
    $("#ruleTrigger").click(function () {
        $("#dialogRule :input").removeAttr("disabled");
        $("#saveRule").text("保存");
    	initDialogRule(defaultRule);
        $("input[name=pointsRuleType][added=true]").attr("disabled", "disabled");
        $("input[name=pointsRuleType][added=false]").removeAttr("disabled");
        $("input[name=pointsRuleType][added=false]").eq(0).trigger("click");
    	$("#dialogRule").data("overlay").load();
    });
    
    $("input[name=pointsRuleType]").click(function () {
    	$("input[name=pointsRuleType]").removeAttr("checked");
        $(this).attr("checked", "checked");
        $("#rewardString").text(REWARD_OPTION_LOCALE[$(this).val()]);
    });
    
    if ($("input[name=rewardType]").eq(0).attr("type") === "radio") {
        $("input[name=rewardType]").click(function () {
            $("input[name=rewardType]").removeAttr("checked");
            $(this).attr("checked", "checked");
            $(".reward-value").addClass("hidden");
            $($(this).attr("rel")).removeClass("hidden");
        }).eq(0).trigger("click");
    }
    
    $("#saveRule").click(function () {
    	if ($("#dialogRule :input[disabled=disabled]").length !== $("#dialogRule :input").length) {
    		validateInputs($("#dialogRule")[0]);
            if ($("#dialogRule").find(".invalid").length > 0) {
                return;
            }
    	}
        $("#dialogRule").data("overlay").close();
        
		var pointsRuleType = $("input[name=pointsRuleType]:checked").val();
		var rule = getRule(pointsRuleType);
		if(!rule) {
			rule = {};
			rules.push(rule);
		} 
		rule.pointsRuleType = $("input[name=pointsRuleType]:checked").val();
		if ($("input[name=rewardType]").eq(0).attr("type") === "radio") {
	        rule.rewardType = $("input[name=rewardType]:checked").val();
		} else {
			rule.rewardType = $("input[name=rewardType]").val();
		}
		rule.num = $("input[name=num]").val();
		rule.limitPoints = $("input[name=limitPoints]").val();
		rule.points = $("input[name=points]").val();
		
		$("input[name=pointsRuleType]").removeAttr("disabled");
		$("input[name=pointsRuleType]:checked").attr("disabled", "disabled");
		initRuleTable();
		initRuleTrigger();
    });
    
    $("#rewardProds").change(function () {
    	$("#pointsValue").text($(this).find("option[value=" + $(this).val() + "]").attr("cost"));
    });
    
    $("#refreshTrigger").click(function () {
    	$.ajax({
            type: 'POST',
            url: "refresh_prod_list", 
            data: {
            	'uuid': $("#publisherUuid").val()
            },
            success: function(results) {
                if (!!results.content.prodList) {
                	prodList = results.content.prodList;
                	initProdList();
                }
            }, 
            error: function() {},
            dataType: "json"
        });
    });
    
    $("#saveActivity").click(function () {
		if (!!isNew) {
			$("#editorForm").attr("action", "${points_cxt_path}/publisher/activity/create").removeAttr("target");
		} else {
			$("#editorForm").attr("action", "${points_cxt_path}/publisher/activity/update").removeAttr("target");
		}
        verifyForm();
    });
    
    $("#previewActivity").click(function () {
		$("#editorForm").attr("action", "${points_cxt_path}/publisher/activity/preview").attr("target", "_blank");
        verifyForm(true);
    });
    
    var updateTotalPoints = function(event) {
        var target = event.target;
        if ($(target).val().replace(/[0-9]/g, "").length > 0) {
            return;
        } else {
            var newInput = $(target).val();
            $("#totalInputPoints").val(parseInt("${activity.totalPoints}") + (newInput == "" ? 0 : parseInt(newInput)*100));
        }
    };
    $("#totalPoints")
        .bind("keyup", updateTotalPoints)
        .bind("click", updateTotalPoints);
    
    $("#publisherUuid").change(function () {
    	var reg =  /(.+)\s\-\s(.+)(\s)+\((.+)\)/;
		var str = $(this).find("option:selected").text() + " ";
		var result = reg.exec(str);
		if (!!result && !!result[2]) {
		    $("#publisherSite").val(result[2]);
		}
	}).trigger('change');
}

function getRule(pointsRuleType) {
	for(i in rules) {
		if(rules[i].pointsRuleType == pointsRuleType) {
			return rules[i];
		}
	}
	return null;
}

function showErrorMessage(target, msg) {
	var errMsg = $(target).parent().find(".msg-error").length > 0 ? $(target).parent().find(".msg-error") : 
		$('<div class="msg-error"></div>');
	errMsg.html('<div class="clear spacer5"></div><p>' + msg + '</p>');
	errMsg.appendTo($(target).parent());
	$(target).addClass("invalid");
}

function clearMessage() {
	$(".msg-error").empty();
    $(".invalid").removeClass("invalid");
}

function validateInputs(target) {
    hideStatusMessage();
    clearMessage();
        
    $(target).find(":input").each(function () {
        if (!!$(this).attr("required") && !$(this).val()) {
            showErrorMessage(this, REQIRED_ERROR);
            return true;
        }
        if (!!$(this).attr("maxlength") && ($(this).val().length > parseInt($(this).attr("maxlength")))) {
            showErrorMessage(this, MAX_LENGTH_ERROR.replace("$1", $(this).attr("maxlength")));
            return true;
        }
        if ($(this).attr("type") === "number") {
            if ($(this).val().replace(/[0-9]/g, "").length > 0) {
                showErrorMessage(this, INVALID_NUMBER_ERROR);
                return true;
            }
            var value = parseInt($(this).val()), min = parseInt($(this).attr("min")), max = parseInt($(this).attr("max"));
            if (value < min || value > max) {
                showErrorMessage(this, EXCEEDS_NUMBER_ERROR.replace("$1", min).replace("$2", max + 1));
                return true;
            }
        }
        if ($(this).attr("type") === "_url") {
        	$(this).val($.trim($(this).val()));
        }
    });
}

function validDesc() {
	$("#description").removeClass("invalid").val(ueditor.getContent().replace(/<script.*?>.*?<\/script>/ig, "").replace(/\r\n/gi, ""));
	if ($.trim($("#description").val()).length === 0) {
		$("#edui1_wordcount").html('<div class="msg-error2">' + REQIRED_ERROR + '</div>');
	}
	if ($("#edui1_wordcount .msg-error2").length > 0) {
        $("#description").addClass("invalid");
	}
}

function verifyForm(preview) {
    if(isSubmitting) {
        return;
    }
    
    validateInputs($("#editorForm")[0]);
    validDesc();
    if ($("#editorForm").find(".invalid").length > 0) {
        // $(target).find(".invalid").eq(0).parent().find("input").focus();
        return;
    }
    
    
    if ($("#ruleTable .row-rule").length === 0) {
    	showErrorMessage($("#ruleTrigger")[0], REQIRED_RULE_ERROR);
    	return;
    }
    
    var rulesAsJson = JSON.stringify(rules);
    $("#rulesAsJson").val(rulesAsJson);
    
    if(!preview) {
        isSubmitting = true;
        displayStatusMessage('<s:text name="bshare.points.wait"/>', "info");
        $("#saveActivity").html('<s:text name="bshare.points.wait"/>');
    }
    setTimeout(function () {
    	$("#editorForm").submit();
    }, 0);
}

function initState() {
	var activityType = $('#activityType').val();
	$("input[name=activity.type][value=" + activityType + "]").attr("checked",true);
}

$(document).ready(function () {
    $("input[name=pointsRuleType]").removeAttr("disabled");
    
	// datapicker
    initDatepicker();
    // rich text editor
    initTextEditor();
    // image file uploader
    initImageUploader();
    // overlays
    initOverlays();
    // prod list
    initProdList();
    // rule table
    initRules();
    initRuleTable();
    initRuleTrigger();
    // activity status
    initState();
    // event listners
    initEvents();
});
</script>
