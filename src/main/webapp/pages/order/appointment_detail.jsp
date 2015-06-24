<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<div class="modal-header">
	<span style="font-weight:bold;font-size:18px;">预约单详情</span>
</div>
<div class="modal-body">
	<div class="panel panel-info">
		<div class="panel-heading">办公楼信息</div>
		<div class="panel-body">
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">名称：</label></div>
				<div class="form-group col-xs-5">${appointment.building.title}</div>
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">区域：</label></div>
				<div class="form-group col-xs-5">${appointment.building.region}</div>
			</div>
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">地址：</label></div>
				<div class="form-group col-xs-11">${appointment.building.address}</div>
			</div>
			<%-- <div class="form-group col-xs-12">
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">描述：</label></div>
				<div class="form-group col-xs-11">${appointment.building.description}</div>
			</div> --%>
		</div>
	</div>
	<c:if test="${appointment.user.uuid != null && appointment.user.uuid != ''}">
	<div class="panel panel-info">
		<div class="panel-heading">预约会员信息</div>
		<div class="panel-body">
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">用户名：</label></div>
				<div class="form-group col-xs-4">${appointment.user.loginName}</div>
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">姓名：</label></div>
				<div class="form-group col-xs-4">${appointment.user.name}</div>
			</div>
		</div>
	</div>
	</c:if>
	<div class="panel panel-info">
		<div class="panel-heading">预约单信息</div>
		<div class="panel-body">
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">预约号：</label></div>
				<div class="form-group col-xs-4">${appointment.appointmentNum}</div>
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">申请人：</label></div>
				<div class="form-group col-xs-4">${appointment.applicantName}</div>
			</div>
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">联系电话：</label></div>
				<div class="form-group col-xs-4">${appointment.telphone}</div>
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">邮箱：</label></div>
				<div class="form-group col-xs-4">${appointment.email}</div>
			</div>
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">参观日期：</label></div>
				<div class="form-group col-xs-4">${appointment.visitDate}</div>
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">参观时间：</label></div>
				<div class="form-group col-xs-4"><fmt:formatDate value="${appointment.visitTime}" pattern="HH:00"/></div>
			</div>
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">参观人数：</label></div>
				<div class="form-group col-xs-4">${appointment.vistorNum}人</div>
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">预约时间：</label></div>
				<div class="form-group col-xs-4"><fmt:formatDate value="${appointment.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
			</div>
		</div>
	</div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal" onclick="window.location.href='${path}/order/appointment/tolist.vhtml'">返回</button>
</div>
