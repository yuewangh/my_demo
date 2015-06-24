<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<head>
<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="${path}/scripts/My97DatePicker/WdatePicker.js" ></script>
<script type="text/javascript" src="${path}/scripts/regionData.js"></script>
<link rel="stylesheet" href="${path}/scripts/ueditor/themes/default/css/ueditor.css" type="text/css">
    <script type="text/javascript" charset="utf-8">
        window.UEDITOR_HOME_URL = "${path}/scripts/ueditor/";
    </script>
    <script type="text/javascript" charset="utf-8" src="${path}/scripts/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${path}/scripts/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="${path}/scripts/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
$(function(){
	//初始化文本编辑器
			 UE.getEditor('myEditor');  
		_form =  $("#editMessageForm").validate();
	});
	function submitMessage(){
		if (_form.form()) {
				$("#editMessageForm").ajaxSubmit({
					dataType : "json",
					success : function(data) {
						if (data.success) {
							alert(data.opt + "通知消息成功！");
						} else {
							alert(data.opt + "通知消息失败！");
						}
				window.location.href="${path}/system/message/index.vhtml";
					}
				});
		}
	}
</script>
</head>
<body>
<div class="modal-header">
    <h4 class="modal-title"><c:if test="${operateType=='add'}">新增通知信息</c:if><c:if test="${operateType=='update'}">修改通知信息</c:if></h4>
</div>
<div class="modal-body">
 <form id="editMessageForm" class="pagination_form form-horizontal" role="form" method="post"
          action="${path}/system/message/saveOrUpdate.vhtml">
        
<div class="form-group">
              		<label class="col-sm-2 control-label" for="title"><font style="color: red;">*</font>&nbsp;标&nbsp;&nbsp;题&nbsp;：</label>
                   <div class="col-sm-10">
                    <input type="text" id="uuid" name="uuid" value="${message.uuid }" style="display:none" />
                    <input type="text" id="title" name="title" value="${message.title }" 
                   	 	   class="form-control input clearText "
	                    	data-rule-required="true"
	       					data-msg-required="请录入通知标题。" 
	       					data-rule-minlength="2"
	       					data-msg-minlength="通知标题最少为2个字符" 
	       					data-rule-maxlength="32"
	       					data-msg-maxlength="通知标题最大为32个字符"
               			   	placeholder="通知标题"	/>
           </div>
   	</div>
       
       <div class="form-group">
           <label class="col-sm-2 control-label" for="content">&nbsp;内&nbsp;&nbsp;容&nbsp;：</label>
           <div class="col-sm-10">
           <textarea name="content" id="myEditor" style="height:300px;">${message.content }</textarea>  
			
           </div>
       </div>
<div class="" style="margin-left:300px;">
    <button type="button" class="btn btn-default" onclick="javascript:history.go(-1)">取消</button>
    <button type="button" class="btn btn-primary" onclick="submitMessage();"> 保存</button>
</div>
    </form>
    </div>
 </body>
