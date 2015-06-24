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
	    $(this).attr('src', $(this).attr('src') + '?k=' + Math.random());
	    $("#captchaCode").val("");
	});

});
function toSubmit(){
	if($("#_registerForm").form){
	    $("#submitHref").attr("href","#");
	    alert("asdf");
	}
	$("#_registerForm").submit();
}
<c:if test="${not empty errMsg}">
	alert("${errMsg}");
</c:if>

</script>
</head>
<body>
	<section class="main">
<div class="registration_container"  style="margin-top:0px;">
	
	<div class="col-lg-3 col-sm-3 center">
    	<img src="${base }/resources/portal/images/logo_yello.png" class="logo_yello"/>
    	<form id="_registerForm" class="form-horizontal" role="form" method="POST" action="${base }/portal/user/register.vhtml">
        	<div class="row">
                <div class="col-sm-12">
                		<input class="form-control login_input" id="loginName" name="loginName" placeholder="用户名" type="text" value="${userInfo.loginName }"
							data-rule-required="true"
							data-msg-required="请录入用户名。"
							data-rule-loginNameWithPhoneAndEmail="true"
							data-msg-loginNameWithPhoneAndEmail="用户名格式不正确!请录入正确的手机号、邮箱或以字母开头的用户名"
							data-rule-minlength="6"
							data-msg-minlength="用户名最少为6个字符" data-rule-maxlength="20"
							data-msg-maxlength="用户名最大为20个字符"
							data-rule-remote="${base}/system/account/validateLoginName.json"
							data-msg-remote="您输入的用户名已经存在。"placeholder="用户名"/>
                      <i class="fa fa-user"></i>
                 </div>
             </div>
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
                       <input class="form-control login_input" placeholder="确认密码" id="pwdStr" name="pwdStr" type="password"
					           	data-rule-required="true"
								data-msg-required="请输入重复密码。" data-rule-equalTo="#password"
								data-msg-equalTo="重复密码与新的密码不相同。" placeholder="6~16个字符，区分大小写"/>
                       <i class="fa fa-unlock-alt"></i>
                 </div>
             </div>
        	<div class="row">
                <div class="col-sm-12">
                      <input class="form-control login_input" id="name" name="name" placeholder="姓名" type="text" value="${userInfo.name }"
							data-rule-required="true"
							data-msg-required="姓名。" data-rule-minlength="2"
							data-msg-minlength="姓名最少为6个字符" data-rule-maxlength="20"
							data-msg-maxlength="姓名最大为20个字符" placeholder="姓名"/>
                      <i class="fa fa-user"></i>
                 </div>
             </div>
             <div class="row">
                 <div class="col-sm-12">
                    <input class="form-control login_input" id="tel" name="tel" placeholder="手机" type="text" value="${userInfo.tel }"
                    				data-rule-required="true"
                    				data-rule-required="手机号码不能为空"
                    				data-rule-iphone="true"
									data-msg-iphone="手机格式错误，请确认你录入的电话。" maxlength="11"/>
						<i class="fa fa-mobile"></i>
                 </div>
             </div>
             <div class="row">
                 <div class="col-sm-12">
                    <input class="form-control login_input" name="mail" id="mail" placeholder="邮箱" type="text"  value="${userInfo.mail }"
                    		data-rule-required="true" 
                    		data-msg-required="请录入电子邮箱。"
							data-rule-email="true" 
							data-msg-email="邮箱格式错误，请确认你录入的邮箱地址。"
							maxlength="50" />
							<i class="fa fa-envelope"></i>
                 </div>
             </div>
             
             <div class="row">
                 <div class="col-sm-6">
                    <input type="text" class="form-control col-left" id="captchaCode" name="code" placeholder="验证码"
                    		data-rule-required="true" 
                    		data-msg-required="请输入验证码。"
							data-rule-remote="${base}/system/account/validateCaptcha.json"
							data-msg-remote="验证码输入有误。"/>
                 </div>
                 <div class="col-sm-6">
                    <img class="form-control col-left" id="captcha" src="${base}/captcha.jpg">
                 </div>
             </div>
             <div class="row">
             	<div class="col-lg-12 col-sm-12  text-center">
                    <a href="javaScript:toSubmit();" id="submitHref" class="btn btn-lg btn-warning">注册</a>
                    <small>已有账号，去<a href="${base }/portal/login.vhtml" class="text-center" style="color:#edae49;">登录</a></small>
                 </div>
             </div>
        </form>
    </div>
  </div>
  </section>
</body>
</html>