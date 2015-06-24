<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <c:import url="/portal/includes/personaHead-libs.jsp"/>
<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
</head>
<body>
<section id="user_info">
  <!-- top start -->
  <c:import url="/portal/personaCenter/top.jsp"/>
  <!-- top end -->
  <div class="container" id="userdiv" >
    <div class="indexmaindiv1 clearfix" >
      <div class="user_infoid" id="user_infoid">
        <ul id="count1">
          <li>
            <div class="member-bak1">
              <div class="ajax-box">
                <div class="ajax-box-left first">
                  <div class="personal-1 n-box cf">
                    <dl class="user-dat">
                      <dt><img src="${base }/resources/portal/images/head.jpg" width="200" height="200"><a id='goright'  href="javascript:;" ><i>完善个人信息</i></a></dt>
                      <dd> <span class="name"></span>
                        <h5></h5>
                        <div class="b cf">
                          <div class="ay"> <a data-toggle="modal"data-target="#myModal" href="#">修改密码</a> <a id='showPersonaModPage' href="javascript:;">完善个人信息 </a><!-- <a href="#" target="_blank">价格列表</a> --> </div>
                        </div>
                        <h3></h3>
                        <h5>用户姓名：${userInfo.name }</h5><br>
                        <h5>手机号：${userInfo.tel }</h5><br>
                        <h5 style="text-transform:none;">电子邮箱：${userInfo.mail }</h5>
                      </dd>
                    </dl>
                  </div>
                </div>
              </div>
            </div>
          </li>
          <!--个人1--> 
          
          <!--个人信息填写-->
          <li>
          <form id="_userForm" class="form-horizontal" action="${path }/portal/personaCenter/member/savePersonaUser.action">
            <div class="member-bak1 m_5">
              <div class="ajax-box">
                <div class="ajax-box-left first"> <a id="goleft" href="javascript:;" class="back">返回</a>
                  <div class="personal-2 mod-int">
                    <h2 class="text-center">完善个人信息</h2>
                    <dl class="dl cf">
                     <div class="col-lg-12 row">
                     <input type="hidden" id="uuid" name="uuid" value="${userInfo.uuid}"/>
                     <input type="hidden" id="mail" name="mail" value="${userInfo.mail}"/>
                     <input type="hidden" id="tel" name="tel" value="${userInfo.tel}"/>
                      	<div class="row">
                        	<div class="col-lg-6 user_icon">
                            	<input type="text" class="form-control userinput" style="padding-left:70px !important"  id="loginName" name="loginName"  placeholder="用户名" readonly=readonly value="${userInfo.loginName }"/>
                                <!-- <i class="fa fa-user"></i> -->
                                 <i style="line-height:20px;height:20;font-size:14px;"><b>用户名&nbsp;:</b></i>
                            </div>
                            <div class="col-lg-6 user_icon">
                            	<input type="text" class="form-control userinput" style="padding-left:60px !important"  id="name" name="name" placeholder="姓名" value="${userInfo.name }"
												data-rule-required="true"
												data-msg-required="姓名不能为空。" data-rule-minlength="2"
												data-msg-minlength="姓名最少为2个字符" data-rule-maxlength="20"
												data-msg-maxlength="姓名最大为20个字符"/>
                                 <!-- <i class="fa fa-male"></i> -->
                                 <i style="line-height:20px;height:20;font-size:14px;"><b>姓&nbsp;名&nbsp;:</b></i>
                            </div>
                        	<div class="col-lg-6 user_icon">
                            	<input type="text" class="form-control userinput" style="padding-left:60px !important"  placeholder="公司"  id="unit" name="unit" value="${userInfo.unit }"
												data-rule-minlength="2"
												data-msg-minlength="公司名称最少为2个字符" data-rule-maxlength="50"
												data-msg-maxlength="姓名最大为50个字符"/>
                                 <!-- <i class="fa fa-briefcase"></i> -->
                                 <i style="line-height:20px;height:20;font-size:14px;"><b>公&nbsp;司&nbsp;:</b></i>
                            </div>
                            <div class="col-lg-6 user_icon">
                            	<input type="text" class="form-control userinput" style="padding-left:60px !important"  placeholder="职位" id="jobInfo" name="jobInfo" value="${userInfo.jobInfo }"
												data-rule-minlength="2"
												data-msg-minlength="职位名称最少为2个字符" data-rule-maxlength="20"
												data-msg-maxlength="职位名称最大为20个字符"/>
                                 <!-- <i class="fa fa-mortar-board"></i> -->
                                 <i style="line-height:20px;height:20;font-size:14px;"><b>职&nbsp;位&nbsp;:</b></i>
                            </div>
                            <%-- <div class="col-lg-12 user_icon">
                            	<input type="text" class="form-control userinput" style="padding-left:90px !important"  placeholder="通信地址" id="address" name="address" value="${userInfo.address }"
												data-rule-maxlength="50"
												data-msg-maxlength="通信地址最大为50个字符"/>
                                 <!-- <i class="fa fa-building"></i> -->
                                 <i style="line-height:20px;height:20;font-size:14px;"><b>通信地址&nbsp;:</b></i>
                            </div> --%>
                        </div>
                        <div class="row text-center m_5"><a href="javascript:submitUser();" class="btn btn-lg btn-warning  col-lg-3 center" style="">提交</a></div>
                     </div>
                     
                    </dl>
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
  <!-- 修改密码（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" style="top:15%" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" style="" id="myModalLabel">
               修改密码
            </h4>
         </div>
         <div class="modal-body">
            <div class="col-lg-12 m_5">
            	<input class="form-control userinput" type="password" id="oldPwd" name="oldPwd" placeholder="旧密码" />
                <!-- <small class="red ">提交错误</small> -->
              </div>
              <div class="col-lg-12 m_5">
              	 <input class="form-control userinput"  type="password" id="newPwd" name="newPwd" placeholder="新密码"/>
              </div> 
              <div class="col-lg-12 m_5">
                <input class="form-control userinput"  type="password" id="rePwd" name="rePwd" placeholder="确认密码"/>
               </div>
         </div>
         <div class="modal-footer" style="display:inline-block; width:100%;">
            <button type="button" class="btn btn-default"
               data-dismiss="modal">取消
            </button>
            <button type="button" class="btn btn-warning" onclick="toSubmitPassword();">
               提交更改
            </button>
         </div>
      </div>
</div>
</div><!--修改密码结束- -->
</section>
<script type="text/javascript">
$(function(){
	_form = $("#_userForm").validate();
});

function submitUser() {
    if(_form.form()){
    	$("#_userForm").ajaxSubmit({
            type: 'post',
            success: function (data) {
            		alert(data.msg);
            		if(data.success){
                   		//$("#goleft").click();
                   		window.location.href=window.location.href;
            		}
            }
        });
    }
}
window.onload = function () {
	var oBtnLeft = document.getElementById("goleft");
	var oBtnRight = document.getElementById("goright");
	var showPersonaModPage = document.getElementById("showPersonaModPage");
	var oDiv = document.getElementById("userdiv");
	var oDiv1 = document.getElementById("user_infoid");
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
	showPersonaModPage.onclick=function(){
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

function toSubmitPassword(){
	var oldPwd = $("#oldPwd").val();
	var newPwd = $("#newPwd").val();
	var rePwd = $("#rePwd").val();
	if(oldPwd == ""){
		alert("旧密码不能为空！");
		$("#oldPwd").focus();
		return false;
	}
	if(newPwd == ""){
		alert("新密码不能为空！");
		$("#newPwd").focus();
		return false;
	}
	if(rePwd == ""){
		alert("确认密码不能为空！");
		$("#rePwd").focus();
		return false;
	}
	if(rePwd != newPwd){
		alert("两次输入的密码不一致！请重新输入！");
		$("#rePwd").val("");
		$("#rePwd").focus();
		return false;
	}
	$.ajax({
        'url': '${path}/portal/personaCenter/member/savePassword.json',
        'type': 'post',
        'data': {
            oldPwd:oldPwd,newPwd:newPwd,rePwd:rePwd
        },
        'dataType': 'json',
        timeout: 6 * 1000,
        success: function (data) {
            if (data.success) {
                alert(data.msg);
                window.location.href="${path}/j_spring_security_logout";
            } else {
                alert(data.msg);
            }

        }, beforeSubmit: function () {
        }
    });
}
</script>
</body>
</html>