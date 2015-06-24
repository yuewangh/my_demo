<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<head>
<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="${path}/scripts/My97DatePicker/WdatePicker.js" ></script>
<script type="text/javascript" src="${path}/scripts/regionData.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<div class="modal-header">
	<h4 class="modal-title">办公桌信息</h4>
</div>
<div class="modal-body">
	<form id="editdeskForm" class="pagination_form form-horizontal"
		role="form" method="POST"
		action="${path}/position/desk/saveOrUpdate.json">
		 <input type="text" id="uuid" name="uuid" value="${desk.uuid }" style="display:none" />
		 <input type="text" id="buildingTitle" name="buildingTitle" value="${building.title }" style="display:none" />
		<div class="form-group">
			<label class="col-sm-2 control-label" for="code"><font
				style="color: red;">*</font>&nbsp;&nbsp;编&nbsp;&nbsp;号&nbsp;：</label>
			<div class="col-sm-10">
				<input type="text" id="code" name="code" value="${desk.code }"
					class="form-control input clearText {required:true,maxlength:50}"
					style="width: 500px;"  disabled="disabled" />
			</div>
		</div>


		<div class="form-group">
			<label class="col-sm-2 control-label" for="title"><font
				style="color: red;">*</font>&nbsp;&nbsp;名&nbsp;&nbsp;称&nbsp;：</label>
			<div class="col-sm-10">
			 <input type="text" id="title"
					name="title" value="${desk.title }" onblur="checkLoginName()"
					onfocus="checkLoginName()" onkeyup="$('#error').hide()"
					class="form-control input clearText {required:true,checkLoginName:true,minlength:3,maxlength:50}"
					style="width: 500px;" disabled="disabled"/> <span id="error"></span>
			</div>
		</div>
		<div class="form-group">
		<label class="col-sm-2 control-label" for="title"><font
				style="color: red;">*</font>&nbsp;办公楼：</label>
                                    <div class="col-xs-5">
                                    	<input type="text" name="buildingTitle" id="buildingTitle"
					value="${desk.buildingTitle }"
					class="form-control input clearText "
					style="width: 500px;" disabled="disabled" />
                                    </div>
		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label"><font
				style="color: red;">*</font>&nbsp;&nbsp;快&nbsp;&nbsp;照&nbsp;：</label>
				    <div class="col-sm-7">
                         <img id="showdeskImage" src="${desk.picture }" width="80%" height="240" alt="大楼图片">
                            <input type="hidden" id="deskImage" name="picture">
                    </div>
		</div>
	
<!-- 		<div class="form-group"> -->
<!-- 			<label class="col-sm-2 control-label" for="description">&nbsp;&nbsp;描&nbsp;&nbsp;述&nbsp;&nbsp;：</label> -->
<!-- 			<div class="col-sm-8"> -->
<%-- 				<div class="hero-unit well">${desk.description } </div>--%>
<!-- 			</div> -->
<!-- 		</div> -->
		
<!-- 		<div class="form-group"> -->
<!-- 			<label class="col-sm-2 control-label" for="description">&nbsp;&nbsp; 面&nbsp;&nbsp;积&nbsp;&nbsp;：</label> -->
<!-- 			<div class="col-sm-10"> -->
<!-- 				<input type="text" name="area" id="area" -->
<%-- 					value="${desk.area }" --%>
<!-- 					class="form-control input clearText" -->
<!-- 					style="width: 500px;" disabled="disabled" /> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="form-group">
			<label class="col-sm-2 control-label" for="description">&nbsp;&nbsp; 工&nbsp;&nbsp;位&nbsp;&nbsp;：</label>
			<div class="col-sm-10">
				<input type="text" name="capactity" id="capactity"
					value="${desk.capactity }"
					class="form-control input clearText"
					style="width: 500px;" disabled="disabled" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="description">&nbsp;&nbsp; 单&nbsp;&nbsp;价&nbsp;&nbsp;：</label>
			<div class="col-sm-10">
				<input type="text" name="unitPrice" id="unitPrice"
					value="${desk.unitPrice }"
					class="form-control input clearText"
					style="width: 500px;" disabled="disabled" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="description">&nbsp;计&nbsp;算&nbsp;单&nbsp;位：</label>
			<div class="col-sm-10">
				<input type="text" name="unitAccount" id="unitAccount"
					value="${desk.unitAccount }"
					class="form-control input clearText"
					style="width: 500px;" disabled="disabled" />
			</div>
		</div>
		<div class="col-sm-6 text-center">
			<button type="button" class="btn btn-default"  style="margin-left:300px;" data-dismiss="modal" onclick="window.location.href='${path}/position/desk/index.vhtml'"> 返回</button>
		</div>
	</form>
</div>
</body>
