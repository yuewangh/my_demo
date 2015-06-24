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
    	grid_selector = "#userGrid";
    	pager_selector = "#pagerNav";
    	data_url = "${path}/system/account/list.json";
    	$(grid_selector).jqGrid({
    		url: data_url,
            datatype: "json",
            height: 320,
            colNames: [ 'uuid', '用户名', '姓名',
                '性别', '部门', '状态'],
            colModel: [
                {name: 'uuid', index: 'uuid', width: 60, hidden: true},
                {name: 'loginName', index: 'loginName', width: 90},
                {name: 'name', index: 'name', width: 50, sortable: false},
                {name: 'gender', index: 'gender', width: 50,formatter: genderFmatter,align:"center"},
                {name: 'dept', index: 'dept', width: 50},
                {name: 'survival', index: 'survival', width: 50,formatter: survivalFmatter}
                
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
    	}).navGrid('#pagerNav',{
    		add:true,
    		addtext:'新增',
    		addfunc:function(){
    			 $("#userInfoDiv_content").load("${path}/system/account/addView.action", function () {
    	                $("#userInfoDiv").modal('show');
    	            });
    		},
    		edit:true,
    		edittext:'修改',
    		editfunc:function(rowid){
    			var data = jQuery(grid_selector).jqGrid('getRowData', rowid);
    			 $("#userInfoDiv_content").load("${path}/system/account/updateView.action?uuid=" + data.uuid, function () {
    	                $("#userInfoDiv").modal('show');
    	            });
    		},
    		del:true,
    		deltext:'删除',
    		delfunc:function(rowid){
    			var ids = $(grid_selector).jqGrid('getGridParam','selrow');
    			if(ids.length > 1 || ids.length == 0 || typeof(ids) == "undefined"){
					alert("每次只能删除一个用户");
				}else{
					if(confirm("确定要删除选择的用户吗？")){
						var data = jQuery(grid_selector).jqGrid('getRowData',ids);
						$.ajax({
		                    'url': '${path}/system/account/delete.json',
		                    'type': 'get',
		                    'data': {
		                        uuid:data.uuid
		                    },
		                    'dataType': 'json',
		                    timeout: 6 * 1000,
		                    success: function (status) {
		                        if (status) {
		                            alert("删除成功!");
		                            toSearch();
		                        } else {
		                            alert("删除失败！");
		                        }

		                    }, beforeSubmit: function () {
		                    }
		                });
					}
				}
    			
    		},
    		refresh:false,
    		search:false,
    		//searchtext:"Find",
    		alerttext:"请选择一行需要操作的数据"
    		}).navButtonAdd(pager_selector,{
    			caption:"分配权限",
    			title:"分配角色权限",
    			onClickButton:function(){
    				var ids = $(grid_selector).jqGrid('getGridParam','selrow');
    				if(ids.length > 1 || ids.length == 0 || typeof(ids) == "undefined"){
    					alert("请选择一条记录进行权限分配操作");
    				}else{
    					var data = jQuery(grid_selector).jqGrid('getRowData',ids);
    					$("#userInfoDiv_content").load("${base}/system/account/showRole.action?uuid=" + data.uuid, function () {
	       	                $("#userInfoDiv").modal('show');
	       	            });
    				}
    			}
    		});  
    	
    	
    	function genderFmatter(obj){
    		if(obj == "MALE"){
    			return "男";
    		}else{
    			return "女";
    		}
    	}
    	function survivalFmatter(obj){
    		if("VERIFY" == obj){
    			return "待验证";
    		}else if("ENABLE" == obj){
    			return "可用";
    		}else{
    			return "不可用";
    		}
    	}
    });
    
    	function toSearch(){
    		$(grid_selector).jqGrid('setGridParam', {postData: {loginName: $("#_loginName").val(),name:$("#_name").val(),survival:$("#_survival").val(),gender:$("#_gender").val()}}).trigger("reloadGrid");
    	}
    </script>
</head>
<body>
<div>
                    <div class="panel panel-default">
                        <!-- Default panel contents -->
                        <div class="panel-heading">用户列表</div>
                        <div class="panel-body">
                            <form class="form-horizontal" role="form">
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">用户名</label>
                                    <div class="col-xs-8">
                                        <input type="text" class="form-control input-sm" id="_loginName" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">姓名</label>
                                    <div class="col-xs-8">
                                        <input type="text" class="form-control input-sm" id="_name" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">状态</label>
                                    <div class="col-xs-8">
                                        <select id="_survival" class="form-control input-sm">
                                            <option value="">全部</option>
                                            <option value="ENABLE">可用</option>
                                            <option value="DISABLE">不可用</option>
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
                        <table id="userGrid">
                        </table>
                        <div id="pagerNav"> 
                        </div>
              </div>
<!-- 新增 -->
<div class="modal fade" id="userInfoDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="userInfoDiv_content">
            
        </div>
    </div>
</div>

</body>
</html>