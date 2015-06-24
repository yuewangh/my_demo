<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<html>
<head>
	<link rel="stylesheet" href="${base}/scripts/jqGrid/css/ui.jqgrid.me.css">
    <script src="${path}/scripts/jqGrid/js/i18n/grid.locale-cn.js" type="text/javascript"></script>
    <script src="${path}/scripts/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${path}/scripts/My97DatePicker/WdatePicker.js" ></script>
    <script type="text/javascript">
    $(function () {
    	grid_selector = "#infoGrid";
    	pager_selector = "#pagerNav";
    	data_url = "${path}/activity/manager/list.json";
    	$(grid_selector).jqGrid({
    		url: data_url,
            datatype: "json",
            height: 320,
            colNames: [ 'uuid', '活动标题', '活动时间',
                '活动地点','创建时间'],
            colModel: [
                {name: 'uuid', index: 'uuid', width: 60, hidden: true},
                {name: 'title', index: 'title', width: 90,formatter: function(cellvalue, options, rowObject){
					 return "<a href=\"javaScript:toShowDetail('"+rowObject['uuid']+"');\" style=\"color:blue;\">"+cellvalue+"</a>";
				}},
                {name: 'activityDateStr', index: 'activityDate', width: 50, sortable: true},
                {name: 'activityAddress', index: 'activityAddress',sortable:false},
                {name: 'createDateStr', index: 'createDate', width: 50,sortable:true}
            ],
            viewrecords: true,
            rowNum: 10,
            rowList: [10, 20, 30],
            pager: pager_selector,
            altRows: true,
            /* multiselect: false,
            multiboxonly: false, */
            caption: "",
            autowidth: true
    	}).navGrid('#pagerNav',{
    		add:true,
    		addtext:'新增',
    		addfunc:function(){
    			 $("#_infoDiv_content").load("${path}/activity/manager/addView.action", function () {
    	                $("#_infoDiv").modal('show');
    	            });
    		},
    		edit:true,
    		edittext:'修改',
    		editfunc:function(rowid){
    			var data = jQuery(grid_selector).jqGrid('getRowData', rowid);
    			 $("#_infoDiv_content").load("${path}/activity/manager/updateView.action?uuid=" + data.uuid, function () {
    	                $("#_infoDiv").modal('show');
    	            });
    		},
    		del:true,
    		deltext:'删除',
    		delfunc:function(rowid){
    			var ids = $(grid_selector).jqGrid('getGridParam','selrow');
    			if(ids.length > 1 || ids.length == 0 || typeof(ids) == "undefined"){
					alert("每次只能删除一个活动");
				}else{
					if(confirm("确定要删除选择的活动吗？")){
						var data = jQuery(grid_selector).jqGrid('getRowData',ids);
						$.ajax({
		                    'url': '${path}/activity/manager/delete.json',
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
    		});  
    	
    });
    
    	function toSearch(){
    		$(grid_selector).jqGrid('setGridParam', {postData: {title: $("#_title").val()}}).trigger("reloadGrid");
    	}
    	
    	function toShowDetail(uuid){
    		$("#_infoDiv_content").load("${path}/activity/manager/showDetail.action?uuid="+uuid, function () {
                $("#_infoDiv").modal('show');
            });
    	}
    </script>
</head>
<body>
<div>
                    <div class="panel panel-default">
                        <!-- Default panel contents -->
                        <div class="panel-heading">活动列表</div>
                        <div class="panel-body">
                            <form class="form-horizontal" role="form">
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">标题</label>
                                    <div class="col-xs-8">
                                        <input type="text" class="form-control input-sm" id="_title" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group col-xs-5 text-right">
                                    <button type="button" class="btn btn-default btn-sm" onclick="toSearch();">查询</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                        <!-- Table -->
                        <table id="infoGrid">
                        </table>
                        <div id="pagerNav"> 
                        </div>
              </div>
<!-- 新增 -->
<div class="modal fade" id="_infoDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" style="width:1000px;">
        <div class="modal-content" id="_infoDiv_content">
            
        </div>
    </div>
</div>

</body>
</html>