<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<html>
<head>
	<link rel="stylesheet" href="${base}/scripts/jqGrid/css/ui.jqgrid.me.css">
    <script src="${path}/scripts/jqGrid/js/i18n/grid.locale-cn.js" type="text/javascript"></script>
    <script src="${path}/scripts/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
    <script src="${path}/scripts/My97DatePicker/WdatePicker.js"  type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		grid_selector = "#officeGrid";
		pager_selector = "#pagerNav";
		data_url = "${path}/position/office/getList.json";
		$(grid_selector).jqGrid({
			url : data_url,
			mtype:"post",
			datatype : "json",
			height : 320,
			colNames : [ 'UUID', '编号', '名称', '图片','办公室UUID','所属办公楼','面积','工位','价格','计算周期'],
			colModel : [ {
				name : 'uuid',
				index : 'uuid',
				width : '20%',
				align : 'center',
				hidden: true
			}, 
			 {
				name : 'code',
				index : 'code',
				width : '15%',
				align : 'center',
				sortable : true
			},
			{
				name : 'title',
				index : 'title',
				width : '30%',
				align : 'center',
				formatter:function(cellvalue, options, rowObject){
					 return "<a href='${path}/position/office/officeView.vhtml?operateType=detail&uuid="+rowObject['uuid']+"' style='color:blue'>"+cellvalue+"</a>";
				}
			},
			{
				name : 'picture',
				index : 'picture',
				width : '10%',
				align : "center",
				hidden: true,
				sortable : false
			},
			{
				name : 'buildingUuid',
				index :'buildingUuid',
				width : '30%',
				align : "left",
				hidden: true,
			},
			 {
				name : 'buildingTitle',
				index :'buildingTitle',
				width : '30%',
				align : "left",
				sortable : false
			},
			 {
				name : 'area',
				index :'area',
				width : '10%',
				align : "left",
			}, 
			 {
				name : 'capactity',
				index :'capactity',
				width : '10%',
				align : "left",
				sortable : true
			}, 
			 {
				name : 'unitPrice',
				index :'unitPrice',
				width : '10%',
				align : "left",
				sortable : true
			},
			{
				name : 'unitAccount',
				index :'unitAccount',
				width : '10%',
				align : "left",
				sortable : true
			},],
			viewrecords : true,
			rowNum : 10,
			rowList : [ 10, 20, 30 ],
			pager : pager_selector,
			altRows : true,
			multiselect: true,
			multiboxonly: true,
			caption : "",
			autowidth : true
		}).navGrid(
				'#pagerNav',
				{
					add : true,
					addtext : '新增',
					addfunc : function() {
							window.location.href="${path}/position/office/officeView.vhtml?operateType=add";
					},
					edit : true,
					edittext : '修改',
					editfunc : function(rowid) {
						var ids=$(grid_selector).jqGrid('getGridParam','selarrrow');
						if(ids.length>1){
							$("#messageInfo").text("不能同时修改多条办公室信息");
							$("#messageDiv").modal('show');
							}
						if(ids.length==1){
							var data = jQuery(grid_selector).jqGrid('getRowData',
									rowid);
							if(data!=null){
								window.location.href="${path}/position/office/officeView.vhtml?operateType=update&uuid="
									+ data.uuid;

							}
						}
					},
					del : true,
					deltext:"删除",
					delfunc : function(rowid) {
						var rowIds=jQuery(grid_selector).jqGrid('getGridParam','selarrrow');
						if(rowIds.length==1){
						var data = jQuery(grid_selector).jqGrid('getRowData',rowid);
							$("#delOffice").html("确定删除选中的办公 室  "+data.title+" 吗？");
						}else if (rowIds.length>1){
							$("#delOffice").html("确定批量删除选中的办公室信息吗？");
						}
						$("#delOfficeDiv").modal('show');
					},
					refresh : true,
					alerttext : "请选择一条办公室信息"
				});
		//绑定删除事件
		$("#delOfficeBtn").click(function(){
			var rowIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
			var selectedId = jQuery(grid_selector).jqGrid("getGridParam","selrow");
			var url = "";
			if(rowIds.length==1){
				var data = jQuery(grid_selector).jqGrid('getRowData',selectedId);
				url = '${path}/position/office/delete.action?uuid='+data.uuid;
			}else if(rowIds.length>=1){
				var uuids = "";
				for(var index in rowIds){
					uuids=uuids+jQuery(grid_selector).jqGrid('getRowData',rowIds[index]).uuid+",";
				}
				url = '${path}/position/office/batchDelete.action?uuids='+uuids+'&rand='+new Date().toLocaleTimeString();
			}
			$.ajax({
            'url': url,
            'dataType': 'json',
            timeout: 6 * 1000,
            success: function (data) {
                if (data.success) {
                    alert("删除成功!");
                    $("#delOfficeDiv").modal('hide');
                    $(grid_selector).jqGrid().trigger("reloadGrid");
                } else {
                    alert("删除失败！");
                    $("#delOfficeDiv").modal('hide');
                }
            }
			});
	});
		
		function survivalFmatter(obj) {
			if ("VERIFY" == obj) {
				return "待验证";
			} else if ("ENABLE" == obj) {
				return "可用";
			} else {
				return "不可用";
			}
		}
	});
	function toSearch(){
		$(grid_selector).jqGrid('setGridParam', {postData: {office_code: $("#office_code").val(),office_title: $("#office_title").val(),building_title: $("#building_title").val()}}).trigger("reloadGrid");
	}
</script>
</head>
<body>
	<div>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">办公室列表</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form">
				<div class="form-group col-xs-5">
						<label for="" class="control-label col-xs-4">办公室编号</label>
						<div class="col-xs-8">
							<input type="text" class="form-control input-sm" id="office_code" name="office_code"
								placeholder="">
						</div>
					</div>
					<div class="form-group col-xs-5">
						<label for="" class="control-label col-xs-4">办公室名称</label>
						<div class="col-xs-8">
							<input type="text" class="form-control input-sm" id="office_title" name="office_title"
								placeholder="">
						</div>
					</div>
					<div class="form-group col-xs-5">
						<label for="" class="control-label col-xs-4">所属办公楼</label>
						<div class="col-xs-8">
							<input type="text" class="form-control input-sm" id="building_title" name="building_title"
								placeholder="">
						</div>
					</div>
					<div class="form-group col-xs-2 text-right">
						<button type="button" class="btn btn-default btn-sm" onclick="toSearch();">查询</button>
					</div>
				</form>
			</div>
		</div>

		<table id="officeGrid"></table>
		<div id="pagerNav"></div>
	</div>
	<!-- 提示消息-->
<div class="modal fade" id="messageDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="messageDiv_content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h2 style="font-weight:bolder;">
               	温馨提示
            </h2>
         </div>
         <div class="modal-body text-center">
             <span id="messageInfo" style="color:blue;font-size:16px;algin:center;"></span>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
         </div>
        </div>
    </div>
</div>
	<!-- 新增 -->
<div class="modal fade" id="officeInfoDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" data-backdrop="static"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="officeInfoDiv_content">
            
        </div>
    </div>
</div>
<div class="modal fade" id="delOfficeDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="delOfficeDiv_content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h2 style="font-weight:bolder;">
               	删除办公室信息
            </h2>
         </div>
         <div class="modal-body text-center">
             <span id="delOffice" style="color:blue;font-size:16px;"></span>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default"
               data-dismiss="modal">取消
            </button>
            <button type="button" class="btn btn-primary" id="delOfficeBtn">确定</button>
         </div>
        </div>
    </div>
</div>
</body>
</html>