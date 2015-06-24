<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setAttribute("ctx",request.getScheme() + "://" + request.getServerName() + ':'+ request.getServerPort()+request.getContextPath() + '/');
%>
<script type="text/javascript" src="${ctx}/resources/js/jquery-1.4.1.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/lhgdialog.js"></script>

