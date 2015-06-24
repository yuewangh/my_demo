<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>


<style type="text/css">
    .form-horizontal .editPh {
        background: rgba(0, 0, 0, 0.5);
        width: 200px;
        height: 22px;
        line-height: 22px;
        color: #fff;
        text-align: center;
        position: absolute;
        bottom: 0;
    }

    .form-horizontal .editPh a {
        color: #fff;
    }
</style>

<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery-migrate-1.1.1.min.js"></script>

<link rel="stylesheet" href="${base}/scripts/ueditor/themes/default/css/ueditor.css" type="text/css">
<script type="text/javascript">
    window.UEDITOR_HOME_URL = "${base}/scripts/ueditor/";
</script>
<script type="text/javascript" src="${base}/scripts/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${base}/scripts/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${base}/scripts/ueditor/lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript">
    $(function () {
        UE.getEditor('content');

        var validator = $("#information_form").validate({
            bootstrap: true
        });

        $('#submitButton').click(function () {
            submitForm("${base}/activity/manager/saveActivity.json");
        });

        function submitForm(url) {
            if (validator.form()) {
                $("#information_form").attr('action', url).ajaxSubmit({
                    type: 'post',
                    dataType:'json',
                    success: function (data) {
                    	alert(data.msg);
                        if (data.success) {
                        	$("#_infoDiv").modal("hide");
                        	toSearch();
                        }
                    }
                });
            }
        }

    });
</script>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">活动信息</h4>
</div>
<div class="modal-body">
    
    <form id="information_form" class="pagination_form form-horizontal" role="form" method="POST"
          action="${base}/activity/manager/saveActivity.json">
	    <div class="modal-body row">
	        <input type="hidden" name="uuid" value="${information.uuid}">
	        <input type="hidden" name="type" value="${information.type}">
	        <input type="hidden" name="portletId" value="${information.portletId}">
	
	        <div class="col-sm-12">
	            <div class="row">
	                <div class="col-sm-3 ">
	                    <span class="media-left ph">
	                        <sys:upload id="selectImage" extensions="jpg,gif,png">
                                <jsp:attribute name="callback">
                                    $('#titleImageVal').val(fileInfo.url);
                                    $('#titleImageSrc').attr('src',fileInfo.url);
		                        </jsp:attribute>
                            </sys:upload>
	                            <input id="titleImageVal" name="pictureUrl" value="${information.pictureUrl}"
	                                   type="hidden">
	                        <img id="titleImageSrc" src="<c:if test="${information.pictureUrl == \"\"  || information == null}" var="flag">${base}/images/pictures.png</c:if><c:if test="${!flag }">${information.pictureUrl}</c:if>" alt="标题图片"
	                             style="width: 200px;height: auto;">
	                        <p  id="selectImage" class="editPh"><a href="#">上传图片</a></p>
	                    </span>
	                </div>
	                <div class="col-sm-9">
	                    <div class="form-group has-feedback">
	                        <label class="col-sm-2 control-label no-padding-right">活动标题：</label>
	
	                        <div class="col-xs-10 col-sm-10">
	                            <input type="text" id="title" name="title"
	                                   placeholder="活动标题"
	                                   class="form-control" maxlength="20"
	                                   data-rule-required="true"
	                                   value="${information.title}">
	                        </div>
	                    </div>
	                    <div class="form-group has-feedback">
	                        <label class="col-sm-2 control-label no-padding-right">活动时间：</label>
	
	                        <div class="col-xs-7 col-sm-7">
	                            <input id="activityDateStr" name="activityDateStr" class="form-control" type="text" value="${information.activityDateStr}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false,readOnly:true})"/>
			
	                        </div>
	                    </div>
	                    <div class="form-group has-feedback">
	                        <label class="col-sm-2 control-label no-padding-right">活动地点：</label>
	
	                        <div class="col-xs-7 col-sm-7">
	                            <input type="text" id="activityAddress" name="activityAddress"
	                                   placeholder="活动地点"
	                                   class="form-control" maxlength="100"
	                                   value="${information.activityAddress}">
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label no-padding-right">简介：</label>
	
	                        <div class="col-xs-10 col-sm-10">
	                        <textarea id="summary" name="summary"
	                                  placeholder="简介"
	                                  class="form-control" rows="3"
	                                  maxlength="100">${information.summary}</textarea>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="col-sm-12" style="padding-top: 20px;">
	                    <textarea id="content" name="content" style="height: 400px;">${information.content}</textarea>
	                </div>
	            </div>
	        </div>
	    </div>
	</form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button type="button" id="submitButton" class="btn btn-primary">
        保存
    </button>
</div>
