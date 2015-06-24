<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="${path}/scripts/My97DatePicker/WdatePicker.js" ></script>
<script type="text/javascript">

$(function(){
	_form = $("#editForm").validate();
});

function submitForm() {
    if(_form.form()){
    	$("#editForm").ajaxSubmit({
            type: 'post',
            success: function (data) {
            	if(data.success){
            		 $("#userInfoDiv").modal("hide");
                     $(grid_selector).setGridParam({url:data_url}).trigger("reloadGrid");
            	} else{
            		alert(data.errmsg);
            	}
              
            }
        });
    }
}


</script>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-hidden="true">&times;</button>
	<h4 class="modal-title">预约单信息</h4>
</div>
<div class="modal-body">
	<form id="editForm" class="pagination_form form-horizontal" role="form" method="POST" action="${path}/order/appointment/save.json">
		<input type="hidden" name="uuid" id="uuid" value="${appointment.uuid }"/>
		<c:if test="${appointment.appointmentNum != null && appointment.appointmentNum != '' }">
		<div class="form-group">
			<label class="col-sm-3 control-label" for="visitTime">预约号：</label>
			<label class="col-sm-9 control-label" style="text-align: left;">${appointment.appointmentNum}</label>
		</div>
		</c:if>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="visitTime">申请人：</label>
			<div class="col-sm-9">
				<input type="text" id="applicantName" name="applicantName" placeholder="申请人"  value="${appointment.applicantName}" class="form-control input clearText" 
				data-rule-required="true"
							data-msg-required="请录入申请人。" data-rule-minlength="2"
							data-msg-minlength="用户名最少为2个字符" data-rule-maxlength="10"
							data-msg-maxlength="用户名最大为10个字符"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="visitTime">联系电话：</label>
			<div class="col-sm-9">
				  <input type="text" name="telphone" id="telphone" value="${appointment.telphone}" class="form-control input clearText {tel:true}" data-rule-iphone="true"
									data-msg-tel="电话格式错误，请确认你录入的电话。" maxlength="20"
									placeholder="电话"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="visitDatestr">参观日期：</label>
			<div class="col-sm-9">
				<input id="visitDatestr" name="visitDatestr" class="form-control w4" type="text" value="${appointment.visitDatestr}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false, readOnly:true})"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="visitTimestr">参观时间：</label>
			<div class="col-sm-9">
				<input id="visitTimestr" name="visitTimestr" class="form-control w4" type="text" value="${appointment.visitTimestr}" onFocus="WdatePicker({dateFmt:'HH:00',isShowClear:false, readOnly:true})"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="vistorNum">来访人数：</label>
			<div class="col-sm-9">
                 <input type="text" name="vistorNum" id="vistorNum" value="${appointment.vistorNum}" class="form-control input clearText {digits:true}" data-rule-number="true" maxlength="4" placeholder="来访人数"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="vistorNum">参观者公司：</label>
			<div class="col-sm-9">
				<input type="text" id="company" name="company" value="${appointment.company}" class="form-control input clearText"
           	 						maxlength="50" placeholder="参观者公司" data-msg-required="请录入参观者公司" />
			</div>
		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	<button type="button" class="btn btn-primary" onclick="submitForm()">保存</button>
</div>
