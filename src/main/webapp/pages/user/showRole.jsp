<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
<script >

$(function(){
	$(".tabledv tbody tr:odd td").addClass("odd");
	$(".tabledv tbody tr:even td").addClass("even");
	$(".tabledv tbody tr").hover(function(){
		$(this).find("td").addClass("hover");
	},function(){
		$(this).find("td").removeClass("hover");
	});
});

$(function(){
	$('#RoleTo').bind('click',function(e){
		if($('input[name="roleId"]:checked').length >= 0){
			var roleIds = '';
			$('input[name="roleId"]:checked').each(function(){    
				roleIds += $(this).attr("value") + ",";
			});
            $.get(
                   '${path}/system/account/saveUserRole.json',
                   {'userId': '${userId}', 'roleIds': roleIds},
                   function (status) {
                	   alert(status.msg);
                       if(status.success){
                    	   toSearch();
                           $("#userInfoDiv").modal("hide");
                       }
                   }
            );
		}
	});
});
</script>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">角色信息</h4>
</div>
<div class="modal-body">
    <form id="editUserForm" class="pagination_form form-horizontal" role="form" method="POST"
          action="${path}/system/account/saveUserRole.json">
		<table class="table table-bordered">
	             	<thead>
	                     <tr>
	                     	<th class=""></th>
	                        <th class="">角色编码</th>
	                        <th class="">角色名</th>
	                     </tr>
	                 </thead>
	                 <tbody>
	                 	<c:forEach items="${roleList}" var="role" >
	                 		<tr>
	                      		<td>
	                      			<input name="roleId" type="checkbox" value="${role.uuid}" 
	                      				<c:forEach items="${userRoleList}" var="userRole">
		                      				<c:if test="${role.uuid == userRole.uuid}">
		                      					checked="checked"
		                      				</c:if>
	                      				</c:forEach>
	                      				<c:if test="${role.uuid == '1'}">
	                      					disabled="disabled"
	                      				</c:if>
	                      				<c:if test="${userId == '1' && user.uuid != userId}">
	                      					disabled="disabled"
	                      				</c:if>
	                      			 />
	                      		</td>
	                      		<td class="">${role.key}</td>
	                        	<td class="">${role.name}</td>
	                 		</tr>
	                 	</c:forEach>
	                 	<c:if test="${roleList == null}">
	                 		<tr>
	                 			<td colspan="4" class="centerText pt20 pb20">没有找到相关数据!</td>
	                 		</tr>	
	                 	</c:if>
	                 </tbody>
	             </table>
    </form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button type="button" class="btn btn-primary" id="RoleTo">
        保存
    </button>
</div>
