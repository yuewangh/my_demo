<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<html>
<head>
	<link rel="stylesheet" href="${base}/scripts/jqGrid/css/ui.jqgrid.me.css">
    <script src="${path}/scripts/jqGrid/js/i18n/grid.locale-cn.js" type="text/javascript"></script>
    <script src="${path}/scripts/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    $(function () {
    	grid_selector = "#roleGrid";
    	pager_selector = "#pagerNav";
    	data_url = "${path}/system/role/list.json";
    	$(grid_selector).jqGrid({
    		url: data_url,
            datatype: "json",
            height: 320,
            colNames: [ 'uuid', '角色编码', '角色名称',
                '状态', '角色描述'],
            colModel: [
                {name: 'uuid', index: 'uuid', width: 60, hidden: true},
                {name: 'key', index: 'key', width: 90},
                {name: 'name', index: 'name', width: 50, sortable: false},
                {name: 'survivalStatus', index: 'survivalStatus', width: 50,formatter: genderStatus,align:"center"},
                {name: 'description', description: 'description', width: 50}
                
            ],
            viewrecords: true,
            rowNum: 10,
            rowList: [10, 20, 30],
            pager: pager_selector,
            altRows: true,
            /* multiselect: true,
            multiboxonly: true, */
            caption: "",
            autowidth: true
    	}).navGrid(pager_selector,{
    		add:true,
    		addtext:'新增',
    		addfunc:function(){
    			 $("#roleInfoDiv_content").load("${path}/system/role/addOrUpdateView.action", function () {
    	                $("#roleInfoDiv").modal('show');
    	            });
    		},
    		edit:true,
    		edittext:'修改',
    		editfunc:function(rowid){
    			var data = jQuery(grid_selector).jqGrid('getRowData', rowid);
    			 $("#roleInfoDiv_content").load("${path}/system/role/addOrUpdateView.action?uuid=" + data.uuid, function () {
    	                $("#roleInfoDiv").modal('show');
    	            });
    		},
    		del:true,
    		deltext:'删除',
    		delfunc:function(rowid){
    			var data = jQuery(grid_selector).jqGrid('getRowData', rowid);
    			$.ajax({
                    'url': '${path}/system/role/delete.json',
                    'type': 'post',
                    'data': {
                        ids:data.uuid
                    },
                    'dataType': 'json',
                    timeout: 6 * 1000,
                    success: function (status) {
                        alert(status.msg);
                        if(status.success){
                        	toSearch();
                        }
                    }, beforeSubmit: function () {
                    }
                });
    		},
    		refresh:false,
    		search:false,
    		searchtext:"Find",
    		alerttext:"请选择一行需要操作的数据"
    		}).navButtonAdd(pager_selector,{
    			caption:"分配权限",
    			title:"分配资源权限",
    			onClickButton:function(){
    				var ids = $(grid_selector).jqGrid('getGridParam','selrow');
    				if(ids.length > 1 || ids.length == 0 || typeof(ids) == "undefined"){
    					alert("请选择一条记录进行权限分配操作");
    				}else{
    					var data = jQuery(grid_selector).jqGrid('getRowData',ids);
    					$("#roleInfoDiv_content").load("${path}/system/role/assignView.action?uuid=" + data.uuid, function () {
	       	                $("#roleInfoDiv").modal('show');
	       	            });
    				}
    				
       			 	
    			}
    		}); 
    	
    	
    	function genderStatus(obj){
    		if(obj){
    			return "有效";
    		}else{
    			return "无效";
    		}
    	}
    });
    
    	function toSearch(){
    		$(grid_selector).jqGrid('setGridParam', {postData: {key: $("#_key").val(),name:$("#_name").val(),survivalStr:$("#_survival").val()}}).trigger("reloadGrid");
    	}
    </script>
</head>
<body>
<div>
                    <div class="panel panel-default">
                        <!-- Default panel contents -->
                        <div class="panel-heading">角色列表</div>
                        <div class="panel-body">
                            <form class="form-horizontal" role="form">
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">角色编码</label>
                                    <div class="col-xs-8">
                                        <input type="text" class="form-control input-sm" id="_key" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">角色名称</label>
                                    <div class="col-xs-8">
                                        <input type="text" class="form-control input-sm" id="_name" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">状态</label>
                                    <div class="col-xs-8">
                                        <select id="_survival" class="form-control input-sm">
                                            <option value="">全部</option>
                                            <option value="true">有效</option>
                                            <option value="false">无效</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-xs-5 text-right">
                                    <button type="button" class="btn btn-default btn-sm" onclick="toSearch();">查询</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                        <!-- Table -->
                        <table id="roleGrid">
                        </table>
                        <div id="pagerNav"> 
                        </div>
              </div>
<!-- 新增 -->
<div class="modal fade" id="roleInfoDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="roleInfoDiv_content">
            
        </div>
    </div>
</div>

</body>
</html>