<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<html>
<head>
	<link rel="stylesheet" href="${base}/scripts/jqGrid/css/ui.jqgrid.me.css">
    <script src="${path}/scripts/jqGrid/js/i18n/grid.locale-cn.js" type="text/javascript"></script>
    <script src="${path}/scripts/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
    <script src="${path}/scripts/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
    $(function () {
    	grid_selector = "#oppointment";
    	pager_selector = "#pagerNav";
    	data_url = "${path}/order/appointment/getList.json";
    	$(grid_selector).jqGrid({
    		url: data_url,
            datatype: "json",
            height: 168,
            colNames: [ 'uuid', '预约号', '办公楼', '申请人', '联系电话', '参观日期', '参观时间', '来访人数'],
            colModel: [
                {name: 'uuid', index: 'uuid', width: 60, hidden: true},
                {name: 'appointmentNum', index: 'appointmentNum', width: 80,
                	formatter:function(cellvalue, options, rowObject){
   					 return "<a href='${path}/order/appointment/getDetail.vhtml?uuid="+rowObject['uuid']+"' style='color:blue'>"+cellvalue+"</a>";
   					}	
                },
                {name: 'building.title', index: 'building.title', width: 90},
                {name: 'applicantName', index: 'applicantName', width: 40},
                {name: 'telphone', index: 'telphone', width: 60},
                {name: 'visitDate', index: 'visitDate', width: 50},
                {name: 'visitTimestr', index: 'visitTime', width:40},
                {name: 'vistorNum', index: 'vistorNum', width: 40,align:"center"}
            ],
            viewrecords: true,
            rowNum: 10,
            rowList: [10, 20, 30],
            pager: pager_selector,
            altRows: true,
//                multiselect: true,
//                multiboxonly: true,
            caption: "",
            autowidth: true
    	}).navGrid('#pagerNav',{
    		add:false,
    		edit:true,
    		edittext:'修改',
    		editfunc:function(rowid){
    			var data = jQuery(grid_selector).jqGrid('getRowData', rowid);
    			 $("#userInfoDiv_content").load("${path}/order/appointment/toedit.action?uuid=" + data.uuid, function () {
    	                $("#userInfoDiv").modal('show');
    	            });
    		},
    		del:true,
    		deltext:'删除',
    		delfunc: deleteChartInfoBox,search : false,refresh : false}); 
    	
    	function deleteChartInfoBox(rowid){
    		var data = jQuery(grid_selector).jqGrid('getRowData', rowid);
    		if(confirm("您确认要删除此预约单吗？")){
				$.post("${path}/order/appointment/delete.json", {
					"id" : data.uuid
				}, function(data) {
					if(data.success){
						alert("删除成功！");
						jQuery(grid_selector).jqGrid().trigger("reloadGrid");
					}
				});
			}
    	}
    });
    function toSearch(){
		$(grid_selector).jqGrid('setGridParam', {postData: {
			buildingUuid: $("#buildingUuid").val(),
			applicantName:$("#applicantName").val(),
			visitDate_begin:$("#visitDate_begin").val(),
			visitDate_end:$("#visitDate_end").val(),
			createTime_begin:$("#createTime_begin").val(),
			createTime_end:$("#createTime_end").val(),
			company:$("#company").val()
		}}).trigger("reloadGrid");
	}
    </script>
</head>
<body>
<div>
                    <div class="panel panel-default">
                        <!-- Default panel contents -->
                        <div class="panel-heading">预约单列表</div>
                        <div class="panel-body">
                            <form class="form-horizontal" role="form">
                                <div class="form-group col-xs-6">
                                    <label for="" class="control-label col-xs-4">办公楼</label>
                                    <div class="col-xs-8">
                                    	 <select name="buildingUuid" id="buildingUuid" class="form-control input-sm">
                                    	 	<option value="">全部</option>
                                    	 	<c:forEach items="${buildinglist}" var="building">
                                    	 		<option value="${building.uuid}">${building.title}</option>
                                    	 	</c:forEach>
                                        </select>
                                    </div>
                                </div>
                                 <div class="form-group col-xs-6">
                                    <label for="" class="control-label col-xs-4">申请人</label>
                                    <div class="col-xs-8">
                                        <input type="text" class="form-control input-sm" id="applicantName" name="applicantName" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group col-xs-6">
                                    <label for="" class="control-label col-xs-4">参观者公司</label>
                                    <div class="col-xs-8">
                                       <input type="text" class="form-control input-sm" id="company" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group col-xs-6">
                                    <label for="" class="control-label col-xs-4">参观日期</label>
                                    <div class="col-xs-8 pr0">
                                    	<input id="visitDate_begin" class="form-control w4" type="text" onFocus="var visitDate_end=$dp.$('visitDate_end');WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){visitDate_end.focus();},maxDate:'#F{$dp.$D(\'visitDate_end\')}',readOnly:true})"/>
                                        <span class="w1 text-center">至</span>
                                       <input id="visitDate_end" class="form-control w4" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'visitDate_begin\')}',readOnly:true})"/>
                                    </div>
                                </div>
                                <div class="form-group col-xs-6">
                                    <label for="" class="control-label col-xs-4">预约日期</label>
                                    <div class="col-xs-8 pr0">
                                    	<input id="createTime_begin" class="form-control w4" type="text" onFocus="var createTime_end=$dp.$('createTime_end');WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){createTime_end.focus();},maxDate:'#F{$dp.$D(\'createTime_end\')}',readOnly:true})"/>
                                        <span class="w1 text-center">至</span>
                                       <input id="createTime_end" class="form-control w4" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'createTime_begin\')}',readOnly:true})"/>
                                    </div>
                                </div>
                                <div class="form-group col-xs-6 text-center">
                                    <button type="button" class="btn btn-default btn-sm"  onclick="toSearch();">查询</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                        <!-- Table -->
                        <table id="oppointment">
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