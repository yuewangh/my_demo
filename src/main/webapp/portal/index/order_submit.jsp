
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<c:import url="/portal/includes/head-libs.jsp" />
</head>
<body>

	<section>
		<div class="container  m_4">
			<div class="col-lg-12">
				<h3 class="ordertop_border">用户信息</h3>
			</div>
			<div class="col-lg-8 col-sm-8 m_5">
				<form>
					<div class="col-lg-12 m_4">
						<label class="control-label col-md-2 text-right">姓名：</label>
						<div class="col-md-7">
							${user.name}
						</div>
					</div>

					<div class="col-lg-12 m_4">
						<label class="control-label col-md-2 text-right">手机：</label>
						<div class="col-md-7 ">
							${user.tel}
						</div>
					</div>
					<div class="col-lg-12 m_4">
						<label class="control-label col-md-2 text-right">邮箱：</label>
						<div class="col-md-7">
							${user.mail}
						</div>
					</div>
					<div class="col-lg-12 m_4">
						<label class="control-label col-md-2 text-right">工作单位：</label>
						<div class="col-md-7">
							${user.unit}
						</div>
					</div>
				</form>
			</div>
			<div class="col-lg-12 m_4">
				
					<h3 class="ordertop_border">确认订单信息</h3>
				
			</div>
			<div class="col-lg-12 col-sm-12">
				<table class="table table-hover table-striped table-bordered user_teblea">
					<tr bgcolor="#eee">
						<th class="text-center">办公位置</th>
						<th class="text-center">办公室/办公桌</th>
						<th class="text-center">名称</th>
						<th class="text-center">编号</th>
						<th class="text-center">面积（平米）</th>
						<th class="text-center">座位数</th>
						<th class="text-center">租期</th>
						<th class="text-center">租金（元）</th>
					</tr>
					<c:forEach items="${officelist}" var="office">
					<tr>
						<td class="text-center">${office.buildingTitle}</td>
						<td class="text-center">
							<c:choose>
								<c:when test="${office.type == '0'}">办公桌</c:when>
								<c:otherwise>办公室</c:otherwise>
							</c:choose>
						</td>
						<td class="text-center">${office.title}</td>
						<td class="text-center">${office.code}</td>
						<td class="text-center">${office.area}</td>
						<td class="text-center">${office.capactity}</td>
						<td class="text-center">${office.zuqi}</td>
						<td class="text-center">${office.zujing}</td>
					</tr>
					</c:forEach>
				</table>
				<div class="col-lg-12 col-sm-12  activ_button text-center m_4">
					<button class="btn btn-lg btn-warning" onclick="submit()" id="subbtn">提交申请</button>
				</div>
			</div>

		</div>
	</section>
	<script>
function submit(){
	if(confirm("您确定要提交吗？")){
		$("#subbtn").attr("disabled", true);
		$.post("${path}/portal/personaCenter/reservation/save.json", {
			"office_uuids" : '${office_uuids}',
			"building_uuid" : '${building_uuid}',
			"startDatestr" : '${startDatestr}',
			"endDatestr" : '${endDatestr}',
			"duration" : '${duration}'
		}, function(data) {
			if(data.success){
				alert(data.sucmsg);
				window.parent.opener.location.reload();
				//window.parent.close();
				window.location.href="${path}/portal/index.vhtml";
			} else{
				alert(data.errmsg);
				$("#subbtn").removeAttr("disabled");
			}
		});
	}
}
</script>
</body>
</html>