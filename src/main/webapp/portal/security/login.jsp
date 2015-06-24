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
		_form = $("#_loginForm").validate();
		_forgetForm = $("#_forgetPwdForm").validate();
	    $('#captcha').click(function () {
		    $(this).attr('src', $(this).attr('src') + '?k=' + Math.random());
		    $("#captchaCode").val("");
		});
        $("#_loginForm").submit(function (){
        	if($("#_loginForm").form){
        	 	$("#_loginForm").submit();
        	}
        });
        <c:if test="${showCode}">
        $('#captcha').click(function () {
            $(this).attr('src', $(this).attr('src') + '?k=' + Math.random())
        });
        </c:if>
    })
    function toSubmitForgetPwd(){
		if($("#_forgetPwdForm").valid()){
			 $("#_forgetPwdForm").submit();
		}else{
			alert("输入内容有误，请认真检查！");
		}
	}

//login登录切换忘记密码
window.onload = function () {
	var oBtnLeft = document.getElementById("goleft");
	var oBtnRight = document.getElementById("goright");
	var oDiv = document.getElementById("indexmaindiv");
	var oDiv1 = document.getElementById("maindiv1");
	var oUl = oDiv.getElementsByTagName("ul")[0];
	var aLi = oUl.getElementsByTagName("li");
	var now = -1* (aLi[0].offsetWidth + 13);
	oUl.style.width = aLi.length * (aLi[0].offsetWidth + 1) + 'px';
	oBtnRight.onclick = function () {
		var n = Math.floor((aLi.length * (aLi[0].offsetWidth + 1) + oUl.offsetLeft) / aLi[0].offsetWidth);

		if (n <= 1) {
			move(oUl, 'left', 0);
		}
		else {
			move(oUl, 'left', oUl.offsetLeft + now);
		}
	}
	oBtnLeft.onclick = function () {
		var now1 = -Math.floor((aLi.length / 2)) * 2 * (aLi[0].offsetWidth + 2);

		if (oUl.offsetLeft >= 0) {
			move(oUl, 'left', now1);
		}
		else {
			move(oUl, 'left', oUl.offsetLeft - now);
		}
	}
	

};

function getStyle(obj, name) {
	if (obj.currentStyle) {
		return obj.currentStyle[name];
	}
	else {
		return getComputedStyle(obj, false)[name];
	}
}

function move(obj, attr, iTarget) {
	clearInterval(obj.timer)
	obj.timer = setInterval(function () {
		var cur = 0;
		if (attr == 'opacity') {
			cur = Math.round(parseFloat(getStyle(obj, attr)) * 100);
		}
		else {
			cur = parseInt(getStyle(obj, attr));
		}
		var speed = (iTarget - cur) / 6;
		speed = speed > 0 ? Math.ceil(speed) : Math.floor(speed);
		if (iTarget == cur) {
			clearInterval(obj.timer);
		}
		else if (attr == 'opacity') {
			obj.style.filter = 'alpha(opacity:' + (cur + speed) + ')';
			obj.style.opacity = (cur + speed) / 100;
		}
		else {
			obj.style[attr] = cur + speed + 'px';
		}
	}, 30);
} 

</script>
</head>
<body>
	<section class=" main">
    <div class="registration_container" style="margin-top:0px;"> 
   <!-- 登录开始-->
   		<div class="indexmaindiv" id="indexmaindiv" >
	<div class="indexmaindiv1 clearfix" >
		<div class="maindiv1 " id="maindiv1">
		<ul id="count1" >
			<li>
				<div class="col-lg-10 col-sm-10 center">
            <img src="${base }/resources/portal/images/logo_yello.png" class="logo_yello"/>
            <form id="_loginForm" class="form" action="${base}/j_spring_security_check" method="post">
            	<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
                    <div class="row">
                    <div class="col-sm-12" style="color:red;">
                            ${SPRING_SECURITY_LAST_EXCEPTION.message}
                    </div>
                    </div>
                </c:if>
                <div class="row">
                    <div class="col-sm-12">
                          <input class="form-control login_input" id="j_username" name="j_username" placeholder="用户名" type="text"
                          	data-rule-required="true"
							data-msg-required="请录入用户名。"
							data-rule-loginNameWithPhoneAndEmail="true"
							data-msg-loginNameWithPhoneAndEmail="用户名格式不正确!请输入正确的用户名"
							/>
                          <i class="fa fa-user"></i>
                          
                     </div>
                 </div>
                 <div class="row">
                    <div class="col-sm-12">
                           <input class="form-control login_input" id="j_password" name="j_password" placeholder="密码" type="password"
                           	data-rule-required="true"
							data-msg-required="请录入密码。"/>
                           <i class="fa fa-unlock-alt"></i>
                          
                     </div>
                 </div>
                 <c:if test="${showCode}">
	                 <div class="row">
	                    <div class="col-sm-12">
	                           <input type="password" class="form-control login_input" name="j_code" placeholder="验证码"
                               style="width: 128px;" data-rule-required="true"
								data-msg-required="请录入验证。"/>
                        		<img id="captcha" src="${base}/captcha.jpg">
	                           <i class="fa fa-unlock-alt"></i>
	                          
	                     </div>
	                 </div>
                </c:if>
                <div class="row">
                    <div class="col-sm-12">
                           <input class=" pull-left" type="checkbox" />
                           <small class="small_login">自动登录<a href="#" id="goright" class="text-center"  style="color:#edae49;">忘记密码</a></small>
                     </div>
                 </div>
                 
                 <div class="row">
                    <div class="col-lg-12 col-sm-12  text-center">
                        <button type="submit" class="btn btn-lg btn-warning">登录</button>
                      
                                <small>还没有账号，现在去注册。<a href="${base }/portal/registerView.vhtml" class="text-center"  style="color:#edae49;">注册账号</a></small>
                     </div>
                 </div>
            </form>
        </div>
			</li>
            <!--登录结束-->
            
             <!--忘记密码-->
			<li >
        <form id="_forgetPwdForm" name="_forgetPwdForm" class="form" method="post" action="${base }/portal/user/forgetPassword.vhtml">
		<div class="stylesgoleft" id="goleft"><span></span></div>
        <div class="bg_password">
				<div class="col-lg-10 col-sm-10 center">
               <div class="">
                   <ul id="myTab" class="login_tab">
                        <li class="active"><a href="/demo/bootstrap3-plugin-tab.htm#ios" data-toggle="tab">邮箱</a></li>
                     </ul>
                     <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade in active" id="ios">
                         <div class="row">
                            <div class="col-sm-12">
                                   <input class="form-control login_input border_yello" id="loginName" name="loginName" placeholder="用户名" type="text"
                                   data-rule-required="true"
									data-msg-required="请录入用户名。"
									data-rule-loginNameWithPhoneAndEmail="true"
									data-msg-loginNameWithPhoneAndEmail="用户名格式不正确!请录入正确的手机号、邮箱或以字母开头的用户名"
                                   />
                                   <i class="fa fa-user"></i>
                                  
                             </div>
                         </div>
                         <div class="row">
                            <div class="col-sm-12">
                                   <input class="form-control login_input border_yello" id="registerMail" name="registerMail" placeholder="注册邮箱" type="text"
                                   data-rule-required="true" 
	                    		data-msg-required="请录入电子邮箱。"
								data-rule-email="true" 
								data-msg-email="邮箱格式错误，请确认你录入的邮箱地址。"
                                   />
                                   <i class="fa fa-envelope"></i>
                                  
                             </div>
                         </div>
                         <div class="row">
                            <div class="col-lg-12 col-sm-12  text-center">
                                <a href="javaScript:toSubmitForgetPwd();" class="btn btn-lg btn-warning">提交</a>
                             </div>
                         </div>
                        </div>
                      </div>
                  </div>

      			  </div>
       		 </div>
       		 </form>
			</li>
			
		</ul>
		</div>
	</div>
</div>
      </div>
      </section>
</body>
</html>