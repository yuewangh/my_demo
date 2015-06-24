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
    <script type="text/javascript">
//     $(function(){
//     	$.post("${path}/portal/personaCenter/notice/getList.json",function(data){
//     		var messageListJson = data.rows;
//     		for(var index in messageListJson){
//     			$("#messageList").append("<h4>"+messageListJson[index].title+"</h4>")
// 				 .append("<p>"+messageListJson[index].content+"</p><br/>");
// //     		$("#messageList").append("<a style='cursor:pointer' href='${path}/portal/personaCenter/notice/messageView.vhtml?uuid="+messageListJson[index].uuid+"'><h4>"+messageListJson[index].title+"<span style='clor:lightblue;'>-----------------"+messageListJson[index].fromName+"&nbsp;&nbsp;"+messageListJson[index].createTime+"&nbsp;</span></h4></a>")
// //     						 .append("<div style='height:150px; text-overflow : clip;'><p>"+messageListJson[index].content+"</p></div>");
//     		}
    		
//     	});
//     });
    </script>
</head>
<body>
<section id="user_info">
  <!-- top start -->
  <c:import url="/portal/personaCenter/top.jsp"/>
  <!-- top end -->
    <form class="pagination_form">
  <div class="container user_teble m_5">
 <h2 class="text-left m_4">通知公告</h2>
<!--  	<div id="messageList" class="panel-body"> -->
 	     <c:forEach items="${pageModel.rows}" var="message">
 	     	<div class="page-header"><h3>${message.title}</h3><span style='margin-left:10%;color:darkgray;font-size:14px;'>发布时间：${message.createTimeStr}</span></div>
 	     	<div class="hero-unit well">${message.content}</div>
 	     </c:forEach>
<!--     </div> -->
     	<c:import url="/portal/includes/pagination.jsp"/>    
 </div> 
 </form>
</section>
</body>
</html>