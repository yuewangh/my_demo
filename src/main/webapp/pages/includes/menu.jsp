<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>

<security:authentication property="principal" var="user"></security:authentication>

<div class="sidebar pull-left" id="westNav">
    <div class="panel-header">
        <div class="panel-title"><i class="icon icon-th-list"></i> 功能菜单</div>
        <div class="panel-tool">
            <i class="icon-chevron-right" style="display: none;" id="panel-tool-collapse"></i>
            <i class="icon-chevron-left" id="panel-tool-expand"></i>
        </div>
    </div>
    <div class="navMenu">
        <div class="panel-group width" id="accordion">
            <div class="panel panel-default">
                <!--div class="panel-heading">
                    <h4 class="panel-title noBg">
                        <a id="navWelc" data-href="${path}/welcome.htm" data-toggle="collapse" data-parent="#accordion"
                           href="#collapse">
                            <i class="icon icon-globe"></i> 欢迎登录
                        </a>
                    </h4>
                </div-->
                <div id="collapse" class="panel-collapse collapse">
                    <div class="panel-body"></div>
                </div>
            </div>
        </div>
    </div>
</div>