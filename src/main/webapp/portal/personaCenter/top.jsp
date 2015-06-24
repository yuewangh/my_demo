<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>

<div class="row">
    <div class="user_top member">
      <div class="m-top"> <a href="${base }/portal/index.vhtml" class="m-logo"><img src="${base}/resources/portal/images/logo_yello.png" /></a>
        <div class="m-login"> <a href="${base }/portal/index.vhtml">返回首页</a> <a href="javascript:if(confirm('确定执行退出操作吗?'))location='${path}/j_spring_security_logout'">退出登录</a> </div>
        <nav class="">
          <ul class="cf">
            <li class="active">
              <p class="tips"><!-- <span id="allUnNotice">0</span> --></p>
              <i class="fa fa-user"></i>
              <p>个人信息</p>
              <a id="persona_1" href="${path }/portal/personaCenter/member/index.vhtml"></a>
            </li>
            <li  class="">
              <p class="tips" id="meetingCount"></p>
              <i class="fa fa-headphones"></i>
              <p>我的预约 </p>
              <a id="persona_2" href="${path }/portal/personaCenter/appointment/index.vhtml"></a>
            </li>
            <li class="">
              <p class="tips"><span id="all_visitor_num_id"></span></p>
              <i class="fa fa-file-text"></i>
              <p>在线订单</p>
              <a id="persona_3" href="${path }/portal/personaCenter/reservation/index.vhtml"></a>
            </li>
            <li class="">
              <p class="tips" id="memberPaymentScheduleCount"></p>
              <i class="fa fa-bullhorn"></i>
              <p>通知公告</p>
              <a id="persona_4" href="${path }/portal/personaCenter/notice/index.vhtml"></a>
            </li>
            <%-- <li class=""> <i class="fa fa-cloud"></i>
              <p>推荐应用</p>
              <a id="persona_5" href="${path }/portal/personaCenter/application/index.vhtml"></a>
            </li> --%>
          </ul>
        </nav>
        <img class="top-bg" src="${base}/resources/portal/images/user_top.jpg" width="1418" height="594"> </div>
    </div>
  </div>
  
<script type="text/javascript">
	$("a[id^='persona_']").each(function () {
	    $(this).parent().removeAttr("class");
	    var href = $(this).attr("href");
	    var ss = window.location.href;
	    var len = 6;
	    if("${path}" == ""){
	    	len = 5;
	    }
	    if(href.split("/").length < len){
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