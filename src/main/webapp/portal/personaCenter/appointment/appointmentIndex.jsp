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
 <h2 class="text-left m_4">我的预约</h2>
 	<table class="table table-hover table-striped table-bordered user_teblea ">
    	<tr > 
        	<th class="text-center">预约号</th>
        	<th class="text-center">参观地点</th>
            <th class="text-center">参观日期</th>
            <th class="text-center">参观时间</th>
            <th class="text-center">参观人数</th>
            <th class="text-center">预约人姓名</th>
            <th class="text-center">联系电话</th>
            <th class="text-center">电子邮箱</th>
            <th class="text-center">操作</th>
        </tr>
        <c:forEach items="${pageModel.rows}" var="appointment">
        	  <tr>
		        	<td class="text-center">${appointment.appointmentNum}</td>
		            <td>${appointment.building.title}</td>
		            <td class="text-center">${appointment.visitDatestr}</td>
		            <td class="text-center">${appointment.visitTimestr}</td>
		            <td class="text-center">${appointment.vistorNum}</td>
		            <td class="text-center">${appointment.applicantName}</td>
		            <td class="text-center">${appointment.telphone}</td>
		            <td class="text-center">${appointment.email}</td>
		            <td class="text-center"><a href="#" onclick="cancelfun('${appointment.uuid}')">取消预约</a></td>
		        </tr>
        </c:forEach>
    </table>
	<c:import url="/portal/includes/pagination.jsp"/>                    
  </form>
 </div> 
</section>
<script type="text/javascript">

function cancelfun(uuid){
	if(confirm("您确定要取消此预约吗？")){
		$.post("${path}/order/appointment/delete.json", {
			"id" :uuid
		}, function(data) {
			if(data.success){
				alert("预约取消成功！");
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