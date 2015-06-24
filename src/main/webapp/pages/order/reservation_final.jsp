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
               $("#userInfoDiv").modal("hide");
               $(grid_selector).setGridParam({url:data_url}).trigger("reloadGrid");
            }
        });
    }
}
</script>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-hidden="true">&times;</button>
	<h4 class="modal-title">订单成交</h4>
</div>
<div class="modal-body">
	<form id="editForm" class="pagination_form form-horizontal" role="form" method="POST" action="${path}/order/reservation/makeBargain.json">
		<input type="hidden" name="uuid" id="uuid" value="${uuid }"/>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="duration">成交金额：</label>
			<div class="col-sm-9">
                 <input type="text" name="finalPrice" id="finalPrice" value="${money}" class="form-control input clearText" data-rule-required="true" data-rule-precision2="true" placeholder="成交金额" />
			</div>
		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	<button type="button" class="btn btn-primary" onclick="submitForm()">保存</button>
</div>
