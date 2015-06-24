<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>

<div class="header">
    <!-- TODO @lutz 页眉 -->
    <div class="topBar"> </div>
    <div class="mainNav">
        <div class="container">
            <nav class="navbar navbar-default">
                <span class="logo"><img src="<sys:param key='SPACEYUN_BACKGROUND_LOGO'/>" alt="平台logo" onclick="location.href='${base}/welcome.vhtml'"></span>
                <ul class="nav navbar-nav">
                    <li id="index1" class="active"><a href="${base }/welcome.vhtml">首页</a></li>
					<security:authorize ifAnyGranted="P_POSITION,SYS_SUPER">
                    	<li id="index2"><a href="${path}/position/building/index.vhtml">位置管理</a></li>
                    </security:authorize>
                    
					<security:authorize ifAnyGranted="P_ORDER,SYS_SUPER">
                    	<li id="index3"><a href="${path}/order/appointment/tolist.vhtml">预约预订</a></li>
                    </security:authorize>
                    <%-- <li id="index4"><a href="${path}/library/information/TEST/index.vhtml">信息管理</a></li> --%>
                    
					<security:authorize ifAnyGranted="P_ACTIVITY,SYS_SUPER">
                    	<li id="index4"><a href="${path}/activity/manager/index.vhtml">活动管理</a></li>
                    </security:authorize>
                    
					<security:authorize ifAnyGranted="P_SYSTEM,SYS_SUPER">
                    	<li id="index5"><a href="${path }/system/account/index.vhtml">系统管理</a></li>
                    </security:authorize>
                    
					<security:authorize ifAnyGranted="P_DICTIONARY,SYS_SUPER">
                    	<li id="index5"><a href="${path }/dictionary/index.vhtml">数据字典</a></li>
                    </security:authorize>
                </ul>
                <security:authentication property="principal" var="user"/>
                <div class="textWelc">
                    <span>欢迎，${user.name}</span>
                    <a onclick="javascript:if(confirm('确定执行退出操作吗?'))location='${base}/j_spring_security_logout'"
                       href="#" class="ml20">退出</a>
                </div>
            </nav>
        </div>
    </div>
</div>
 <script type="text/javascript">
                $("li[id^='index']").each(function () {
                    $(this).removeAttr("class");
                    $(this).children("a").each(function () {
                        var href = $(this).attr("href");
                        var ss = window.location.href;
                        var len = 5;
                        if("${path}" == ""){
                        	len = 4;
                        }
                        if(href.split("/").length < len){
                        	if (ss.indexOf(href.split("?")[0]) != -1) {
                                $(this).parent().attr("class", "active");
                            }
                        }else{
                        	if (ss.indexOf(href.substr(0,href.lastIndexOf("/"))) != -1) {
                                $(this).parent().attr("class", "active");
                            }else if(ss.indexOf("portal/user") != -1){
                            	//$("#li_user").attr("class", "jbr_stay");
                            }
                        }
                        
                    });
                });
            </script>
