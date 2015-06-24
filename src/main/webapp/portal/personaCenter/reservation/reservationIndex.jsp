<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <c:import url="/portal/includes/personaHead-libs.jsp"/>
</head>
<body>
<section id="user_info">
  <!-- top start -->
  <c:import url="/portal/personaCenter/top.jsp"/>
  <!-- top end -->
  <div class="container user_teble m_5">
  <form class="pagination_form">
 <h2 class="text-left m_4">在线订单</h2>
 	<table class="table table-hover table-striped table-bordered user_teblea ">
        <tr > 
        	<th class="text-center">预订号</th>
        	<th class="text-center">办公楼</th>
            <th class="text-center">办公室/办公桌</th>
            <th class="text-center">名称</th>
            <th class="text-center">编号</th>
            <th class="text-center">单价（元/月）</th>
            <th class="text-center">开始日期</th>
            <th class="text-center">结束日期</th>
            <th class="text-center">租用周期（月）</th>
            <th class="text-center">是否成交</th>
            <th class="text-center">操作</th>
        </tr>
      <c:forEach items="${pageModel.rows}" var="reservation">
        	  <tr>
		        	<td class="text-center">${reservation.reservationNum}</td>
		            <td>${reservation.building.title}</td>
		             <td class="text-center">
							<c:choose>
								<c:when test="${reservation.office.type == '0'}">办公桌</c:when>
								<c:otherwise>办公室</c:otherwise>
							</c:choose>
						</td>
						<td class="text-center">${reservation.office.title}</td>
						<td class="text-center">${reservation.office.code}</td>
						<td class="text-center">${reservation.office.unitPrice}</td>
		            <td class="text-center">${reservation.startDate}</td>
		            <td class="text-center">${reservation.endDate}</td>
		            <td class="text-center">${reservation.duration}</td>
		            <td class="text-center">
		            <c:choose>
		            	<c:when test="${reservation.ableState == '2'}">已成交</c:when>
		            	<c:when test="${reservation.ableState == '1'}">未成交</c:when>
		            </c:choose>
		            </td>
		            <td class="text-center">
		            	<c:if test="${reservation.ableState != '2'}"><a href="#" onclick="cancelfun('${reservation.uuid}')">取消订单</a></c:if>
		            </td>
		        </tr>
        </c:forEach>
    </table>
	<c:import url="/portal/includes/pagination.jsp"/>                    
  </form>
 </div> 
 
</section>
<script type="text/javascript">
function cancelfun(uuid){
	if(confirm("您确定要取消此订单吗？")){
		$.post("${path}/order/reservation/delete.json", {
			"id" :uuid
		}, function(data) {
			if(data.success){
				alert("订单取消成功！");
				window.location.reload();
			} else{
				alert(data.errmsg);
			}
		});
	}
	
}
</script> 
</body>
</html>