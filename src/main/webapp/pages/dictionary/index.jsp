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
		grid_selector = "#systemParameterGrid";
		pager_selector = "#pagerNav";
		data_url = "${path}/dictionary/getList.json?duId=${dictionaryUnit.uuid}";
		addFlag = false;
		deleteFlag=false;
		if('SYSTEM.INDEX.BANNER'=='${dictionaryUnit.paramKey}'){
			addFlag=true;
			deleteFlag=true;
		}
		$(grid_selector).jqGrid({
			url : data_url,
			mtype:"post",
			datatype : "json",
			height : 320,
			colNames : [ 'UUID','DUID', '参数编码', '参数名称', '参数值','参数类型','参数摘要'],
			colModel : [ {
				name : 'uuid',
				index : 'uuid',
				width : '20%',
				align : 'center',
				hidden: true
			},  {
				name : 'duId',
				index : 'duId',
				width : '20%',
				align : 'center',
				hidden: true
			}, {
				name : 'paramKey',
				index : 'paramKey',
				width : '15%',
				align : 'center',
				sortable : true
			},
			{
				name : 'paramName',
				index : 'paramName',
				width : '30%',
				align : 'center',
				formatter:function(cellvalue, options, rowObject){
					 return "<a href='${path}/dictionary/systemParameterView.vhtml?operateType=detail&uuid="+rowObject['uuid']+"' style='color:blue'>"+cellvalue+"</a>";
				}
			},
			{
				name : 'paramVal',
				index : 'paramVal',
				width : '10%',
				align : "center",
				hidden: true,
				sortable : false
			},
			{
				name : 'paramType',
				index : 'paramType',
				width : '10%',
				align : "center",
				sortable : false
			},
			{
				name : 'paramSummary',
				index :'paramSummary',
				width : '30%',
				align : "left",
				hidden: true,
			}],
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
					add : addFlag,
					addtext : '新增',
					addfunc : function() {
							window.location.href="${path}/dictionary/systemParameterView.vhtml?operateType=add&duId=${dictionaryUnit.uuid}";
					},
					edit : true,
					edittext : '修改',
					editfunc : function(rowid) {
						var ids=$(grid_selector).jqGrid('getGridParam','selarrrow');
						if(ids.length>1){
							$("#messageInfo").text("不能同时修改多条参数信息");
							$("#messageDiv").modal('show');
							}
						if(ids.length==1){
							var data = jQuery(grid_selector).jqGrid('getRowData',
									rowid);
							if(data!=null){
								window.location.href="${path}/dictionary/systemParameterView.vhtml?operateType=update&uuid="
									+ data.uuid;

							}
						}
					},
					del : deleteFlag,
					deltext:"删除",
					delfunc : function(rowid) {
						var rowIds=jQuery(grid_selector).jqGrid('getGridParam','selarrrow');
						if(rowIds.length==1){
						var data = jQuery(grid_selector).jqGrid('getRowData',rowid);
							$("#delSystemParameter").html("确定删除选中的参数 "+data.paramName+" 吗？");
						}else if (rowIds.length>1){
							$("#delSystemParameter").html("确定批量删除选中的参数信息吗？");
						}
						$("#delSystemParameterDiv").modal('show');
					},
					refresh : true,
					alerttext : "请选择一条参数信息"
				});
		//绑定删除事件
		$("#delSystemParameterBtn").click(function(){
			var rowIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
			var selectedId = jQuery(grid_selector).jqGrid("getGridParam","selrow");
			var url = "";
			var uuids = "";
			var duId = "";
			for(var index in rowIds){
				uuids=uuids+jQuery(grid_selector).jqGrid('getRowData',rowIds[index]).uuid+",";
				duId = jQuery(grid_selector).jqGrid('getRowData',rowIds[index]).duId;
			}
				url = '${path}/dictionary/delete.action?idStr='+uuids+'&did='+duId+'&rand='+new Date().toLocaleTimeString();
			$.ajax({
            'url': url,
            'dataType': 'json',
            timeout: 6 * 1000,
            success: function (data) {
                if (data.success) {
                    alert("删除成功!");
                    $("#delSystemParameterDiv").modal('hide');
                    $(grid_selector).jqGrid().trigger("reloadGrid");
                } else {
                    alert("删除失败！");
                    $("#delSystemParameterDiv").modal('hide');
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
		$(grid_selector).jqGrid('setGridParam', {postData: {paramKey: $("#paramKey").val(),paramName: $("#paramName").val()}}).trigger("reloadGrid");
	}
</script>
</head>
<body>
	<div>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">${dictionaryUnit.paramName}参数</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form">
				<input style="display:none" class="form-control input-sm" id="duId" name="duId"/>
				<div class="form-group col-xs-5">
						<label for="" class="control-label col-xs-4">参数编号</label>
						<div class="col-xs-8">
							<input type="text" class="form-control input-sm" id="paramKey" name="paramKey"
								placeholder="">
						</div>
					</div>
					<div class="form-group col-xs-5">
						<label for="" class="control-label col-xs-4">参数名称</label>
						<div class="col-xs-8">
							<input type="text" class="form-control input-sm" id="paramName" name="paramName"
								placeholder="">
						</div>
					</div>
					<div class="form-group col-xs-2 text-right">
						<button type="button" class="btn btn-default btn-sm" onclick="toSearch();">查询</button>
					</div>
				</form>
			</div>
		</div>

		<table id="systemParameterGrid"></table>
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
<div class="modal fade" id="systemParameterInfoDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" data-backdrop="static"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="systemParameterInfoDiv_content">
            
        </div>
    </div>
</div>
<div class="modal fade" id="delSystemParameterDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="delSystemParameterDiv_content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h2 style="font-weight:bolder;">
               	删除参数信息
            </h2>
         </div>
         <div class="modal-body text-center">
             <span id="delSystemParameter" style="color:blue;font-size:16px;"></span>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default"
               data-dismiss="modal">取消
            </button>
            <button type="button" class="btn btn-primary" id="delSystemParameterBtn">确定</button>
         </div>
        </div>
    </div>
</div>
</body>
</html>