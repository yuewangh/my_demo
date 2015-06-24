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
		grid_selector = "#messageGrid";
		pager_selector = "#pagerNav";
		data_url = "${path}/system/message/getList.json";
		$(grid_selector).jqGrid({
			url : data_url,
			mtype:"post",
			datatype : "json",
			height : 320,
			colNames : ['UUID', '通知标题', '发送者', '发送者UUID','状态','发布时间'],
			colModel : [ {
				name : 'uuid',
				index : 'uuid',
				width : '5%',
				align : 'center',
				sortable : false,
				hidden:true
			},{
				name : 'title',
				index : 'title',
				width : '40%',
				align : 'left',
				formatter:function(cellvalue, options, rowObject){
					 return "<a href='${path}/system/message/messageView.vhtml?operateType=detail&uuid="+rowObject['uuid']+"' style='color:blue'>"+cellvalue+"</a>";
				}
			}, {
				name : 'fromName',
				index : 'fromName',
				width : '10%',
				align : "center"
			}, {
				name : 'fromUuid',
				index : 'fromUuid',
				width : '10%',
				align : "left",
				hidden:true,
				sortable : false
			},{
				name : 'status',
				index : 'status',
				width : '10%',
				align : "center",
				formatter:function(status){
					if(status=="1"){
						return "显示";
					}if(status=="0"){
						return "隐藏";
					}else{
						return "隐藏";
					}
				}
			},{
				name : 'createTime',
				index : 'createTime',
				width : '20%',
				align : "center",
				formatter:function(cellvalue, options, rowObject){
					     createTime = new Date(cellvalue).toLocaleString();
					     return createTime;
				}
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
					add : true,
					addtext : '新增',
					addfunc : function() {
							window.location.href="${path}/system/message/messageView.vhtml?operateType=add";
					},
					edit : true,
					edittext : '修改',
					editfunc : function(rowid) {
						var data = jQuery(grid_selector).jqGrid('getRowData',
								rowid);
						if(data!=null){
							window.location.href="${path}/system/message/messageView.vhtml?operateType=update&uuid="
								+ data.uuid;

						}
					},
					del : true,
					deltext:"删除",
					delfunc : function(rowid) {
						var rowIds=jQuery(grid_selector).jqGrid('getGridParam','selarrrow');
						if(rowIds.length==1){
						var data = jQuery(grid_selector).jqGrid('getRowData',rowid);
							$("#delMessage").html("确定删除选中的办公桌   "+data.title+" 吗？");
						}else if (rowIds.length>1){
							$("#delMessage").html("确定批量删除选中的办公桌信息吗？");
						}
						$("#delMessageDiv").modal('show');
					},
					refresh : true,
					alerttext : "请选择一行需要操作的数据"
				});
		$("#delBtn").click(function(){
			var rowIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
			var selectedId = jQuery(grid_selector).jqGrid("getGridParam","selrow");
			var url = "";
			if(rowIds.length==1){
				var data = jQuery(grid_selector).jqGrid('getRowData',selectedId);
			}else if(rowIds.length>=1){
				var uuids = "";
				for(var index in rowIds){
					uuids=uuids+jQuery(grid_selector).jqGrid('getRowData',rowIds[index]).uuid+",";
				}
			}
			$.ajax({
            'url': '${path}/system/message/delete.action?uuidStr='+uuids+'&rand='+new Date().toLocaleTimeString(),
            'type': 'get',
            'dataType': 'json',
            success: function (data) {
                if (data.success) {
                    $("#delMessageDiv").modal('hide');
                    alert("删除成功!");
                    $(grid_selector).jqGrid().trigger("reloadGrid");
                } else {
                    $("#delMessageDiv").modal('hide');
                    alert("删除失败！");
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
		$(grid_selector).jqGrid('setGridParam', {postData: {title: $("#title").val(),beginTime: $("#beginTime").val(),endTime: $("#endTime").val()}}).trigger("reloadGrid");
	}
</script>
</head>
<body>
	<div>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">通知公告列表</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form">
					<div class="form-group col-xs-5">
						<label for="" class="control-label col-xs-3">标题</label>
						<div class="col-xs-8">
							<input type="text" class="form-control input " id="title" name="title"
								placeholder="">
						</div>
					</div>
					 <div class="form-group col-xs-6">
                                    <label for="" class="control-label col-xs-4">发布日期</label>
                                     <div class="col-xs-8 pr0">
                                    	<input id="beginTime" class="form-control w4" type="text" onFocus="var endTime=$dp.$('endTime');WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){endTime.focus();},maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})"/>
                                        <span class="w1 text-center">至</span>
                                       <input id="endTime" class="form-control w4" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'beginTime\')}',readOnly:true})"/>
                                    </div>
                                </div>
					<div class="form-group col-xs-2 text-right">
						<button type="button" class="btn btn-default btn-sm" onclick="toSearch();">查询</button>
					</div>
				</form>
			</div>
		</div>

		<table id="messageGrid"></table>
		<div id="pagerNav"></div>
	</div>
	
	<!-- 新增 -->
<div class="modal fade" id="messageInfoDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" data-backdrop="static"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="messageDiv_content">
            
        </div>
    </div>
</div>
<div class="modal fade" id="delMessageDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="delMessageDiv_content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h2 style="font-weight:bolder;">
               	删除通知公告信息
            </h2>
         </div>
         <div class="modal-body">
              <span id="delMessage" style="color:blue;font-size:16px;"></span>
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