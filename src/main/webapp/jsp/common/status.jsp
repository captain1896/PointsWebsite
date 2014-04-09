<%@ include file="/jsp/common/init.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<!-- STATUS MESSAGES START -->
<div id="status-messages-pdiv" style="display:none;height:26px;margin:0px auto 5px;width:850px;z-index:10001;position:relative;" align="center">
	<div id="status-messages" class="status-messages bMessages"></div>
	<div id="status-messages-div" style="display:none;" class="bMessages">
	    <s:actionerror cssClass="action-error-messages"/>
	    <s:actionmessage cssClass="action-messages"/>
	</div>
	<div id="field-error-messages-div" style="display:none;" class="bMessages">
	    <s:fielderror cssClass="field-error-messages"/>
	</div>
	<div class="clear"></div>
</div>
<!-- STATUS MESSAGES END -->