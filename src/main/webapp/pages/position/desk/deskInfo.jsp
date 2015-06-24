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
		_form = $("#editDeskForm").validate();
		//初始化文本编辑器
		 UE.getEditor('myEditor');  
	});
	function submitDesk() {
        if(_form.form()){
        	var picture = $("#deskImage").val();
			if(picture!=null&&picture!=""){
				$("#editDeskForm").ajaxSubmit({
					dataType : "json",
	                success: function (data) {
	                	if(data.success){
	                		alert(data.opt+"办公桌信息成功！");
	                	window.location.href="${path}/position/desk/index.vhtml";
	                	}else{
	                		alert(data.opt+"办公桌信息失败！");
	                	}
	                }
	            });
			}else{
				alert("请上传办公桌图片");
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
	function changeBuilding(){
		$("#buildingTitle").val($("#buildingUuid").find("option:selected").text());
	}
</script>
</head>
<body>
<div class="modal-header">
	<h4 class="modal-title">办公桌信息</h4>
</div>
<div class="modal-body">
		  <form id="editDeskForm" class="pagination_form form-horizontal" role="form" method="post"
          action="${path}/position/desk/saveOrUpdate.vhtml">
		 <input type="text" id="uuid" name="uuid" value="${desk.uuid }" style="display:none" />
		 <input type="text" id="buildingTitle" name="buildingTitle" value="${desk.buildingTitle }" style="display:none" />
		<div class="col-lg-8 row">
		<div class="form-group">
			<label class="col-sm-2 control-label" for="code"><font
				style="color: red;">*</font>&nbsp;&nbsp;编&nbsp;&nbsp;号&nbsp;：</label>
			<div class="col-sm-10">
				<input type="text" id="code" name="code" value="${desk.code }"
					class="form-control input clearText"
					data-rule-required="true"
	       			data-msg-required="请录入办公桌编号。"  placeholder="办公桌编号" />
			</div>
		</div>
  

		<div class="form-group">
			<label class="col-sm-2 control-label" for="title"><font
				style="color: red;">*</font>&nbsp;&nbsp;名&nbsp;&nbsp;称&nbsp;：</label>
			<div class="col-sm-10">
			 <input type="text" id="title"
			 				data-rule-required="true"
	       					data-msg-required="请录入办公桌名称。" 
	       					data-rule-minlength="2"
	       					data-msg-minlength="办公桌名称最少为2个字符" 
	       					data-rule-maxlength="100"
	       					data-msg-maxlength="办公桌名称最大为100个字符"
							name="title" value="${desk.title }" 
							class="form-control input clearText"
					 placeholder="办公桌名称"/> <span id="error"></span>
			</div>
		</div>
		<div class="form-group">
		<label class="col-sm-2 control-label" for="buildingUuid"><font
				style="color: red;">*</font>&nbsp;办公楼：</label>
                                    <div class="col-xs-5">
                                    	 <select name="buildingUuid" id="buildingUuid" 
                                    	 class="form-control" onchange="changeBuilding();"
                                    	 data-rule-required="true"
	       								 data-msg-required="请选择办公楼。" >
                                    	 	<option value="">全部</option>
                                    	 	<c:forEach items="${buildinglist}" var="build">
                                    	 		<option value="${build.uuid}" <c:if test="${desk.buildingUuid == build.uuid}">selected</c:if>>${build.title}</option>
                                    	 	</c:forEach>
                                        </select>
                                    </div>
		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label" for="picture"><font
				style="color: red;">*</font>&nbsp;&nbsp;快&nbsp;&nbsp;照&nbsp;：</label>
				<div class="col-sm-10">
                         <a id="selectImage" class="btn btn-primary" href="#">上传图片</a>
                       
                            <input type="hidden" id="deskImage" name="picture" value="${desk.picture}"/>
                            <sys:upload id="selectImage" extensions="jpg,gif,png">
                                <jsp:attribute name="callback">
                                    $('#deskImage').val(fileInfo.url);
                                    $('#showDeskImage').attr('src',fileInfo.url);
		                        </jsp:attribute>
                            </sys:upload>
                    </div>
		</div>
	
		<div class="form-group">
<!-- 			<label class="col-sm-2 control-label" for="capactity">&nbsp;&nbsp;  面&nbsp;&nbsp;积&nbsp;&nbsp;：</label> -->
<!-- 			<div class="col-sm-5"> -->
<%-- 				<input type="text" name="area" id="area" value="${desk.area }" --%>
<!-- 				class="form-control input clearText"  -->
<!-- 				data-rule-positiveNum="true" -->
<!-- 				data-msg-positiveNum="工位数量请输入正数" -->
<!-- 				placeholder="办公面积"/> -->
<!-- 			</div> -->
			<label class="col-sm-2 control-label" for="capactity">&nbsp;&nbsp; 工&nbsp;&nbsp;位&nbsp;&nbsp;：</label>
			<div class="col-sm-10">
				<input type="text" name="capactity" id="capactity"
					value="${desk.capactity}"
					class="form-control input clearText" 
					data-rule-required="true"
	       			data-msg-required="请输入工位数量。"
					data-rule-positiveIntegerNum="true"
					data-msg-positiveIntegerNum="工位数量请输入正整数"
					placeholder="工位数量"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="unitPrice">&nbsp;&nbsp; 单&nbsp;&nbsp;价&nbsp;&nbsp;：</label>
			<div class="col-sm-8">
				<input type="text" name="unitPrice" id="unitPrice"
					value="${desk.unitPrice }"
					class="form-control input clearText"
					data-rule-positiveNum="true"
					data-msg-positiveNum="单价请输入正数"
					placeholder="单价" />
			</div>
			<div class="col-sm-2">
					<select name="unitAccount" id="unitAccount" class="form-control ">
<!-- 						<option>天</option> -->
<!-- 						<option>周</option> -->
						<option>月</option>
<!-- 						<option>年</option> -->
					</select>
			</div>
		</div>
		
       </div>
       <div class="col-lg-4">
       		  <img id="showDeskImage" src="${desk.picture }" width="100%" height="280px;" alt="办公桌图片">
       </div>
       <div class="col-lg-12">
<!--        <div class="form-group"> -->
<!--            <label class="col-lg-1 control-label" for="description">&nbsp;&nbsp;描&nbsp;&nbsp;述&nbsp;&nbsp;：</label> -->
<!--            <div class="col-lg-11"> -->
<!--              <textarea id="myEditor" name="description" cols="50" style="height:300px;" -->
<%--                             rows="50" placeholder="大楼简介">${desk.description }</textarea> --%>
<!--            </div> -->
<!--        </div> -->
       </div>
		<div class="col-lg-12 text-center">
			<button type="button" class="btn btn-default"  onclick="window.location.href='${path}/position/desk/index.vhtml'">取消</button>
			<button type="button" class="btn btn-primary"  onclick="submitDesk();">保存</button>
		</div>
	</form>
</div>
</body>