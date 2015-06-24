<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <c:import url="/pages/includes/head-libs.jsp"/>
    <sitemesh:write property='head'/>
</head>
<body>
<!--头部-->
<c:import url="/pages/includes/header.jsp"/>
<!--内容-->
<div id="wrap">
    <sitemesh:write property='body'/>
</div>
<!--尾部-->
<c:import url="/pages/includes/footer.jsp"/>
</body>
</html>