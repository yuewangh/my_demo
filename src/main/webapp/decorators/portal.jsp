<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<!-- 云享客项目组成员：田宁、张学林、姚丰利、田宏岩、芦军、王跃、孙金奇、佘红艳、郝苗苗、吕新新、马伟恒、汪银中、马晓良、李付 -->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<title>云享客</title>
<meta name="description" content="Worthy a Bootstrap-based, Responsive HTML5 Template">
<meta name="author" content="htmlcoder.me">

<!-- Mobile Meta -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<sitemesh:write property='head'/>

</head>
<body id="index" class="no-trans">

<!-- ui-dialog -->

<script type="text/javascript">
	
</script>

    <c:import url="/portal/includes/header.jsp"/>

    <%-- <decorator:body/> --%>
    <sitemesh:write property='body'/>

    <c:import url="/portal/includes/footer.jsp"/>
</body>
</html>
