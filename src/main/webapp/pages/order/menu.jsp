<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <sitemesh:write property='head'/>
</head>
<body>
<!--内容-->
<div id="wrap">
    <div class="container">
        <div class="container">
            <div class="container UCContainer">
                <div class="row">
                    <div class="col-xs-2 UCMenu">
                        <ul id="sideNav" class="nav nav-pills nav-stacked show-arrows">
                            <li class="hasSub"><a href="#" class="expand"><i class="glyphicon glyphicon-th-list"></i>预约预订单管理</a>
                                <ul class="nav sub show" style="display: block;">
									<security:authorize ifAnyGranted="P_ORDER_RESERVATION,SYS_SUPER">
									<security:authorize ifAnyGranted="P_ORDER_APPOINT,SYS_SUPER">
                                    <li><a id="smenu1" href="${path}/order/appointment/tolist.vhtml" class="active"><i class=""></i>预约管理 </a></li>
                                    </security:authorize>
                                    <li><a id="smenu2" href="${path}/order/reservation/tolist.vhtml"><i class=""></i>预订管理</a></li>
                                    </security:authorize>
									<security:authorize ifAnyGranted="P_ORDER_LEASE,SYS_SUPER">
                                    <li><a id="smenu3" href="${path}/order/lease/tolist.vhtml"><i class=""></i>租约管理 </a></li>
                                    </security:authorize>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="col-xs-10">
                        <sitemesh:write property='body'/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
$("a[id^='smenu']").each(function () {
    $(this).removeAttr("class");
    var href = $(this).attr("href");
    var ss = window.location.href;
    var len = 5;
    if("${path}" == ""){
    	len = 4;
    }
    if(href.split("/").length < len){
    	if (ss.indexOf(href.split("?")[0]) != -1) {
            $(this).attr("class", "active");
        }
    }else{
    	if (ss.indexOf(href.substr(0,href.lastIndexOf("/"))) != -1) {
            $(this).attr("class", "active");
        }
    }
});
</script>
</body>
</html>