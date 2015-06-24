<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <c:import url="/portal/includes/head-libs.jsp"/>
</head>
<body>
	<section class="main">
<div class="registration_container" style="margin-top:0px;">
	
	<div class="col-lg-3 col-sm-3 center">
    	<img src="${base }/resources/portal/images/logo_yello.png" class="logo_yello"/>
    	 <div class="inner">
                <div class="box_header clearfix">
                    <div class="grid_5 alpha omega">
                        <h1 class="box_title">${title}&nbsp;</h1>
                    </div>
                    <c:if test="${not empty subTitle}">
                    <div class="grid_10">
                        <nav class="box_nav clearfix">
                            <ul>
                                <li class="backLava"
                                    style="position: absolute; display: block; margin: 0px; padding: 0px; left: 0px; top: 0px; width: 148px; height: 33px; overflow: hidden;">
                                    <div class="leftLava"></div>
                                    <div class="bottomLava"></div>
                                    <div class="cornerLava"></div>
                                </li>
                                <li class="selectedLava">${subTitle}
                                </li>
                            </ul>
                        </nav>
                    </div>
                    </c:if>
                </div>

                <div class="box_detail clearfix">
                    <div class="mar10">

                    </div>
                    <div class="clear"></div>
                    <div>
                        ${message}
                        &nbsp;
                    </div>

                </div>
            </div>
    </div>
  </div>
  </section>
</body>
</html>