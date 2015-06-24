<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>

    <script type="text/javascript">
        $(document).ready(function(){
            /* $("#nc").bind("click",function(e){
                e.preventDefault();
                var zDialog= new $.Zebra_Dialog('', {
                    'source': {'inline': $('#rrrr').html()},
                    'width': 400,
                    'type':false,
                    'overlay_close':false,
                    'overlay_opacity':0.75,
                    'title':  '设置昵称',
                    'buttons':  [
                        {caption: '保存',claName:'primary', callback: function() { }},
                        {caption: '返回',claName:'default', callback: function() { }}
                    ]
                });
            }) */
        })
        
        function toShowPersonalDiv(){
        	$("#_personalDiv_content").load("${path}/system/account/updateView.action?uuid=changePwd", function () {
                $("#_personalDiv").modal('show');
            });
        }
        
        function toShowPasswordDiv(){
        	$("#_personalDiv_content").load("${path}/system/account/changePasswordView.action", function () {
                $("#_personalDiv").modal('show');
            });
        }
    </script>
</head>
<body>
<div class="container">
    <div class="container UCContainer">
        <div class="row">
            <div class="col-xs-3 userInfo">
                <div class="media">
                        <span class="media-left ph">
                            <img id="userShowImage" src="${base}/resources/admin/themes/default/images/ph.png" alt="用户头像">
                            <%--<p class="editPh"><a href="#">修改头像</a></p>--%>
                            <!-- <p  id="selectImage" class="editPh"><a href="#">修改头像</a></p> -->
                            <input type="hidden" id="userImage" value="">
                            <sys:upload id="selectImage" extensions="jpg,gif,png">
                                <jsp:attribute name="callback">
                                    $('#userImage').val(fileInfo.url);
                                    $('#userShowImage').attr('src',fileInfo.url);
		                        </jsp:attribute>
                            </sys:upload>
                        </span>

                    <div class="media-body">
                        <h4 class="media-heading pl10">${user.name}</h4>
                        <ul>
                            <li><a href="javascript:toShowPasswordDiv();" class="btn btn-link btn-sm" id="nc">修改密码</a></li>
                            <li><a href="javascript:toShowPersonalDiv();" class="btn btn-link btn-sm">修改个人资料</a></li>
                        </ul>
                    </div>
                </div>
                <!-- <dl class="clearfix mt20">
                    <dt class="pull-left">最后一次登录：</dt>
                    <dd class="pull-right">2014年11月12日　10:10:10</dd>
                </dl>
                <div class="mt10">
                    <i class="glyphicon glyphicon-map-marker"></i> 河北省　廊坊市
                </div>
                <hr>
                <dl class="clearfix mt20 userMessage">
                    <dt class="">所有会议：</dt>
                    <dd class="clearfix"><i class="glyphicon glyphicon-adjust"></i> 未发布会议 <span
                            class="pull-right"><a href="index_pulic.html" class="">10</a>个</span></dd>
                    <dd class="clearfix"><i class="glyphicon glyphicon-adjust"></i> 已发布会议 <span
                            class="pull-right"><a href="#" class="">10</a>个</span></dd>
                    <dd class="clearfix"><i class="glyphicon glyphicon-adjust"></i> 已结束会议 <span
                            class="pull-right"><a href="#" class="">10</a>个</span></dd>
                </dl> -->
            </div>
            <div id="rrrr" class="hidden">
                <form class="row" role="form">
                    <div class="form-group col-md-12">
                        <label >昵称是您的个性身份展示，不用来登录</label>
                        <input type="name" class="form-control" id="name" placeholder="请输入您的昵称">

                    </div>
                </form>
            </div>
            <div class="col-xs-9 UCContent">
                <!--欢迎图-->
                <img src="${base}/resources/admin/themes/default/images/banner.jpg">
            </div>
        </div>
    </div>
</div>
<!-- 修改 -->
<div class="modal fade" id="_personalDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="_personalDiv_content">
            
        </div>
    </div>
</div>
</body>
</html>