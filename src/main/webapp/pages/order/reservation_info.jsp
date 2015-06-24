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
function getOffices(){
	var buuid=$("#buuid").val();
	$("#offuuid option").remove();
	$("#offuuid").append("<option value=''>请选择</option>");
	if(buuid != ""){
		$.post("${path}/position/office/getOfficeByBuilding.json", {
			"building_uuid" : buuid
		}, function(data) {
			for(var i=0;i<data.length;i++){
				$("#offuuid").append("<option value='"+data[i].uuid+"'>"+data[i].code+"</option>");
			}
		});
	}
}

</script>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-hidden="true">&times;</button>
	<h4 class="modal-title">编辑订单</h4>
</div>
<div class="modal-body">
	<form id="editForm" class="pagination_form form-horizontal" role="form" method="POST" action="${path}/order/reservation/save.json">
		<input type="hidden" name="uuid" id="uuid" value="${reservation.uuid }"/>
		<c:if test="${reservation.reservationNum != null && reservation.reservationNum != '' }">
		<div class="form-group">
			<label class="col-sm-3 control-label">预订号：</label>
			<label class="col-sm-9 control-label" style="text-align: left;">${reservation.reservationNum}</label>
		</div>
		</c:if>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="building_uuid">办公楼：</label>
			<div class="col-sm-9">
				<select id="buuid" name="building.uuid" class="form-control input-sm" onchange="getOffices()">
                     <c:forEach items="${buildinglist}" var="building">
                     		<c:choose>
                     			<c:when test="${building.uuid == reservation.building.uuid}"><option value="${building.uuid}" selected="selected">${building.title}</option></c:when>
                     			<c:otherwise><option value="${building.uuid}">${building.title}</option></c:otherwise>
                     		</c:choose>
                             
                   </c:forEach>
             </select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="office_uuid">办公室/办公桌：</label>
			<div class="col-sm-9">
			<select id="offuuid" name="office.uuid" class="form-control input-sm" data-rule-required="true">
                     <c:forEach items="${officelist}" var="office">
                     		<c:choose>
                     			<c:when test="${office.uuid == reservation.office.uuid}"><option value="${office.uuid}" selected="selected">${office.code}</option></c:when>
                     			<c:otherwise><option value="${office.uuid}">${office.code}</option></c:otherwise>
                     		</c:choose>
                             
                   </c:forEach>
             </select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="startDate">开始日期：</label>
			<div class="col-sm-9">
				<input id="startDatestr" name="startDatestr" class="form-control w4" type="text" value="${reservation.startDate}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,readOnly:true})"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="duration">租用周期（月）：</label>
			<div class="col-sm-9">
                 <input type="text" name="duration" id="duration" value="${reservation.duration}" class="form-control input clearText" data-rule-positiveIntegerNum="true"
									maxlength="4" placeholder="租用周期"/>
			</div>
		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	<button type="button" class="btn btn-primary" onclick="submitForm()">保存</button>
</div>
