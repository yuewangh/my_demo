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
        	$("#editUserForm").submit();
        }
    }
    
    

</script>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">找回密码</h4>
</div>
<div class="modal-body">
    <form id="editUserForm" class="pagination_form form-horizontal" role="form" method="POST"
          action="${base }/portal/user/forgetPassword.vhtml">
       <div class="form-group">
           <label class="col-sm-2 control-label" for="loginName"><font style="color: red;">*</font>用&nbsp;户&nbsp;名&nbsp;：</label>
           <div class="col-sm-10">
               <input type="text" id="loginName" name="loginName" class="form-control input clearText "
               			data-rule-required="true"
						data-msg-required="请录入用户名."
                		style="width:210px;" />
           </div>
       </div>
       
       <div class="form-group">
           <label class="col-sm-2 control-label" for="registerMail"><font style="color: red;">*</font>邮箱：</label>
           <div class="col-sm-10">
               <input type="text" id="registerMail" name="registerMail" class="form-control input clearText "
               	data-rule-required="true" 
                    		data-msg-required="请录入电子邮箱。"
							data-rule-email="true" 
							data-msg-email="邮箱格式错误，请确认你录入的邮箱地址。"
							maxlength="50" 
                		style="width:210px;" />
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
