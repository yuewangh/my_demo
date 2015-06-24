<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<div class="modal-header">
	<span style="font-weight:bold;font-size:18px;">预订单详情</span>
</div>
<div class="modal-body">
	<div class="panel panel-info">
		<div class="panel-heading">办公楼信息</div>
		<div class="panel-body">
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">名称：</label></div>
				<div class="form-group col-xs-5">${reservation.building.title}</div>
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">区域：</label></div>
				<div class="form-group col-xs-5">${reservation.building.region}</div>
			</div>
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">地址：</label></div>
				<div class="form-group col-xs-11">${reservation.building.address}</div>
			</div>
			<%-- <div class="form-group col-xs-12">
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">描述：</label></div>
				<div class="form-group col-xs-11">${reservation.building.description}</div>
			</div> --%>
		</div>
	</div>
	<div class="panel panel-info">
		<div class="panel-heading">
			<c:choose>
				<c:when test="${reservation.office.type == '1'}">办公室信息</c:when>
				<c:when test="${reservation.office.type == '0'}">办公桌信息</c:when>
			</c:choose>
		</div>
		<div class="panel-body">
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">名称：</label></div>
				<div class="form-group col-xs-5">${reservation.office.title}</div>
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">编号：</label></div>
				<div class="form-group col-xs-5">${reservation.office.code}</div>
			</div>
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">单价：</label></div>
				<div class="form-group col-xs-5">${reservation.office.unitPrice}元/月</div>
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">工位：</label></div>
				<div class="form-group col-xs-5">${reservation.office.capactity}座</div>
			</div>
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-1 text-right"><label for="" class="control-label">描述：</label></div>
				<div class="form-group col-xs-11">${reservation.office.description}</div>
			</div>
		</div>
	</div>
	<div class="panel panel-info">
		<div class="panel-heading">订单信息</div>
		<div class="panel-body">
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">预订号：</label></div>
				<div class="form-group col-xs-4">${reservation.reservationNum}</div>
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">申请人：</label></div>
				<div class="form-group col-xs-4">${reservation.user.name}</div>
			</div>
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">开始日期：</label></div>
				<div class="form-group col-xs-4">${reservation.startDate}</div>
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">结束日期：</label></div>
				<div class="form-group col-xs-4">${reservation.endDate}</div>
			</div>
			<div class="form-group col-xs-12">
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">租用周期：</label></div>
				<div class="form-group col-xs-4">${reservation.duration}月</div>
				<div class="form-group col-xs-2 text-right"><label for="" class="control-label">订单总额：</label></div>
				<div class="form-group col-xs-4">${reservation.totalPrice}元</div>
			</div>
			<c:choose>
			<c:when test="${reservation.ableState ==2}">
				<div class="form-group col-xs-12">
					<div class="form-group col-xs-2 text-right"><label for="" class="control-label">是否成交：</label></div>
					<div class="form-group col-xs-4">已成交</div>
					<div class="form-group col-xs-2 text-right"><label for="" class="control-label">成交金额：</label></div>
					<div class="form-group col-xs-4">${reservation.finalPrice}元</div>
				</div>
				<div class="form-group col-xs-12">
					<div class="form-group col-xs-2 text-right"><label for="" class="control-label">预订时间：</label></div>
					<div class="form-group col-xs-4"><fmt:formatDate value="${reservation.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
					<div class="form-group col-xs-2 text-right"><label for="" class="control-label">成交时间：</label></div>
					<div class="form-group col-xs-4"><fmt:formatDate value="${reservation.finalDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="form-group col-xs-12">
					<div class="form-group col-xs-2 text-right"><label for="" class="control-label">是否成交：</label></div>
					<div class="form-group col-xs-4">未成交</div>
					<div class="form-group col-xs-2 text-right"><label for="" class="control-label">预订时间：</label></div>
					<div class="form-group col-xs-4"><fmt:formatDate value="${reservation.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
				</div>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal" onclick="window.location.href='${path}/order/reservation/tolist.vhtml'">返回</button>
</div>
