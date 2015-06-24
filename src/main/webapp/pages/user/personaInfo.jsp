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
	                   		$("#userInfoDiv").modal("hide");
	               			if($(grid_selector)){
	               				$(grid_selector).setGridParam({url:data_url}).trigger("reloadGrid");
	               			}
                		}
                }
            });
        }
    }
    
    

</script>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">会员信息</h4>
</div>
<div class="modal-body">
    <form id="editUserForm" class="pagination_form form-horizontal" role="form" method="POST"
          action="${path}/system/persona/savePersona.json">
        <input type="hidden" name="uuid" id="uuid" value="${userInfoBean.uuid }"/>
        <input type="hidden" name="survival" id="survival" value="${userInfoBean.survival }"/>
	<div class="form-group">
              		<label class="col-sm-2 control-label" for="loginName" ><font style="color: red;">*</font>用&nbsp;户&nbsp;名：</label>
                   <div class="col-sm-10">
                   <c:if test="${userInfoBean.uuid != null && userInfoBean.uuid != '' }" var="flag">
                   		<input type="text" id="loginName" name="loginName" value="${userInfoBean.loginName}" 
               				class="form-control input clearText" readonly=readonly style="width:210px;" />
                   </c:if>
                   <c:if test="${!flag }">
                       <input type="text" id="loginName" name="loginName" value="${userInfoBean.loginName}" 
			               	class="form-control input clearText" 
							data-rule-required="true" data-rule-checkLoginName="true"
							data-msg-required="请录入用户名。" data-rule-minlength="6"
							data-msg-minlength="用户名最少为6个字符" data-rule-maxlength="20"
							data-msg-maxlength="用户名最大为20个字符"
							data-rule-remote="${path}/system/account/validateLoginName.json"
							data-msg-remote="您输入的用户名已经存在。"
			               	style="width:210px;"  placeholder="用户名"/>
               	</c:if>
               <span id="error"></span>	
           </div>
   	</div>
   	<c:if test="${userInfoBean.uuid == null || userInfoBean.uuid == '' }">
       <div class="form-group">
           <label class="col-sm-2 control-label" for="password"><font style="color: red;">*</font>密&nbsp;&nbsp;码&nbsp;：</label>
           <div class="col-sm-10">
               <input type="password" id="password" name="password" class="form-control input clearText "
               	data-rule-required="true"
						data-msg-required="请录入密码." data-rule-minlength="6"
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
			data-msg-required="请输入重复密码。" data-rule-equalTo="#password"
			data-msg-equalTo="重复密码与新的密码不相同。" placeholder="6~16个字符，区分大小写"
           	 style="width:210px;"/>
           </div>
       </div>
       </c:if>
       <div class="form-group">
           <label class="col-sm-2 control-label" for="name"><font style="color: red;">*</font>姓&nbsp;&nbsp;名&nbsp;：</label>
           <div class="col-sm-10">
           	<input type="text" id="name" name="name" value="${userInfoBean.name}" class="form-control input clearText {required:true,minlength:2,maxlength:50}" style="width:210px;" />
           </div>
       </div>
       
       <div class="form-group">
           <label class="col-sm-2 control-label" for="gender">&nbsp;性&nbsp;&nbsp;别&nbsp;：</label>
           <div class="col-sm-5">
           	<select name="gender" id="gender" class="form-control input clearText" >
           		<option value="MALE" <c:if test="${userInfoBean.gender == 'MALE' }">selected</c:if>>男</option>
           		<option value="FEMALE" <c:if test="${userInfoBean.gender == 'FEMALE' }">selected</c:if>>女</option>
           	</select>
           </div>
       </div>
       <div class="form-group">
           <label class="col-sm-2 control-label" for="tel">电话号码：</label>
           <div class="col-sm-10">
                 <input type="text" name="tel" id="tel" value="${userInfoBean.tel}" class="form-control input clearText {tel:true}" data-rule-tel="true"
									data-msg-tel="电话格式错误，请确认你录入的电话。" maxlength="20"
									placeholder="电话" style="width:210px;"/>
           </div>
       </div>
       <div class="form-group">
           <label class="col-sm-2 control-label" for="mail"><font style="color: red;">*</font>电子邮箱：</label>
           <div class="col-sm-10">
               <input type="text" name="mail" id="mail" value="${userInfoBean.mail}" class="form-control input clearText {email:true}" data-rule-required="true" data-msg-required="请录入电子邮箱。"
							data-rule-email="true" data-msg-email="邮件格式错误，请确认你录入的邮件。"
							maxlength="50" placeholder="电子邮箱"
							style="width:210px;"/>
           </div>
       </div>
       <div class="form-group">
           <label class="col-sm-2 control-label" for="mail">出生日期：</label>
           <div class="col-sm-10">
               <input id="birthdayStr" name="birthdayStr" class="form-control w4" type="text" value="${userInfoBean.birthday}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,readOnly:true})"/>
           </div>
       </div>

       <div class="form-group">
           <label class="col-sm-2 control-label" for="dept">公司名称：</label>
           <div class="col-sm-10">
           	<input type="text" id="unit" name="unit" value="${userInfoBean.unit}" class="form-control input clearText"
           	 						maxlength="50"
									placeholder="公司名称"
									data-msg-required="请录入公司名称" 
									 style="width:210px;" />
           </div>
       </div>
       <div class="form-group">
           <label class="col-sm-2 control-label" for="jobInfo">职位：</label>
           <div class="col-sm-10">
               <input type="text" id="jobInfo" name="jobInfo" value="${userInfoBean.jobInfo}" class="form-control input clearText"
                maxlength="30" placeholder="职位"
				data-msg-required="请录入职位"
                style="width:210px;" />
           </div>
       </div>
       <div class="form-group">
           <label class="col-sm-2 control-label" for="address">地址：</label>
           <div class="col-sm-10">
               <input type="text" id="address" name="address" value="${userInfoBean.address}" class="form-control input clearText"
                maxlength="30" placeholder="地址"
				data-msg-required="请录入地址"
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
