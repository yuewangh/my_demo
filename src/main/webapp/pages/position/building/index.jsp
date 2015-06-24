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
		grid_selector = "#buildingGrid";
		pager_selector = "#pagerNav";
		data_url = "${path}/position/building/getList.json";
		$(grid_selector).jqGrid({
			url : data_url,
			mtype:"post",
			datatype : "json",
			height : 320,
			colNames : [ '序号', '大楼名称', '区域', '详细地址'],
			colModel : [ {
				name : 'uuid',
				index : 'uuid',
				width : '20%',
				align : 'center',
				hidden: true
			}, {
				name : 'title',
				index : 'title',
				width : '20%',
				align : 'center',
				formatter:function(cellvalue, options, rowObject){
					 return "<a href='${path}/position/building/buildingView.vhtml?operateType=detail&uuid="+rowObject['uuid']+"' style='color:blue'>"+cellvalue+"</a>";
				}
			}, {
				name : 'region',
				index : 'region',
				width : '10%',
				align : "center",
			}, {
				name : 'address',
				index : 'address',
				width : '35%',
				align : "left",
				sortable : false
			}],
			viewrecords : true,
			rowNum : 10,
			rowList : [ 10, 20, 30 ],
			pager : pager_selector,
			altRows : true,
			multiselect: true,
			multiboxonly: false,
			caption : "",
			autowidth : true
		}).navGrid(
				'#pagerNav',
				{
					add : true,
					addtext : '新增',
					addfunc : function() {
							window.location.href="${path}/position/building/buildingView.vhtml?operateType=add";
					},
					edit : true,
					edittext : '修改',
					editfunc : function(rowid) {
						var rowIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
						if(rowIds.length>1){
							$("#messageInfo").text("不能同时修改多条办公室信息");
							$("#messageDiv").modal('show');
							}
						if(rowIds.length==1){
							var data = jQuery(grid_selector).jqGrid('getRowData',
									rowid);
							if(data!=null){
								window.location.href="${path}/position/building/buildingView.vhtml?operateType=update&uuid="
									+ data.uuid;

							}
						}
					},
					del : true,
					deltext:"删除",
					delfunc : function(rowid) {
						var rowIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
						var data = jQuery(grid_selector).jqGrid('getRowData',rowid);
						if(rowIds.length==1){
							$("#delBuilding").html("确定删除选中的办公楼   "+data.title+" 吗？");
						}else if (rowIds.length>1){
							$("#delBuilding").html("确定批量删除选中的办公楼信息吗？");
						}
						$("#delBuildingDiv").modal('show');
					},
					refresh : true,
					alerttext : "请选择一条办公楼信息"
				});
		$("#delBtn").click(function(){
			var rowIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
			var selectedId = jQuery(grid_selector).jqGrid("getGridParam","selrow");
			var url = "";
			if(rowIds.length==1){
				var data = jQuery(grid_selector).jqGrid('getRowData',selectedId);
				url = '${path}/position/building/delete.action?uuid='+data.uuid+'&rand='+new Date().toLocaleTimeString();
			}else if(rowIds.length>=1){
				var uuids = "";
				for(var index in rowIds){
					uuids=uuids+jQuery(grid_selector).jqGrid('getRowData',rowIds[index]).uuid+",";
				}
				url = '${path}/position/building/batchDelete.action?uuids='+uuids+'&rand='+new Date().toLocaleTimeString();
			}
			$.ajax({
            'url': url,
            'type': 'get',
            'dataType': 'json',
            success: function (data) {
            	 if (data.success) {
                     alert("删除成功!");
                     $("#delBuildingDiv").modal('hide');
                     $(grid_selector).jqGrid().trigger("reloadGrid");
                 } else {
                     alert("删除失败！");
                     $("#delBuildingDiv").modal('hide');
                 }
            }
			});
	});
		function genderFmatter(obj) {
			if (obj == "MALE") {
				return "男";
			} else {
				return "女";
			}
		}
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
		$(grid_selector).jqGrid('setGridParam', {postData: {building_title: $("#_title").val()}}).trigger("reloadGrid");
	}
</script>
</head>
<body>
	<div>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">办公楼列表</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form">
					<div class="form-group col-xs-5">
						<label for="" class="control-label col-xs-4">办公楼名称</label>
						<div class="col-xs-8">
							<input type="text" class="form-control input-sm" id="_title" name="building_title"
								placeholder="">
						</div>
					</div>
					<div class="form-group col-xs-2 text-right">
						<button type="button" class="btn btn-default btn-sm" onclick="toSearch();">查询</button>
					</div>
				</form>
			</div>
		</div>

		<table id="buildingGrid"></table>
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
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="delOfficeBtn">确定</button>
         </div>
        </div>
    </div>
</div>
	<!-- 新增 -->
<div class="modal fade" id="buildingInfoDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" data-backdrop="static"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="buildingInfoDiv_content">
            
        </div>
    </div>
</div>
<div class="modal fade" id="delBuildingDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="delBuildingDiv_content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h2 style="font-weight:bolder;">
               	删除办公楼信息
            </h2>
         </div>
         <div class="modal-body text-center">
            	<span id="delBuilding" style="color:blue;font-size:16px;"></span>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default"
               data-dismiss="modal">取消
            </button>
            <button type="button" class="btn btn-primary" id="delBtn">确定</button>
         </div>
        </div>
    </div>
</div>
</body>
</html>