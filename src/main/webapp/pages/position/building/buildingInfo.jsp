<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
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
	//初始化区域信息
	var building_region = "${requestScope.building.region}";
	$.each(regionData, function (i, item){
		if(building_region==item){
			$("#region").append("<option class='form-control' value='"+item+"' selected >"+item+"</option>");
		}else{
		$("#region").append("<option  class='form-control' value='"+item+"' >"+item+"</option>");
		}
	});
		_form =  $("#editBuildingForm").validate();
	});
	function submitBuilding(){
		if (_form.form()) {
			var picture = $("#buildingImage").val();
			if(picture!=null&&picture!=""){
				$("#editBuildingForm").ajaxSubmit({
					dataType : "json",
					success : function(data) {
						if (data.success) {
							alert(data.opt + "办公楼信息成功！");
							window.location.href="${path}/position/building/index.vhtml";
						} else {
							alert(data.opt + "办公楼信息失败！");
						}
					}
				});
			}else{
				alert("请上传大楼图片");
				return false;
			}
		}
	}
	function checkLoginName() {
		if ($("#loginName").val() != null && $("#loginName").val() != '') {
			$
					.ajax({
						type : 'POST',
						url : '${path}/userManager-ajax/validateLoginName.action?loginName='
								+ $("#loginName").val(),
						data : {},
						success : function(data) {
							if (data.status) {
								$('#sign').val('true');
								$('#error').hide();
							} else {
								$('#sign').val('false');
								$('#error')
										.html(
												'<label for="loginName " class="error" generated="true">用户名已经存在</label>');
								$('#error').show();
							}
						},
						complete : function() {
						}
					});
		}
	}
</script>
</head>
<body>
<div class="modal-header">
    <h4 class="modal-title">办公大楼信息</h4>
</div>
<div class="modal-body">
 <form id="editBuildingForm" class="pagination_form form-horizontal" role="form" method="post"
          action="${path}/position/building/saveOrUpdate.vhtml">
 <div class="col-lg-8 row">
<div class="form-group">
              		<label class="col-sm-2 control-label" for="title"><font style="color: red;">*</font>&nbsp;名&nbsp;&nbsp;称&nbsp;：</label>
                   <div class="col-sm-10">
                    <input type="text" id="uuid" name="uuid" value="${building.uuid }" style="display:none" />
                    <input type="text" id="title" name="title" value="${building.title }" 
                   	 	   class="form-control input clearText "
	                    	data-rule-required="true"
	       					data-msg-required="请录入大楼名称。" 
	       					data-rule-minlength="2"
	       					data-msg-minlength="大楼名称最少为2个字符" 
	       					data-rule-maxlength="100"
	       					data-msg-maxlength="大楼名称最大为100个字符"
               			   	placeholder="大楼名称"	/>
<%-- 	       					data-rule-remote="${path}/position/building/validateBuildingTitle.json" --%>
<!-- 							data-msg-remote="您输入的大楼名称已经存在。"  -->
           </div>
   	</div>
       
       		 <div class="form-group">
                        <label class="col-sm-2 control-label"><font style="color: red;">*</font>大楼图片</label>
					<div class="col-sm-10">
                         <a id="selectImage" class="btn btn-primary" href="#">上传图片</a>
                            <input type="hidden" id="buildingImage" name="picture" value="${building.picture }">
                            <sys:upload id="selectImage" extensions="jpg,gif,png">
                                <jsp:attribute name="callback">
                                    $('#buildingImage').val(fileInfo.url);
                                    $('#showBuildingImage').attr('src',fileInfo.url);
		                        </jsp:attribute>
                            </sys:upload>
                     </div>
               </div>
                    
                    <div class="form-group">
						<label class="col-sm-2 control-label" for="title"><font style="color: red;">*</font>&nbsp;区&nbsp;&nbsp;域&nbsp;：</label>
                                       <div class="col-sm-3">
                                    	 <select name="region" id="region" class="form-control input-sm" 
                                    	 		data-rule-required="true"
	       										data-msg-required="请选择区域。"  >
                                    	 	<option value="">全部</option>
                                        </select>
                                    </div>
					</div>
          <div class="form-group">
	           <label class="col-sm-2 control-label" for="address"><font style="color: red;">*</font>&nbsp;地&nbsp;&nbsp;址：&nbsp;</label>
	           <div class="col-sm-10">
	           	<input type="text" id="address" name="address"  value="${building.address }" 
	           			class="form-control input clearText" 
	           			data-rule-required="true"
		       			data-msg-required="请录入大楼地址。"
		       			data-rule-minlength="2"
	       				data-msg-minlength="大楼地址最少为2个字符" 
		       			data-rule-maxlength="100"
		       			data-msg-maxlength="大楼地址最大为100个字符"  
		       			placeholder="地址"/>
	           </div>
       	</div>
       </div>
       <div class="col-lg-4">
       		<img id="showBuildingImage" src="${building.picture }" width="100%" height="180" alt="大楼图片">
       </div> 
        <div class="col-sm-12">          
       <div class="form-group">
           <label class="col-sm-1  control-label" for="description">&nbsp;&nbsp;描&nbsp;&nbsp;述&nbsp;：</label>
           <div class="col-sm-11">
           <textarea name="description" style="height:300px;" id="myEditor">${building.description }</textarea>  
           </div>
       </div>
       </div>
<div class="col-lg-12 text-center">
    <button type="button" class="btn btn-default" onclick="window.location.href='${path}/position/building/index.vhtml'">取消</button>
    <button type="button" class="btn btn-primary" onclick="submitBuilding();"> 保存</button>
</div>
    </form>
    </div>
 </body>
