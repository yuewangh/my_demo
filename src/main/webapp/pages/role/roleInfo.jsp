<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>

<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		
		_form = $("#editRoleForm").validate();
	});

	function submitRole() {
        if(_form.form()){
        	$("#editRoleForm").ajaxSubmit({
                type: 'post',
                success: function (data) {
                   $("#roleInfoDiv").modal("hide");
                   $(grid_selector).setGridParam({url:data_url}).trigger("reloadGrid");
                }
            });
        }
    }
    
    

</script>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">角色信息</h4>
</div>
<div class="modal-body">
    <form id="editRoleForm" class="pagination_form form-horizontal" role="form" method="POST"
          action="${path}/system/role/saveRole.json">
        <input type="hidden" name="uuid" id="uuid" value="${role.uuid }"/>
	<div class="form-group">
              		<label class="col-xs-2 control-label" for="key"><font style="color: red;">※</font>角色编码</label>
                   <div class="col-xs-8">
                   <c:if test="${role.uuid != null && role.uuid != '' }" var="flag">
                   		<input type="text" id="key" name="key" value="${role.key}" 
               				class="form-control" readonly=readonly />
                   </c:if>
                   <c:if test="${!flag }">
                       <input type="text" id="key" name="key" value="${role.key}" 
			               	class="form-control" 
                                         data-rule-required="true"
                                         data-msg-required="请录入角色编码。"
                                         data-rule-minlength="3"
                                         data-msg-minlength="角色编码最少为3个字符"
                                         data-rule-remote="${base }/system/role/validateRoleKey.json"
                                         data-msg-remote="您输入的角色编码已经存在，请输入其它的角色编码。"
                                         maxlength="30"
                                         placeholder="角色编码"
                                         onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"/>
               	</c:if>
               <span id="error"></span>	
           </div>
   	</div>
       <div class="form-group">
           <label for="key" class="col-xs-2 control-label"><font style="color: red;">※</font>角色名称</label>
           <div class="col-xs-8">
           	<input type="text" id="name" name="name" value="${role.name}" class="form-control" />
           </div>
       </div>
       
       <div class="form-group">
           <label for="survivalStatus" class="control-label col-xs-2">状态</label>
			<div class="col-xs-8">
			    <select id="survivalStatus" name="survivalStatus" class="form-control"  >
			        <option value="true" <c:if test="${role.survivalStatus }">selected</c:if>>有效</option>
			        <option value="false" <c:if test="${!role.survivalStatus }">selected</c:if>>无效</option>
			    </select>
			</div>
       </div>
       <div class="form-group">
           <label class="col-xs-2 control-label" for="description">描述：</label>
           <div class="col-xs-8">
               <textarea name="description" id="description" class="form-control" 
                			placeholder="角色描述"
                            cols="40" rows="4" data-rule-maxlength="100" data-msg-maxlength="描述信息不能超过100字符" >${role.description}</textarea>
           </div>
       </div>
    </form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button type="button" class="btn btn-primary" onclick="submitRole()">
        保存
    </button>
</div>
