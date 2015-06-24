<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.net.*" %>
<%@ include file="/pages/includes/taglibs.jsp" %>

<!-- header start --> 
<!-- ================ -->

<header id="_header_header" class="header fixed clearfix navbar navbar-fixed-top">
  <div class="container">
    <div class="row">
      <div class="col-md-3 col-sm-2"> 
        
        <!-- header-left start --> 
        <!-- ================ -->
        <div class="header-left clearfix"> 
          
          <!-- logo -->
          <div class="logo smooth-scroll"> <a href="#banner"></a> </div>
          
          <!-- name-and-slogan -->
          <div class="site-name-and-slogan smooth-scroll">
            <div class="site-name"><a href="#banner"><img src="<sys:param key="SPACEYUN_LOGO"/>" alt="平台logo"/></a></div>
          </div>
        </div>
        <!-- header-left end --> 
        
      </div>
      <div class="col-md-9 col-sm-10 pull-right"> 
        
        <!-- header-right start --> 
        <!-- ================ -->
        <div class="header-right clearfix"> 
          
          <!-- main-navigation start --> 
          <!-- ================ -->
          <div class="main-navigation animated"> 
            
            <!-- navbar start --> 
            <!-- ================ -->
            <nav class="navbar navbar-default" role="navigation">
              <div class="container-fluid"> 
                
                <!-- Toggle get grouped for better mobile display -->
                <div class="navbar-header">
                  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-1"> <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
                </div>
                
                <div class="collapse navbar-collapse scrollspy smooth-scroll" id="navbar-collapse-1">
                 <ul class="nav navbar-nav">
                    <li class="active"><a id="index_1" href="${base }/portal/index.vhtml">首页</a></li>
                    <li><a href="#" class="" id="dropdownMenu1" data-toggle="dropdown">空间<span class="caret"></span></a>
                      <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                        <li role="presentation"> <a role="menuitem"  tabindex="-1" href="${path}/portal/position/index.vhtml?region=beijing">北京</a> </li>
                        <li role="presentation"> <a role="menuitem"  tabindex="-1" href="${path}/portal/position/index.vhtml?region=shanghai">上海</a> </li>
                      </ul>
                    </li>
                    <li><a id="index_3" href="${base }/portal/community/index.vhtml">社区</a></li>
                    <li  ><a id="index_4" href="${base }/portal/link/platformValue.vhtml">平台</a></li>
                    <li><a id="index_5" href="${base }/portal/link/platformService.vhtml">服务</a></li>
                  </ul>
                  <security:authorize ifAllGranted="SYSTEM_PERSONA">
                        <security:authentication property="principal" var="user"/>
                        	<a href="${base }/portal/personaCenter/member/index.vhtml" class="btn btn-lg btn-warning-outline pull-right">欢迎您：${user.name}&nbsp;&nbsp;个人中心</a> 
                    </security:authorize>
                    <security:authorize ifNotGranted="SYSTEM_PERSONA">
                        <a href="${base }/portal/registerView.vhtml" class="btn btn-lg btn-default-outline pull-right">注册</a>
                        <a href="${base }/portal/login.vhtml" class="btn btn-lg btn-warning-outline pull-right">登录</a> 
                    </security:authorize>
              </div>
            </nav>
            <!-- navbar end --> 
            
          </div>
          <!-- main-navigation end --> 
          
        </div>
        <!-- header-right end --> 
        
      </div>
    </div>
  </div>
  
  <script type="text/javascript">
	    var ss = window.location.href;
	    if(ss.indexOf("/portal/index.vhtml") == -1 && ss.indexOf("/portal/position/index.vhtml") == -1){
	    	/* $("#_header_header").attr("class","header fixed clearfix navbar navbar-fixed-top header-erji header_opacity"); */
	    	$("#_header_header").attr("class","header fixed clearfix navbar navbar-fixed-top header-erji");
	    }
	    if(ss.indexOf("personaCenter") != -1){
	    	$("#_header_header").remove();
	    }
	    
	    $("a[id^='index_']").each(function () {
		    $(this).parent().removeAttr("class");
		    var href = $(this).attr("href");
		    var ss = window.location.href;
		    var len = 5;
		    if("${path}" == ""){
		    	len = 4;
		    }
		    if(href.split("/").length <= len){
		    	if (ss.indexOf(href.split("?")[0]) != -1) {
		            $(this).parent().attr("class", "active");
		        }
		    }else{
		    	if (ss.indexOf(href.substr(0,href.lastIndexOf("/"))) != -1) {
		            $(this).parent().attr("class", "active");
		        }
		    }
		});
  </script>
</header>

<!-- header end --> 