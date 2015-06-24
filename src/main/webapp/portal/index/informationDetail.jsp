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
<section>
	<div class="row">
    	<img src="${base }/resources/portal/images/a_1.jpg" width="100%" height="383">
    	
        <div class="container top">
        	<div class="activitie_conta bottom">
            	<div class="col-lg-2 col-sm-2 ">
            		<h1 class="title_r"><fmt:formatDate value="${infor.activityDate }" pattern="MM-dd"/></h1>
                </div>
                <div class="col-lg-10 col-sm-10 col-pading">
                	<h1 class="activ_yello"><b>${infor.title }</b></h1>
                	<br>	
               		<p class="font-size-20">${infor.summary }</p>
                </div>
                <h3 class="bg_gary">活动地点：${infor.activityAddress }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;活动时间：${infor.activityDateStr }</h3>
               	<div class=" col-lg-8 col-sm-8 center">
                	${infor.content }
                </div>
               <!-- <div class="col-lg-5 col-sm-9  activ_button text-center">
                <a href="#" class="btn btn-lg btn-warning">分享</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="#" class="btn btn-lg btn-warning" style="padding:15px 50px !important;">申请参加</a>
                 </div> -->
            </div>  
                 
        </div>
    </div>
</section>
</body>
</html>