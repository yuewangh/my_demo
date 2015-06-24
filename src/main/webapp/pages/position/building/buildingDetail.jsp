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
$(function(){
	//初始化区域信息
	var building_region = "${requestScope.building.region}";
	$.each(regionData, function (i, item){
		if(building_region==item){
			$("#region").append("<option  class='form-control' value='"+item+"' selected >"+item+"</option>");
		}else{
		$("#region").append("<option  class='form-control' value='"+item+"' >"+item+"</option>");
		}
	});
});
</script>
</head>
<body>
<div class="modal-header">
    <h4 class="modal-title"><span style="font-weight:bold;font-size:18px;">${building.title }</span>&nbsp;&nbsp;基本信息</h4>
</div>
<div class="modal-body">
    <form id="editBuildingForm" class="pagination_form form-horizontal" role="form" method="post"
          action="${path}/position/building/saveOrUpdate.vhtml">
        
<div class="form-group">
              		<label class="col-sm-2 control-label" for="title">&nbsp;名&nbsp;&nbsp;称&nbsp;：</label>
                   <div class="col-sm-8">
                    <input type="text" id="uuid" name="uuid" value="${building.uuid }" style="display:none"  disabled="disabled"/>
                       <input type="text" id="title" name="title" value="${building.title }" onblur="checkLoginName()" onfocus="checkLoginName()" onkeyup="$('#error').hide()"
               	class="form-control input clearText {required:true,checkLoginName:true,minlength:3,maxlength:50}" disabled="disabled" />
               <span id="error"></span>	
           </div>
   	</div>
       
        <div class="form-group">
                        <label class="col-sm-2 control-label">大楼图片</label>

                        <div class="col-sm-7">
                            <img alt="大楼图片" width="400" height="260" src="${building.picture}">
                        </div>
                    </div>
                     <div class="form-group">
						<label class="col-sm-2 control-label" for="title">&nbsp;区&nbsp;&nbsp;域&nbsp;：</label>
                                    <div class="col-sm-3">
                                    	 <select name="region" id="region" class="form-control input-sm" 
                                    	 		data-rule-required="true"
	       										data-msg-required="请选择区域。"disabled="disabled">
                                    	 	<option value="">全部</option>
                                        </select>
                                    </div>
					</div>
                           <div class="form-group">
           <label class="col-sm-2 control-label" for="address">&nbsp;地&nbsp;&nbsp;址：&nbsp;</label>
           <div class="col-sm-8">
           	<input type="text" id="address" name="address"  value="${building.address }" class="form-control input clearText {required:true,maxlength:50}" disabled="disabled" />
           </div>
       </div>
       
       <div class="form-group">
           <label class="col-sm-2 control-label" for="description">&nbsp;描&nbsp;&nbsp;述&nbsp;：</label>
           <div class="col-sm-8" >
              <div class="hero-unit well">${building.description }</div>
           </div>
       </div>

<div class="col-lg-6 text-center">
    <button type="button" class="btn btn-default" style="margin-left:300px;" data-dismiss="modal" onclick="window.location.href='${path}/position/building/index.vhtml'">返回</button>
</div>
    </form>
</div>
</body>