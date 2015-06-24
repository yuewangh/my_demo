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
getOffices(0);
function getOffices(isjs){
	$("#tst").val($("#tst").val()+"1");
	var buuid=$("#buuid").val();
	if(buuid == ""){
		return;
	}
	var startDatestr=$("#startDatestr").val();
	if(startDatestr == ""){
		return;
	}
	var duration=$("#duration").val();
	if(duration == ""){
		return;
	}else if(!(/^[1-9]\d*$/.test(duration))){
		return;
	}
	var type = $('input:radio[name="type"]:checked').val();
	$("#offuuid option").remove();
	if(buuid != ""){
		$.post("${path}/order/lease/getAbleOffices.json", {
			"building_uuid" : buuid,
			"startDatestr" : startDatestr,
			"duration" : duration,
			"type" : type
		}, function(data) {
			var seloff = "${reservation.office.uuid}";
			var seltype = "${reservation.office.type}";
			var selbuilding = "${reservation.building.uuid}";
			if(seloff != ""){
				if(seltype == type && selbuilding == buuid){
					$("#offuuid").append("<option value='${reservation.office.uuid}'>${reservation.office.code}(${reservation.office.unitPrice}元/月)"+"</option>");
				}
			}else{
				$("#offuuid").append("<option value=''>请选择</option>");
			}
			for(var i=0;i<data.length;i++){
				$("#offuuid").append("<option value='"+data[i].uuid+"'>"+data[i].code+"("+data[i].unitPrice+"元/月)"+"</option>");
			}
			var textvl=$("#offuuid option:selected").text();
			var st = textvl.indexOf("(")+1;
			var unitPrice = textvl.substring(st,(textvl.length-4));
			$("#unitPrice").val(unitPrice);
			if(isjs !=  0){
				jisuan();
			}
		});
	}
}
function turnoffice(){
	var textvl=$("#offuuid option:selected").text();
	var st = textvl.indexOf("(")+1;
	var unitPrice = textvl.substring(st,(textvl.length-4));
	$("#unitPrice").val(unitPrice);
	jisuan();
}
function jisuan(){
	var duration=$("#duration").val();
	if(duration == ""){
		duration=0;
	}
	var unitPrice=$("#unitPrice").val();
	if(unitPrice == ""){
		unitPrice=0;
	}
	var finalPrice = parseFloat(unitPrice)*parseInt(duration);
	$("#finalPrice").val(finalPrice);
}
</script>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-hidden="true">&times;</button>
	<h4 class="modal-title">
		<c:choose>
			<c:when test="${reservation.uuid == null || reservation.uuid == ''}">新增订单</c:when>
			<c:otherwise>编辑订单</c:otherwise>
		</c:choose>
	</h4>
</div>
<div class="modal-body">
	<form id="editForm" class="pagination_form form-horizontal" role="form" method="POST" action="${path}/order/lease/save.json">
		<input type="hidden" name="uuid" id="uuid" value="${reservation.uuid }"/>
		<input type="hidden" name="ableState" id="ableState" value="2"/>
		<input type="hidden" name="unitPrice" id="unitPrice" value="${reservation.office.unitPrice}"/>
		<c:if test="${reservation.reservationNum != null && reservation.reservationNum != '' }">
		<div class="form-group">
			<label class="col-sm-3 control-label">预订号：</label>
			<label class="col-sm-9 control-label" style="text-align: left;">${reservation.reservationNum}</label>
		</div>
		</c:if>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="building_uuid">办公楼：</label>
			<div class="col-sm-9">
				<select id="buuid" name="building.uuid" class="form-control input-sm" onchange="getOffices(1)">
                     		<option value=''>请选择</option>
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
			<label class="col-sm-3 control-label" for="startDate">开始日期：</label>
			<div class="col-sm-9">
				<input id="startDatestr" name="startDatestr" class="form-control w4" type="text" value="${reservation.startDate}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,readOnly:true})" onchange="getOffices(1)"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="duration">租用周期（月）：</label>
			<div class="col-sm-9">
                 <input type="text" name="duration" id="duration" value="${reservation.duration}" class="form-control input clearText" data-rule-positiveIntegerNum="true"
									maxlength="4" placeholder="租用周期" onchange="getOffices(1)"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"></label>
			<div class="col-sm-9 radio">
				<c:choose>
					<c:when test="${reservation.office.type == 0}">
						 <label><input type="radio" name="type" value="1" onclick="getOffices(1)">办公室</label>
				 	    <label><input type="radio" name="type" checked="checked" value="0" onclick="getOffices(1)">办公桌</label>
						
					</c:when>
					<c:otherwise>
						 <label><input type="radio" name="type" checked="checked" value="1" onclick="getOffices(1)">办公室</label>
						 <label><input type="radio" name="type" value="0" onclick="getOffices(1)">办公桌</label>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="office_uuid">办公室/办公桌：</label>
			<div class="col-sm-9">
			<select id="offuuid" name="office.uuid" class="form-control input-sm" data-rule-required="true" onchange="turnoffice()">
             </select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="duration">成交金额：</label>
			<div class="col-sm-9">
                <input type="text" name="finalPrice" id="finalPrice" value="${reservation.finalPrice}" class="form-control input clearText" data-rule-required="true" data-rule-precision3="true" placeholder="成交金额" />
			</div>
		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	<button type="button" class="btn btn-primary" onclick="submitForm()">保存</button>
</div>
