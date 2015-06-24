<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>

<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		_form = $("#editUserForm").validate();
	});

	function submitUser() {
        if(_form.form()){
        	$("#editUserForm").ajaxSubmit({
                type: 'post',
                success: function (data) {
                	alert(data.msg);
                	if(data.success){
               			$("#_personalDiv").modal("hide");
                	}
                }
            });
        }
    }
    
    

</script>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">修改密码</h4>
</div>
<div class="modal-body">
    <form id="editUserForm" class="pagination_form form-horizontal" role="form" method="POST"
          action="${path}/system/account/savePassword.json">
       <div class="form-group">
           <label class="col-sm-2 control-label" for="password"><font style="color: red;">*</font>旧&nbsp;密&nbsp;码&nbsp;：</label>
           <div class="col-sm-10">
               <input type="password" id="oldPwd" name="oldPwd" class="form-control input clearText "
               	data-rule-required="true"
						data-msg-required="请录入旧密码." data-rule-minlength="6"
						data-msg-minlength="密码最少为6个字符" data-rule-maxlength="16"
						data-msg-maxlength="密码最大为16个字符" placeholder="6~16个字符，区分大小写"
                		style="width:210px;" />
           </div>
       </div>
       
       <div class="form-group">
           <label class="col-sm-2 control-label" for="password"><font style="color: red;">*</font>新&nbsp;密&nbsp;码&nbsp;：</label>
           <div class="col-sm-10">
               <input type="password" id="pwd" name="pwd" class="form-control input clearText "
               	data-rule-required="true"
						data-msg-required="请录入新密码." data-rule-minlength="6"
						data-msg-minlength="密码最少为6个字符" data-rule-maxlength="16"
						data-msg-maxlength="密码最大为16个字符" placeholder="6~16个字符，区分大小写"
                		style="width:210px;" />
           </div>
       </div>
       
       <div class="form-group">
           <label class="col-sm-2 control-label" for="pwdStr"><font style="color: red;">*</font>确认密码：</label>
           <div class="col-sm-10">
           	<input type="password" id="pwdStr" name="pwdStr" class="form-control input clearText "
           	data-rule-required="true"
			data-msg-required="请输入重复密码。" data-rule-equalTo="#pwd"
			data-msg-equalTo="重复密码与新的密码不相同。" placeholder="6~16个字符，区分大小写"
           	 style="width:210px;"/>
           </div>
       </div>

    </form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button type="button" class="btn btn-primary" onclick="submitUser()">
        保存
    </button>
</div>
