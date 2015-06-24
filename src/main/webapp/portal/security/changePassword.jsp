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
<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
<script>
$(function(){
	_form = $("#_registerForm").validate();
    $('#captcha').click(function () {
	    $(this).attr('src', $(this).attr('src') + '?k=' + Math.random())
	});
});
function toSubmit(){
	$("#_registerForm").submit();
}
<c:if test="${not empty errMsg}">
	alert("${errMsg}");
</c:if>

</script>
</head>
<body>
	<section class="main">
<div class="registration_container">
	
	<div class="col-lg-3 col-sm-3 center">
    	<img src="${base }/resources/portal/images/logo_yello.png" class="logo_yello"/>
    	<form id="_registerForm" class="form-horizontal" role="form" method="POST" action="${base }/portal/user/savePassword.vhtml">
    		<input type="hidden" id="uuid" name="uuid" value="${userInfo.uuid }"/>
             <div class="row">
                <div class="col-sm-12">
                       <input class="form-control login_input" id="password" name="password" type="password"
	               			data-rule-required="true"
							data-msg-required="请录入密码." data-rule-minlength="6"
							data-msg-minlength="密码最少为6个字符" data-rule-maxlength="16"
							data-msg-maxlength="密码最大为16个字符" placeholder="密码为6~16个字符，区分大小写"/>
                       <i class="fa fa-unlock-alt"></i>
                 </div>
             </div>
             <div class="row">
                <div class="col-sm-12">
                       <input class="form-control login_input" placeholder="确认密码" id="rePassword" name="rePassword" type="password"
					           	data-rule-required="true"
								data-msg-required="请输入重复密码。" data-rule-equalTo="#password"
								data-msg-equalTo="重复密码与新的密码不相同。" placeholder="6~16个字符，区分大小写"/>
                       <i class="fa fa-unlock-alt"></i>
                 </div>
             </div>
             <div class="row">
             	<div class="col-lg-12 col-sm-12  text-center">
                    <a href="javaScript:toSubmit();" class="btn btn-lg btn-warning">保存密码</a>
                 </div>
             </div>
        </form>
    </div>
  </div>
  </section>
</body>
</html>