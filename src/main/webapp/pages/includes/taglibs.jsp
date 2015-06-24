<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path;

    pageContext.setAttribute("path", path);
    request.setAttribute("path", path);
    pageContext.setAttribute("basePath", basePath);
    request.setAttribute("basePath", basePath);

    pageContext.setAttribute("base", path);
    request.setAttribute("base", path);
%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="/WEB-INF/tags/system-portal.tld" prefix="sys" %>
<c:set var="ctx" value="${request.contextPath}"/>
