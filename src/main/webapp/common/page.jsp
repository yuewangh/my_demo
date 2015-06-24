<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<font>每页显示</font>
	<select id="pageSize" onchange="turnPage(1)">
		<c:choose>
			<c:when test="${obj.pageSize == 5}">
				<option value="3">3</option>
				<option value="5" selected="selected">5</option>
				<option value="10">10</option>
			</c:when>
			<c:when test="${obj.pageSize == 10}">
				<option value="3">3</option>
				<option value="5">5</option>
				<option value="10" selected="selected">10</option>
			</c:when>
			<c:otherwise>
				<option value="3" selected="selected">3</option>
				<option value="5">5</option>
				<option value="10">10</option>
			</c:otherwise>
		</c:choose>
	</select>
	<font>条</font>
	<c:if test="${obj.pageIndex == 1}">	<!-- 注意test里面内容的写法 -->
		<c:if test="${obj.pageIndex < obj.pageCount}">	
			<font color="black">首页</font>
			<font color="black">上一页</font>		
			<a href="javascript:;" onclick="turnPage(${obj.pageIndex} + 1)" style="text-decoration: underline;color: red">下一页</a>
			<a href="javascript:;" onclick="turnPage(${obj.pageCount})" style="text-decoration: underline;color: red"> 尾页 </a>
		</c:if>
		<c:if test="${obj.pageIndex == obj.pageCount}">	
			<font color="black">首页</font>
			<font color="black">上一页</font>		
			<font color="black">下一页</font>
			<font color="black">尾页</font>
		</c:if>
		<c:if test="${obj.pageIndex > obj.pageCount}">	
			<c:choose>
				<c:when test="${obj.pageCount > 0}">
					<a href="javascript:;" onclick="turnPage(1)" style="text-decoration: underline;color: red"> 首页 </a>
					<a href="javascript:;" onclick="turnPage(${obj.pageIndex} - 1)" style="text-decoration: underline;color: red">上一页</a>	
				</c:when>
				<c:otherwise>
					<font color="black">首页</font>
					<font color="black">上一页</font>	
				</c:otherwise>
			</c:choose>
			<font color="black">下一页</font>
			<font color='black'>尾页</font>
		</c:if>
	</c:if>
	
	<c:if test="${obj.pageIndex != 1}">
		<c:if test="${obj.pageIndex == obj.pageCount}">
			<a href="javascript:;" onclick="turnPage(1)" style="text-decoration: underline;color: red"> 首页 </a>
			<a href="javascript:;"
				onclick="turnPage(${obj.pageIndex} - 1)" style="text-decoration: underline;color: red">上一页</a>
			<font color="black">下一页</font>
			<font color="black">尾页</font>
		</c:if>
		<c:if test="${obj.pageIndex < obj.pageCount}">
			<a href="javascript:;" onclick="turnPage(1)" style="text-decoration: underline;color: red"> 首页 </a>
			<a href="javascript:;"
				onclick="turnPage(${obj.pageIndex} - 1)" style="text-decoration: underline;color: red">上一页</a>
			<a href="javascript:;"
				onclick="turnPage(${obj.pageIndex} + 1)" style="text-decoration: underline;color: red">下一页</a>
			<a href="javascript:;" onclick="turnPage(<c:out value="${obj.pageCount}"/>)" style="text-decoration: underline;color: red">
				尾页 </a>
		</c:if>
		<c:if test="${obj.pageIndex > obj.pageCount}">	
			<a href="javascript:;" onclick="turnPage(1)" style="text-decoration: underline;color: red"> 首页 </a>
			<a href="javascript:;" onclick="turnPage(${obj.pageIndex} - 1)" style="text-decoration: underline;color: red">上一页</a>	
			<font color="black">下一页</font>
			<font color="black">尾页</font>
		</c:if>
	</c:if>
	
	
当前页为
<font style="text-decoration: underline; color: red">${obj.pageIndex}</font>
/
${obj.pageCount}
共
${obj.totalCount}
条数据
<script type="text/javascript">
function getPageurl(url){
	var pageSize = $("#pageSize").val();
	return url +"&pageSize="+pageSize;
}
function getPagesurls(url){
	var pageSize = $("#pageSize").val();
	return url +"?pageSize="+pageSize;
}
</script>
</body>
</html>