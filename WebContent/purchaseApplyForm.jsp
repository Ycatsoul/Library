<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/commons/taglib.jsp"%>
<html>
<head>
	<title>购置申请</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!-- 避免IE使用兼容模式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="renderer" content="webkit">
    <jsp:include page="commonlibs.jsp" flush="true"/>
    
    <script src="${ctx}/commons/jslibs/commons.min.js?v=${myVsersion}" charset="utf-8"></script>
    <link type="text/css" href="${ctx}/commons/style/commons.min.css?v=${myVsersion}" rel="stylesheet"/>
    <script src="${ctx}/static/artDialog4/artDialog.js?skin=blue"></script>
	<script src="${ctx}/static/artDialog4/plugins/iframeTools.js"></script>
	<script src="${ctx}/static/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script src="${ctx}/commons/jslibs/ajaxfileupload.js?v=${myVsersion}"></script>
	<script type="text/javascript" src="${ctx}/commons/jslibs/jquery.form.js"></script>
	<script src="${ctx}/static/jquery-validation-1.9.0/jquery.validate.min.js"></script>
	<script src="${ctx}/static/jquery-validation-1.9.0/lib/jquery.metadata.js"></script>
	<script src="${ctx}/static/jquery-validation-1.9.0/localization/messages_cn.js"></script>
	<script src="${ctx}/commons/jslibs/commons.form.min.js?v=${myVsersion}" charset="utf-8"></script>
	<link href="${ctx}/static/icheck/skins/all.css?v=1.0.2" rel="stylesheet" type="text/css"/>
	<script src="${ctx}/static/icheck/icheck.min.js?v=1.0.2"></script>
	<script src="${ctx}/commons/jslibs/jquery.media.js?v=${myVsersion}" charset="utf-8"></script>
    <style type="text/css">
	table.gridtable_old {width:1000px;margin-left:50px;font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;}
	table.gridtable_old th {border-width: 1px;padding: 3px;border-style: solid;border-color: #666666;background-color: #F3F3F3;font-weight: bold;height: 30px;line-height: 30px;color: #4A7EBB;}
	table.gridtable_old td {border-width: 1px;padding: 5px;border-style: solid;border-color: #666666;background-color: #ffffff;}
	textarea {width:300px; min-height:30px; overflow:hidden;border-top: none;border-left: none;border-right: none;border-bottom: solid #4A7EBB 1px;}
    *{font-family: '微软雅黑';}
	.elementStyle{display: block;width: 50px;height: 25px;line-height: 25px;font-size: 13px;font-weight: bolder;text-align: center;background-color: #3CC8FB;cursor: pointer;}
    </style>
    <script type="text/javascript">
    var flowStatus = "${purchaseApply.flowStatus}";
	var createById = "${purchaseApply.createBy.id}";
	var currentOperator = "${record.operateBy.id}";
	var currentOperatorName = "${record.operateBy.name}";
	var record="${record}";
	var nodeSort="${record.sort}";
	var ck = "${fn:contains(currentUserIdList,currentOperator)}";
	var ifCreater = "${fn:contains(currentUserIdList,purchaseApply.createBy.id)}";
	var operation = "${record.operation}";
	var purchaseApplyId = "${purchaseApply.id}";
	//当前登录用户是否包含当前表单的审批人
	var currentUserIdList = "${currentUserIdList}";
	var terminationStatus = "${purchaseApply.terminationStatus}";
	
	jQuery.extend({  
        handleError: function (s, xhr, status, e) {  
            if (s.error) {  
                s.error.call(s.context || s, xhr, status, e);  
            }  
            if (s.global) {  
                (s.context ? jQuery(s.context) : jQuery.event).trigger("ajaxError", [xhr, s, e]);  
            }  
       	},  
        httpData: function (xhr, type, s) {  
            var ct = xhr.getResponseHeader("content-type"),  
    		xml = type == "xml" || !type && ct && ct.indexOf("xml") >= 0,  
    		data = xml ? xhr.responseXML : xhr.responseText;  
            if (xml && data.documentElement.tagName == "parsererror")  
                throw "parsererror";  
            if (s && s.dataFilter)  
                data = s.dataFilter(data, type);  
            if (typeof data === "string") {  
                if (type == "script")  
                    jQuery.globalEval(data);  
                if (type == "json")  
                    data = window["eval"]("(" + data + ")");  
            }  
            return data;  
        }  
    });
    </script>
</head>

<body>
<div data-toggle="topjui-layout" data-options="fit:true">
    <div data-toggle="topjui-panel" title="" data-options="fit:true,iconCls:'icon-ok',footer:'#footer'">
<form:form id="inputForm" action="${ctx}/form/purchaseApply/save" class="hidden" method="post" 
data-toggle="topjui-form" data-options="id:'inputForm'" modelAttribute="purchaseApply">
    <form:hidden path="id" />
    <form:hidden path="terminationStatus" />
    <input type="hidden" id="attachNo" name="attachNo" value="${attachNo}">
    <input type="hidden" id="selectedFlowId" name="selectedFlowId" value="${record.workflow.id}">
    <input type="hidden" name="onlySign" id="onlySign" value="${empty onlySign?record.onlySign:onlySign}"/>
   	<input type="hidden" name="submitFlag" id="submitFlag"/>
    <input type="hidden" name="recordId" id="recordId" value="${empty recordId?record.id:recordId }"/>
   	<input type="hidden" name="returnToRecordId" id="returnToRecordId"/>
   	<input type="hidden" name="participateOnlySign" id="participateOnlySign" value="${empty participateOnlySign?record.participateOnlySign:participateOnlySign}"/>
   	<input type="hidden" name="returnNodeId" id="returnNodeId" value="${returnNodeId }"/>
	<input type="hidden" id="delFileName" name="delFileName" value=""/>
	<input type="hidden" id="attachmentNoCurr" name="attachmentNoCurr" value="${attachmentNoCurr}"/>
	<input type="hidden" id="iamCopyData" name="iamCopyData" value="${iamCopyData}">
	
	<input type="hidden" id="flowStatus" name="flowStatus" value="${purchaseApply.flowStatus}">
	<input type="hidden" id="createById" name="createById" value="${purchaseApply.createBy.id}">
	<input type="hidden" id="currentOperator" name="currentOperator" value="${record.operateBy.id}">
	<input type="hidden" id="nodeSort" name="nodeSort" value="${record.sort}">
	<input type="hidden" id="activeSort" name="activeSort" value="${activeSort}">
	<input type="hidden" id="operation" name="operation" value="${record.operation}">
	<input type="hidden" id="currentUserIdList" name="currentUserIdList" value="${currentUserIdList}">
	<input type="hidden" id="feiyongmingxi_radio_name" name="feiyongmingxi_radio_name">
	<input type="hidden" id="yufumingxi_radio_name" name="yufumingxi_radio_name">
	<input type="hidden" name="deleteDetails" id="deleteDetails"/>
	
	<div id="useToControllShow">	
    <table class="editTable" style="margin:10px 0 0 50px;width: 90%;">
        <tr>
            <td colspan="2">
                <div class="divider">
                    <span>基本信息</span>
                </div>
            </td>
        </tr>
     </table>
    <table class="editTable" style="width: 1000px;margin-left: 50px;margin-bottom: 0px;" id="tableTop">
    	<tr>
    		<td class="label">购置申请号：</td>
			<td class="tdTwo">
				<form:input path="projectNumber"
                       data-toggle="topjui-textbox"
                       data-options="required:true,prompt:'必填',width:350,readonly:true"></form:input>
			</td>
			<td class="label">状态：</td>
			<td class="tdTwo">
				<c:if test="${empty purchaseApply.flowStatus}">无</c:if>
            	<c:if test="${purchaseApply.flowStatus eq 'create'}">已创建</c:if>
				<c:if test="${purchaseApply.flowStatus eq 'submit'}">已提交</c:if>
				<c:if test="${purchaseApply.flowStatus eq 'approving'}">审批中</c:if>
				<c:if test="${purchaseApply.flowStatus eq 'finish'}">已完成</c:if>
			</td>
		</tr>
		<tr>
			<td class="label">申请人：</td>
			<td class="tdTwo">
				<form:hidden path="applyUser.id" id="applyId"/>
				<form:hidden path="applyUser.name" id="applyName"/>
				<input type="text" value="${purchaseApply.applyUser.name}" data-toggle="topjui-textbox" readonly="readonly"
                       data-options="required:true,readonly:true,width:350,prompt:'必填'"/>
			</td>
			 <td class="label">公司：</td>
			<td class="tdTwo">
				<form:hidden path="company.id" id="companyId" htmlEscape="false"/>
				<form:input path="company.name" id="companyName" htmlEscape="false" ondblclick="companySelect('${ctx}/sys/menu/treeselect','/sys/office/treeData?type=1','companyId','companyName')"/>
			</td>
			
		</tr>
		<tr>
			<td class="label">申请时间：</td>
			<td class="tdTwo">
				<input type="text" readonly="readonly" name="applyDate" value="<fmt:formatDate value='${purchaseApply.applyDate}' pattern="yyyy-MM-dd HH:mm:ss"/>" id="applyDate" data-toggle="topjui-textbox" data-options="readonly:true,width:350"/>
			</td>
			<td class="label">部门：</td>
			<td class="tdTwo">
				<form:hidden path="office.id" id="officeId" htmlEscape="false"/>
				<form:input path="office.name" id="officeName" htmlEscape="false" ondblclick="companySelect('office')"/>
			</td>
		</tr>
		<tr>
			<td class="label">预算年份：</td>
			<td class="tdTwo">
				<input type="text"  name="budgetBelong" value="<fmt:formatDate value='${purchaseApply.applyDate}' pattern="yyyy-MM"/>" id="budgetBelong" data-toggle="topjui-textbox" data-options="width:350"/>
			</td>
			<td class="label">费用所属部门/项目：</td>
			<td class="tdTwo">
				<form:hidden path="costBelongOffice.id" id="companyId" htmlEscape="false"/>
				<form:input path="costBelongOffice.name" id="companyName" htmlEscape="false" ondblclick="companySelect('${ctx}/sys/menu/treeselect','/sys/office/treeData?type=1','companyId','companyName')"/>
			</td> 
		</tr>
		
			
		<tr>
			<td class="label">采购员：</td>
			<%-- <td class="tdTwo">
				<form:hidden path="office.id" id="officeId" htmlEscape="false"/>
				<form:input path="office.name" id="officeName" data-toggle="topjui-validatebox" htmlEscape="false" ondblclick="companySelect('office')"/>
			</td> --%>
			
		</tr>
		<tr>
	        <td class="label">附件：</td>
	        <td>
	        	<c:if test="${purchaseApply.terminationStatus eq 'editAnyway' || (purchaseApply.flowStatus eq 'create' && fn:contains(currentUserIdList,purchaseApply.createBy.id)) || empty purchaseApply.flowStatus || (purchaseApply.flowStatus eq 'approving'&& fn:contains(currentUserIdList,record.operateBy.id))||(record.operation eq '激活'&&fn:contains(currentUserIdList,record.operateBy.id))}">
				<input type="text" name="myfile" id="myfile" data-toggle="topjui-filebox" data-options="buttonIcon:'fa fa-folder',prompt:'请选择需要上传的文件...',width:350">
				</c:if>
				<table style="border: none;" id="uploadFilesAjax">
					<c:forEach items="${attachmentList}" var="attachment">
						<tr>
							<td>
								<a target="blank" href="${ctx}/upload/download?attachmentId=${attachment.id}">${attachment.fileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					        	<c:if test="${(fn:contains(currentUserIdList,attachment.createBy.id) && purchaseApply.flowStatus eq 'create')||(record.operation eq '激活'&&fn:contains(currentUserIdList,attachment.createBy.id))}">
					        	<input type="button" name="${attachment.id}" value="删除" class="commons_button" style="padding: 2px 10px 3px 10px;" onclick="ajaxRemoveInputFile(this)"/>  
				        		</c:if>
							</td>
							<td></td>
						</tr>
					</c:forEach>
				</table>
				<input type="hidden" value="${attachNo}" id="attachNo" name="attachNo"/>
				<input type="hidden" id="delFileName" name="delFileName" value=""/>
	        </td>
	    </tr>
	  			
	</table>
	
	<div id="totalContent" style="margin-left: 50px;">
		<table class="gridtable_old"  id="gylxContentControll">
			<tr><th colspan="10">购置明细列表</th></tr>
			<tr><th>序号</th><th>请购物品名称</th><th>规格/型号</th><th>申请原因</th><th>请购数量</th><th>单位</th><th>单价</th>
			<th>报价金额</th><th>期望到货日期</th><th>操作</th></tr>
			<tbody id="feiyongmingxiTbodyGY">
			<c:forEach items="${detailList}" var="detail" varStatus="status">
				<tr id="${detail.id}Tr" class="${detail.id}">
					<td style="text-align: center;font-weight: bolder;">
						${ status.index + 1}
						<%-- <div title="删除数据" class="elementStyle" onclick="deleteOneLine('${detail.id}')">删除</div> --%>
						<input id="${detail.id}" value="${detail.id}" type="hidden" name="feiyongmingxi_one"/>
					</td>
					<td><textarea maxlength="250" autoHeight="true" name="${detail.id}_name" id="${detail.id}_name" placeholder="1~50个字" style="width:100px; " data-toggle="topjui-validatebox" data-options="required:true" validtype="length[0,50]"  invalidMessage="最大长度50个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);">${detail.name }</textarea></td>
					<td><textarea maxlength="250" autoHeight="true" name="${detail.id}_size" id="${detail.id}_size" placeholder="1~50个字" style="width:100px; " data-toggle="topjui-validatebox" data-options="required:true" validtype="length[0,50]"  invalidMessage="最大长度50个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);">${detail.size }</textarea></td>
					<td><textarea maxlength="400" autoHeight="true" name="${detail.id}_reason" id="${detail.id}_reason" placeholder="1~400个字" style="width:300px; " data-toggle="topjui-validatebox" data-options="required:true" validtype="length[0,400]"  invalidMessage="最大长度400个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);">${detail.reason }</textarea><span id="${detail.id}_reasonNum"></span></td>
					<td><input name="${detail.id}_number"  id="${detail.id}_number" value="${detail.number}" data-toggle="topjui-numberbox" data-options="precision:2,groupSeparator:',',decimalSeparator:'.',width:90,required:true,prompt:'必填数字',value:'${empty detail.number?'':detail.number }',max:99999999999.99" /></td>
					<td>
					<input type="text" name="${detail.id}_unit" id="${detail.id}_unit" value="${detail.unit}" 
                       data-toggle="topjui-combobox"
                       data-options="required:true,
                       valueField:'id',
                       textField:'text',
                       readonly:${(purchaseApply.terminationStatus eq 'editAnyway' || (Apply.flowStatus eq 'create' && fn:contains(currentUserIdList,Apply.createBy.id)) || empty Apply.flowStatus || (Apply.flowStatus eq 'approving'&& fn:contains(currentUserIdList,record.operateBy.id))||(record.operation eq '激活'&&fn:contains(currentUserIdList,record.operateBy.id)))?false:true},
                       width:50,
                       data:[
                       {id:'个',text:'个'},
                       {id:'台',text:'台'},
                       {id:'公斤',text:'公斤'},
                       {id:'套',text:'套'},
                       {id:'副',text:'副'},
                       {id:'米',text:'米'},
                       {id:'平方',text:'平方'},
                       {id:'立方',text:'立方'},
                       {id:'吨',text:'吨'},
                       {id:'包',text:'包'},
                       {id:'箱',text:'箱'}
                       ]"/>
					</td> 
					<td><input name="${detail.id}_price"  id="${detail.id}_price" value="${detail.price}" data-toggle="topjui-numberbox" data-options="precision:2,groupSeparator:',',decimalSeparator:'.',width:90,required:true,prompt:'必填数字',value:'${empty detail.price?'':detail.costAll }',max:99999999999.99" /></td>
					<td><input name="${detail.id}_costAll"  id="${detail.id}_costAll" value="${detail.costAll}" data-toggle="topjui-numberbox" data-options="precision:2,groupSeparator:',',decimalSeparator:'.',width:90,required:true,prompt:'必填数字',value:'${empty detail.costAll?'':detail.costAll }',max:99999999999.99" /></td>
					<td><textarea maxlength="250" autoHeight="true"  title="${detail.id}" name="${detail.id}_deliverDate" id="${detail.id}_deliverDate" placeholder="请选择时间" style="width:170px;" readonly="readonly" data-toggle="topjui-validatebox" data-options="required:true" onclick="WdatePicker({minDate:'1999-01-01 00:00',dateFmt:'yyyy-MM-dd',isShowClear:false,skin:'default'});"><fmt:formatDate value='${detail.deliverDate}' pattern="yyyy-MM-dd"/></textarea></td>
					<td><div title="删除数据" class="elementStyle" onclick="deleteOneLine('${detail.id}')">删除</div></td>
				</tr>
			</c:forEach>
			</tbody>
			<tr><td><div title="添加一行" onclick="addOneCgmx('${ctx}')" class="elementStyle">添加</div></td><td colspan="10"></td></tr>
		</table>
		<br>
	</div>
	<br>
	<div id="totalContent" style="margin-left: 50px;">
		
		<br>
	</div>
	<c:if test="${buttonControll.canPass}">
	<table class="editTable" style="margin-left: 50px;">
		<tr>
			<td colspan="2">
			    <div class="divider">
			        <span>审批意见</span>
			    </div>
			</td>
		</tr>
		<tr>
			<td class="label" valign="top" style="vertical-align: top;">审批意见：</td>
			<td colspan="1">
				<textarea maxlength="250" autoHeight="true" name="approveRemarks" id="approveRemarks" placeholder="1~250个字符" 
            data-toggle="topjui-validatebox" validtype="length[0,250]"  invalidMessage="最大长度250个字符"  style="width: 860px;" 
            oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);"></textarea>&nbsp;&nbsp;<span id="remarksNum"></span>
			</td>
		</tr>
	</table>
    </c:if>
    </div>
    
    <table class="editTable" style="margin:10px 0 0 50px;width: 1060px;">
        <tr>
            <td colspan="2">
                <div class="divider">
                    <span>采购信息</span>
                </div>
            </td>
        </tr>
     </table>
    
   <!--   <div style="margin:20px 0 10px 0;"></div> -->
    	<table class="editTable" style="width: 1000px;margin-left: 100px;margin-bottom: 0px;" id="purchasetable">
    	
			<tr>
			<td style="margin-left: 50px;width: 100px">需要计提：</td>
			<td class="tdTwo">
				<div id="accruedRadio" class="needControlRadio">
	                <form:radiobutton path="accrued" name="accrued" value="是"/><label>是</label>
	                <form:radiobutton path="accrued" name="accrued" value="否" /><label>否</label>
	            </div>
			</td>
			<td style="margin-left: 50px;width: 100px">需要已订购：</td>
			<td class="tdTwo">
				<div id="orderRadio" class="needControlRadio">
	                <form:radiobutton path="ordery" name="ordery" value="是"/><label>是</label>
	                <form:radiobutton path="ordery" name="ordery" value="否" /><label>否</label>
	            </div>
			</td>
		</tr>    	
			<tr>
			<td style="margin-left: 50px;width: 100px">需要预付：</td>
			<td class="tdTwo">
	               <form:radiobutton id="prepaidradio" path="prepaid" name="prepaid" value="是" /><label>是</label>
	               <form:radiobutton id="prepaidradio" path="prepaid" name="prepaid" value="否" /><label>否</label>  
			</td>
			</tr>
		</table>
		
		<table class="editTable" id="prepaidtable" style="width: 1000px;margin-left: 50px;margin-bottom: 0px;" >
			<tr>
				<td style="margin-left: 50px;width: 100px">采购单位：</td>
				<td>
					<form:hidden path="office.id" id="aofficeId" htmlEscape="false"/>
					<form:input path="office.name" id="aofficeName" htmlEscape="false" ondblclick="companySelect('office')"/>
				</td>
				<td style="margin-left: 50px;width: 100px">付款方式：</td>
				<td><input type="text"  name="paytype" id="paytype" value="${payType }"
                       data-toggle="topjui-combobox"
                       data-options="required:true,
                       valueField:'id',
                       textField:'text',
                       width:150,
                       data:[
                       {id:'银行',text:'银行'},
                       {id:'现金',text:'现金'}]"/>
                 </td>
			</tr>
			<tr>
			<td style="margin-left: 50px;width: 100px">开户银行：</td>
			<td style="margin-left: 50px;width: 100px">银行账号：</td>
			</tr>
			<tr></tr>
		</table>
		
		<div id="totalContent12" style="margin-left: 50px;" >
		 <table class="gridtable_old"  id="gylxContentControll1" >
			<tr><th colspan="10">预付款信息列表</th></tr>
			<tr><th>序号</th><th>预付款信息</th><th>金额</th><th>大写金额</th><th>备注</th><th>操作</th></tr>
			<tbody id="feiyongmingxiTbodyGY1">
			<c:forEach items="${pdetailList}" var="detail" varStatus="status">
				<tr id="${detail.id}Tr" class="${detail.id}">
					<td style="text-align: center;font-weight: bolder;">
						${ status.index + 1}
						<%-- <div title="删除数据" class="elementStyle" onclick="deleteOneLine('${detail.id}')">删除</div> --%>
						<input id="${detail.id}" value="${detail.id}" type="hidden" name="yufumingxi_one"/>
					</td>
					<td><textarea maxlength="250" autoHeight="true" name="${detail.id}_prepaidInfo" id="${detail.id}_prepaidInfo" placeholder="1~50个字" style="width:200px;" data-toggle="topjui-validatebox" data-options="required:true" validtype="length[0,50]"  invalidMessage="最大长度50个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);">${detail.prepaidInfo }</textarea></td>
					<td><input name="${detail.id}_precost"  title="${detail.id }" id="${detail.id}_precost" value="${detail.precost}" data-options="precision:2,groupSeparator:',',decimalSeparator:'.',width:150,required:true,prompt:'必填数字',value:'${empty detail.precost?'':detail.precost}',max:99999999999.99" onchange="convertCurrency(value,title)"/></td> 
					<td><textarea maxlength="400" autoHeight="true" title="${detail.id }" name="${detail.id }_capital" id="${detail.id }_capital"  style="width:200px; " data-toggle="topjui-validatebox"   placeholder="自动填写"  validtype="length[0,400]">${detail.capital}</textarea></td>
					<td><textarea maxlength="400" autoHeight="true" name="${detail.id}_remarks" id="${detail.id}_remarks" placeholder="1~400个字" style="width:300px; " data-toggle="topjui-vaildatebox"  validtype="length[0,400]"  invalidMessage="最大长度400个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);">${detail.remarks}</textarea></td>
					<td><div title="删除数据" class="elementStyle" onclick="deleteOneLine('${detail.id}')">删除</div></td>
				</tr>
			</c:forEach>
			</tbody>
			<tr><td><div title="添加一行" onclick="addOneYfmx('${ctx}')" class="elementStyle">添加</div></td><td colspan="10"></td></tr>
		</table>  
		</div>
			<table class="editTable" style="margin-left: 100px;">
				<tr>
				<td style="margin-left: 50px;width: 50px">备注：</td>
				<td class="tdTwo" colspan="3">
				<textarea maxlength="500" autoHeight="true" name="remarks" id="remarks" placeholder="1~400个字" style="width:900px; " data-toggle="topjui-validatebox"  validtype="length[0,400]"  invalidMessage="最大长度400个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);">${purchaseApply.remarks }</textarea>
				</td>
			</tr>
			</table>
			<!-- <tr>
				<td style="margin-left: 50px;width: 100px">备注：</td>
				<td class="tdTwo" colspan="3">
				<textarea maxlength="400" autoHeight="true" name="remarks" id="remarks" placeholder="1~400个字" style="width:850px; " data-toggle="topjui-validatebox"  validtype="length[0,400]"  invalidMessage="最大长度400个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);"></textarea>
				</td>
			</tr>
    	</table> -->
    	<%-- <div id="aa" data-toggle="topjui-accordion" style="margin-left: 100px;width: 1000px;">
		<div title="流程审批" data-options="iconCls:'icon-ok'" style="overflow:auto;padding:10px;">
		<!-- <table class="gridtable" id="nowRecords" style="width: 970px;">
				<tr><th colspan="9">流程审批</th></tr>
				<tr>
				    <th class="print_th">流程名称</th>
			        <th class="print_th">节点名称</th>
			        <th class="print_th">节点排序</th>
			        <th class="print_th">审批操作</th>
			        <th class="print_th">审批方式</th>
			        <th class="print_th">审批用户</th>
			        <th class="print_th">授权用户</th>
			        <th class="print_th">审批时间</th>
			        <th class="print_th">审批意见</th>
				</tr>
				</table> -->
				
		</div>
	</div> --%>

    <jsp:include   page="common.jsp" flush="true"/>
	<br/>
	<br/>
	<br/>
    <br/>
    <br/>
	<div style="z-index: 9999; position: fixed ! important; left: 0px; bottom: 0px;height: 40px;width: 100%;background-color: #F3F3F3;">  
	<table style="position: absolute; left: 187px; bottom: 2px;">  
		<tr>
			<td>
				<div style="height: 34px;">
				<a href="#" id="save" class="submitButton saveButton dynamic" style="display: none;" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">确认保存</a>
				<c:if test="${purchaseApply.terminationStatus eq 'editAnyway' }">
					<!-- 表单已提交或审批中需要修改内容，单独放开保存按钮 -->
					<a href="#" id="save" class="submitButton saveButton" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">确认保存</a>
				</c:if>
				<c:choose>
					<c:when test="${purchaseApply.terminationStatus eq 'deleteAll' }">
						<!-- 已终止，只能打印 -->
						<c:if test="${!empty purchaseApply.id}">
				    		<a href="#" onclick="printPage(('${purchaseApply.id}')" data-toggle="topjui-linkbutton" data-options="id:'submitBtn',iconCls:'fa fa-print',btnCls:'topjui-btn'">打印（预览）</a>
				    	</c:if>
				    	<a href="#" onclick="javascript:return void(0);" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-trash', btnCls:'topjui-btn-brown'">表单已终止</a>
					</c:when>
					<c:otherwise>
						<!-- 正常的按钮 -->
				    	<c:if test="${buttonControll.canGetBack}">
				    		<a href="#" id="getBack" class="submitButton noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">取回</a>
				    	</c:if>
				    	<c:if test="${buttonControll.canUrge}">
				    		<a href="#" id="urge" class="submitButton noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">催办</a>
				    	</c:if>
				    	<c:if test="${buttonControll.canSave || iamCopyData eq 'yes'}">
				    		<a href="#" id="save" class="submitButton saveButton noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">确认保存</a>
				        	<a href="#" id="subForm" class="submitButton noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">提交表单</a>
				    	</c:if>
				    	<c:if test="${buttonControll.canPass}">
				    		<!-- PMC和PPC评审不能显示通过按钮 -->
				    		<c:if test="${activeSort ne 5 and activeSort ne 7 }">
				    			<a href="#" id="accredit" onclick="accreditBatch('${recordId}','${ctx }')" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-mail-forward', btnCls:'topjui-btn-normal'">授权审批</a>
				    			<a href="#" id="pass" class="submitButton noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">通过</a>
				        	</c:if>
				        	<a href="#" id="returnPre" class="submitButton noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn',iconCls:'fa fa-undo',btnCls:'topjui-btn'">退回上一步</a>
				        	<a href="#" id="returnAny" class="submitButton noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn',iconCls:'fa fa-undo',btnCls:'topjui-btn'">退回指定节点</a>
				    	</c:if>
				    	<c:if test="${buttonControll.canTelling}">
				    		<a href="#" id="readed" class="submitButton noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">已阅</a>
				    	</c:if>
				    	<c:if test="${buttonControll.canRead}">
				    		<a href="#" id="readed" class="submitButton noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">已阅</a>
				    	</c:if>
				    	<c:if test="${!empty purchaseApply.id}">
				    	<a href="#" onclick="printPage('${purchaseApply.id}','${ctx}')" class="noneedcontroll" data-toggle="topjui-linkbutton" data-options="id:'submitBtn',iconCls:'fa fa-print',btnCls:'topjui-btn'">打印（预览）</a>
				    	</c:if>
				    	<c:if test="${!empty purchaseApply.id and !empty recordId and !empty allOperatorIds and !empty currentUserId and  fn:contains(allOperatorIds,currentUserId)  and !empty purchaseApply.flowStatus and purchaseApply.flowStatus ne 'create'}">
				    		<a href="#" id="circularize" onclick="circularizeBatch('${recordId}','${ctx }')" data-toggle="topjui-linkbutton" data-options="id:'submitBtn', iconCls:'fa fa-mail-forward', btnCls:'topjui-btn-normal'">传阅</a>
				    	</c:if>
				    	<c:if test="${!empty purchaseApply.id and !empty recordId and !empty allOperatorIds and !empty record.operateBy.id and  fn:contains(currentUserIdList,record.operateBy.id) and record.operation eq '传阅' and record.recordStatus eq 'telling'}">
				    		<a href="#" id="readed" class="submitButton noneedcontroll" data-toggle="topjui-linkbutton" title="chuanyue" data-options="id:'submitBtn', iconCls:'fa fa-save', btnCls:'topjui-btn-normal'">已阅</a>
				    	</c:if>
				    </c:otherwise>
				</c:choose>
		    </div>
			</td>
		</tr>
	</table>  
	</div> 
    
</form:form>
</div>
</div>

</body>

<script type="text/javascript">	
var countFirst = 0;
var comboboxArr = new Array();
var iCombotreegridArr = new Array();

//涉及到项目的流程审批变动的，即使放开修改也不给修改
var comboboxArrMustDisable = new Array();
var radioArrMustDisable = new Array();
var iCombotreegridArrMustDisable = new Array("companyName");

//页面加载完成后执行初始化操作
$(function () {
	icheckMineInit(".needControlRadio");//初始化radio和CheckBox
	icheckMineInit(".needControlCheckBox");//初   始化radio和CheckBox
	initCompany("companyName","companyId","${ctx}");//初始化表头公司选择框
	initCompany("officeName","officeId","${ctx}");//初始化表头部门选择框
	var showContent = "${showContent}";
	if("justflow"==showContent){$("#useToControllShow").css("display","none");}
	initAfterPageLoaded(currentOperator,flowStatus);//页面加载完后做一些ajax操作，比如生成序列号
	
	//初始化表单按钮的点击事件(保存、提交、退回、取回、通过、催办...)，在Commons/jslibs/commons.form.min.js
	afterLoadPage("inputForm","form_purchase_apply","${ctx}","${ctx}/form/purchaseApply/form?","${empty recordId?record.id:recordId }"
			,flowStatus,currentOperator,"${record.workflow.id}","${record.workflowNode.id}","companyId");
	//初始化textarea高度自动调节
	intiAutoHeight();

	//用于判断表单是否可编辑
	if(operation && "传阅"==operation)
	{
		showDisable();
		$(".elementStyle").css("display","none");
	}
	if(terminationStatus && "editAnyway"==terminationStatus)
	{
		removeDisable();
		$(".elementStyle").css("display","");
	}
	else if(terminationStatus && "deleteAll"==terminationStatus)
	{
		showDisable();
		$(".elementStyle").css("display","none");
	}
	else if((flowStatus && flowStatus!="create") || (flowStatus && flowStatus=="create" && currentUserIdList.indexOf(createById)<0))
	{
		showDisable();
		$(".elementStyle").css("display","none");
	}
	else
	{
	}
	
	//radio根据数据库保存的值自动选择
	var entityId = $("#id").val();
	if(!entityId)
	{
		$("#isNewMaterialRadio").find("input:radio[name='isNewMaterial'][value='否']").iCheck('check');
		$("#isNewMaterialRadio").find("input:radio[name='isNewMaterial'][value='是']").iCheck('uncheck'); 
	}
	$("#myfile").filebox({
       	onChange: function (n,o) {
       		ajaxFileUploadEasyui('${ctx}/upload/uploadWithMultipart','myfile',10,null,'save');
       	}
   	});
	
	//请假明细里面的部门初始化
	var needInits = $(".needInitCompanySelect");
	if(needInits&&needInits.length>0)
	{
		for(var i=0;i<needInits.length;i++)
		{
			var id = $(needInits[i]).attr("title");
			initCompany(id+"_costBelongName",id+"_costBelongOffice","${ctx}",200);
		}
	}
});



function addOneCgmx(){
	var random = randomString(20);
	var html = '';
	html += '<tr id="'+random+'Tr" class="'+random+'">';
	html += '<td>';
	html += '	<div title="删除数据" class="elementStyle" onclick="deleteOneLine(\''+random+'\')">删除</div>';
	html += '	<input id="'+random+'" value="'+random+'" type="hidden" name="feiyongmingxi_one"/>';
	html += '</td>';
	html += '<td><textarea maxlength="250" autoHeight="true" name="'+random+'_name" id="'+random+'_name" placeholder="1~50个字" style="width:100px;" data-toggle="topjui-validatebox" data-options="required:true" validtype="length[0,50]"  invalidMessage="最大长度50个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);"></textarea></td>';
	html += '<td><textarea maxlength="250" autoHeight="true" name="'+random+'_size" id="'+random+'_size"  style="width:100px; " data-toggle="topjui-validatebox"  validtype="length[0,50]"  invalidMessage="最大长度50个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);"></textarea></td>';
	html += '<td><textarea maxlength="400" autoHeight="true" name="'+random+'_reason" id="'+random+'_reason" placeholder="1~400个字" style="width:200px; " data-toggle="topjui-validatebox" validtype="length[0,400]"  invalidMessage="最大长度400个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);"></textarea><span id="'+random+'_reasonNum"></span></td>';
	html += '<td><input name="'+random+'_number"  id="'+random+'_number" data-toggle="topjui-numberbox" data-options="precision:2,groupSeparator:\',\',decimalSeparator:\'.\',width:100,required:true,prompt:\'必填数字\',max:99999999999.99" /></td>';
	html +=	'<td><input type="text" name="'+random+'_unit" id="'+random+'_unit" data-toggle="topjui-combobox" data-options="required:true,valueField:\'id\',textField:\'text\',width:50,data:[{id:\'个\',text:\'个\'},{id:\'台\',text:\'台\'},{id:\'公斤\',text:\'公斤\'},{id:\'套\',text:\'套\'},{id:\'副\',text:\'副\'},{id:\'米\',text:\'米\'},{id:\'平方\',text:\'平方\'},{id:\'立方\',text:\'立方\'},{id:\'吨\',text:\'吨\'},{id:\'包\',text:\'包\'},{id:\'箱\',text:\'箱\'}]"/></td>';
	html +=	'<td><input name="'+random+'_price"  id="'+random+'_price"  data-toggle="topjui-numberbox" data-options="precision:2,groupSeparator:\',\',decimalSeparator:\'.\',width:80,required:true,prompt:\'必填数字\',max:99999999999.99" /></td>';
	html += '<td><input name="'+random+'_costAll"  id="'+random+'_costAll" data-toggle="topjui-numberbox" data-options="precision:2,groupSeparator:\',\',decimalSeparator:\'.\',width:80,prompt:\'必填数字\',max:99999999999.99" /></td>';
	html += '<td><textarea maxlength="250" autoHeight="true" title="'+random+'" name="'+random+'_deliverDate" id="'+random+'_deliverDate" placeholder="请选择时间" style="width:170px; " data-toggle="topjui-validatebox" data-options="required:true" onclick="initDliverDate(\''+random+'\')" readonly="readonly"></textarea></td>';  
	html += '<td>';
	html += '<div title="删除数据" class="elementStyle" onclick="deleteOneLine(\''+random+'\')">删除</div>';
	html += '</td>';
	html += '</tr>';
	$("#feiyongmingxiTbodyGY").append(html);
	intiAutoHeight();
	$.parser.parse($('#'+random+"Tr"));
}
//添加一行预付款
function addOneYfmx(){
	var random = randomString(20);
	var html = '';
	html += '<tr id="'+random+'Tr" class="'+random+'">';
	html += '<td>';
	html += '	<div title="删除数据" class="elementStyle" onclick="deleteOneLine(\''+random+'\')">删除</div>';
	html += '	<input id="'+random+'" value="'+random+'" type="hidden" name="yufumingxi_one"/>';
	html += '</td>';
	html += '<td><textarea maxlength="250" autoHeight="true" name="'+random+'_prepaidInfo" id="'+random+'_prepaidInfo" placeholder="1~50个字" style="width:200px;" data-toggle="topjui-validatebox" data-options="required:true" validtype="length[0,50]"  invalidMessage="最大长度50个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);"></textarea></td>';
	html +=	'<td><input name="'+random+'_precost" title="'+random+'" id="'+random+'_precost" required="true" onChange="convertCurrency(value,title)" /></td>';
	//data-toggle="topjui-numberbox" data-options="precision:2,groupSeparator:\',\',decimalSeparator:\'.\',width:150,required:true,prompt:\'必填数字\',max:99999999999.99,onChange:\'convertCurrency(value,title)\'"  data-toggle="topjui-validatebox""
 	html += '<td><input maxlength="400" autoHeight="true" title="'+random+'" name="'+random+'_capital" id="'+random+'_capital"  style="width:200px; "   placeholder="自动填写" validtype="length[0,400]" /></td>';
	html += '<td><textarea maxlength="400" autoHeight="true" name="'+random+'_remarks" id="'+random+'_remarks" placeholder="1~400个字" style="width:300px; " data-toggle="topjui-vaildatebox"  validtype="length[0,400]"  invalidMessage="最大长度400个字" oninput="return LessThan(this);" onchange="return LessThan(this);" onpropertychange="return LessThan(this);"></textarea></td>';
	html += '<td>';
	html += '<div title="删除数据" class="elementStyle" onclick="deleteOneLine(\''+random+'\')">删除</div>';
	html += '</td>';
	html += '</tr>';
	$("#feiyongmingxiTbodyGY1").append(html);
	intiAutoHeight();
	$.parser.parse($('#'+random+"Tr"));
}

//初始化请假明细的时间选择框
//初始化时间选择
function initDliverDate(title){
	
	WdatePicker({maxDate:'9999-12-30',minDate:'%y-%M-%d', dateFmt:'yyyy-MM-dd',isShowClear:false,skin:'default'});
}


//页面加载完成之后的一些初始化操作
function initAfterPageLoaded(currentOperator,flowStatus){
	var purchaseApplyId = "${purchaseApply.id}";
	var thisIsCopyData = "${thisIsCopyData}";//复制的时候也要重新生成
	if(!purchaseApplyId || ""==purchaseApplyId )//|| (thisIsCopyData&&thisIsCopyData=="yes")
	{
		//生成试样单单号
		initTestSampleNumber();
	}
	intiAutoHeight();
}

//生成试样单号
function initTestSampleNumber()
{
	$.ajax({
	    type: "GET",
	    url: "${ctx}/form/purchaseApply/createProjectNumber",
	    //data: {},
	    dataType: "json",
	    beforeSend: function () {
            $.messager.progress({
                text: "正在操作..."
            })
        },
	    success: function(data){
	    	//console.log(data);
	    	$.messager.progress("close");
	   		$("#projectNumber").textbox("setValue",data.statusCode);
	    },
	    error: function(data){
	    	$.messager.progress("close");
	    }
	});
}

//对于比较复杂或者验证框架不好实现的验证在这里进行验证
function otherValidate(){  
	var result = true;
	
	return result;
}

//保存之前做的一些验证
function validateBeforeSave(saveFlag){  
	var result = true;
	
	return result;
} 
//表单提交之前做的一些验证
function addValidateBefore(){}
//对于自动检索输入框的值进行设置等
function setFormSelect(){
	var all = $("input[name='feiyongmingxi_one']");
	var allDetailIds = "";
	if(all.length>0)
	{
		for(var i=0;i<all.length;i++)
		{
			var detai = $(all[i]).val();
			allDetailIds+=detai+",";
		}
	}
	$("#feiyongmingxi_radio_name").val(allDetailIds);
	//
	var pall = $("input[name='yufumingxi_one']");
	var pallDetailIds = "";
	if(pall.length>0)
	{
		for(var i=0;i<pall.length;i++)
		{
			var pdetai = $(pall[i]).val();
			pallDetailIds+=pdetai+",";
		}
	}
	$("#yufumingxi_radio_name").val(pallDetailIds);
}

//删除一条请假明细行
function deleteOneLine(val){
	$.messager.confirm("提示", "确定删除数据么？", function (data) {
		if(data)
		{
			var ids = $("#deleteDetails").val();
			ids+=","+val;
			$("#deleteDetails").val(ids);
			$("#"+val+"Tr").remove();
		}
	});
}

//打印
function printPage(id){
	var url = "${ctx}/form/purchaseApply/form?printPage=printPage&id="+id;
	printPageR(url);
}

//获取两个时间相差的小时数
function getInervalHour_bak(startDate, endDate) {
    var ms = endDate.getTime() - startDate.getTime();
    if (ms < 0) return 0;
    return (ms/1000/60/60).toFixed(2);
}
//预付款radio SHOW
/* 
} */
//大写金额转换
function convertCurrency(money,title) {
	
	  //汉字的数字
	  var cnNums = new Array('零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖');
	  //基本单位
	  var cnIntRadice = new Array('', '拾', '佰', '仟');
	  //对应整数部分扩展单位
	  var cnIntUnits = new Array('', '万', '亿', '兆');
	  //对应小数部分单位
	  var cnDecUnits = new Array('角', '分', '毫', '厘');
	  //整数金额时后面跟的字符
	  var cnInteger = '整';
	  //整型完以后的单位
	  var cnIntLast = '元';
	  //最大处理的数字
	  var maxNum = 999999999999999.9999;
	  //金额整数部分
	  var integerNum;
	  //金额小数部分
	  var decimalNum;
	  //输出的中文金额字符串
	  var chineseStr = '';
	  //分离金额后用的数组，预定义
	  var parts;
	  if (money == '') { return  $("#"+title+"_capital").val("零元整"); }
	  money = parseFloat(money);
	  if (money >= maxNum) {
	    //超出最大处理数字
	    return '';
	  }
	  if (money == 0) {
	    chineseStr = cnNums[0] + cnIntLast + cnInteger;
	    return chineseStr;
	  }
	  //转换为字符串
	  money = money.toString();
	  if (money.indexOf('.') == -1) {
	    integerNum = money;
	    decimalNum = '';
	  } else {
	    parts = money.split('.');
	    integerNum = parts[0];
	    decimalNum = parts[1].substr(0, 4);
	  }
	  //获取整型部分转换
	  if (parseInt(integerNum, 10) > 0) {
	    var zeroCount = 0;
	    var IntLen = integerNum.length;
	    for (var i = 0; i < IntLen; i++) {
	      var n = integerNum.substr(i, 1);
	      var p = IntLen - i - 1;
	      var q = p / 4;
	      var m = p % 4;
	      if (n == '0') {
	        zeroCount++;
	      } else {
	        if (zeroCount > 0) {
	          chineseStr += cnNums[0];
	        }
	        //归零
	        zeroCount = 0;
	        chineseStr += cnNums[parseInt(n)] + cnIntRadice[m];
	      }
	      if (m == 0 && zeroCount < 4) {
	        chineseStr += cnIntUnits[q];
	      }
	    }
	    chineseStr += cnIntLast;
	  }
	  //小数部分
	  if (decimalNum != '') {
	    var decLen = decimalNum.length;
	    for (var i = 0; i < decLen; i++) {
	      var n = decimalNum.substr(i, 1);
	      if (n != '0') {
	        chineseStr += cnNums[Number(n)] + cnDecUnits[i];
	      }
	    }
	  }
	  if (chineseStr == '') {
	    chineseStr += cnNums[0] + cnIntLast + cnInteger;
	  } else if (decimalNum == '') {
	    chineseStr += cnInteger;
	  }
	 
	 $("#"+title+"_capital").val(chineseStr);
	}



//根据每一行请假明细行统计小时数


</script>
</html>