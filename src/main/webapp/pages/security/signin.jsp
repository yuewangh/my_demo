<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="/pages/includes/head-libs.jsp"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="viewport" content="width=1024,minimum-scale=1.0,maximum-scale=1.0"/>
    <meta charset="UTF-8">
    <title></title>
    <script type="text/javascript">
        jQuery(function ($) {
            var _href = window.location.href;
            if (_href.indexOf('${base}/signin.vhtml') < 0) {
                window.location.href = '${base}/signin.vhtml';
            }
            <c:if test="${showCode}">
            $('#captcha').click(function () {
                $(this).attr('src', $(this).attr('src') + '?k=' + Math.random())
            });
            </c:if>
        });
        function toShowForgetPwdDiv(){
        	$("#forgetPwdDiv_content").load("${base}/system/account/forgetPasswordView.action", function () {
                $("#forgetPwdDiv").modal('show');
            });
        }
    </script>
</head>
<body style="background: #f8f8f8; height: auto;">
    <div class="containerLg">
        <div class="logo" style="height:55px;"></div>
        <div class="loginPanel">
            <div class="loginBox">
                <p class="userAlt">欢迎登录云享客</p>
                <form class="form" action="${base}/j_spring_security_check" method="post">
                <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
                    <div class="text-center" style="color: red;">
                            ${SPRING_SECURITY_LAST_EXCEPTION.message}
                    </div>
                </c:if>
                <div class="text-center">
                    <input type="text" class="input user" name="j_username" placeholder="用户名"
                           value="${SPRING_SECURITY_LAST_USERNAME}"/>
                </div>
                <div class="text-center">
                    <input type="password" class="input pwd" name="j_password" placeholder="密码"/>
                </div>
                <c:if test="${showCode}">
                    <div class="text-center">
                        <input type="password" class="input pwd" name="j_code" placeholder="验证码"
                               style="width: 128px;"/>
                        <img id="captcha" src="${base}/captcha.jpg">
                    </div>
                </c:if>
                <div class="clearfix" style="width: 230px; margin:5px auto;">
                    <label class="checkbox pull-left ml20">
                        <input type="checkbox"/> 记住密码
                    </label>

                    <div class="pull-right fgPwd">
                        <a href="javascript:toShowForgetPwdDiv();">忘记密码？</a>
                    </div>
                </div>
                <div class="text-center">
                    <%--<a href="index.html" class="btn LoginBtn"></a>--%>
                    <button class="btn LoginBtn">登录</button>
                </div>
            </form>
            </div>
        </div>
        <p class="copyrt text-center">Copyright © 2012 - 2014 版权所有 软通动力信息技术（集团）有限公司</p>
    </div>
    
<div class="modal fade" id="forgetPwdDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="forgetPwdDiv_content">
            
        </div>
    </div>
</div>
</body>
</html>