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
    	grid_selector = "#userGrid";
    	pager_selector = "#pagerNav";
    	data_url = "${path}/order/reservation/getList.json";
    	$(grid_selector).jqGrid({
    		url: data_url,
            datatype: "json",
            height: 220,
            colNames: [ 'uuid','预订号', '申请人','办公楼', '办公室/桌','编号', '开始日期', '结束日期', '是否成交', '订单总额（元）'],
            colModel: [
                {name: 'uuid', index: 'uuid',hidden: true},
                {name: 'reservationNum', index: 'reservationNum', width: 150,
                	formatter:function(cellvalue, options, rowObject){
   					 return "<a href='${path}/order/reservation/getDetail.vhtml?uuid="+rowObject['uuid']+"' style='color:blue'>"+cellvalue+"</a>";
   					}	
                },
                {name: 'user.name', index: 'user.name', width: 80,align:"center"},
                {name: 'building.title', index: 'building.title', width: 200},
                {name: 'office.type', index: 'office.type', width: 70,align:"center",
                	formatter:function(status){
						if(status=="1"){
							return "办公室";
						}else{
							return "办公桌";
						}
					}
                },
                {name: 'office.code', index: 'office.code', width: 100},
                {name: 'startDate', index: 'startDate', width: 80},
                {name: 'endDate', index: 'endDate', width: 80},
                {name: 'ableState', index: 'ableState', width: 60,align:"center",
                	formatter:function(status){
						if(status=="2"){
							return "已成交";
						}else{
							return "未成交";
						}
					}
                },
                {name: 'totalPrice', index: 'totalPrice', width: 100,align:"center"}
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
    		edit:false,
    		edittext:'修改',
    		editfunc:function(rowid){
    			var data = jQuery(grid_selector).jqGrid('getRowData', rowid);
    			 $("#userInfoDiv_content").load("${path}/order/reservation/toedit.action?uuid=" + data.uuid, function () {
    	             $("#userInfoDiv").modal('show');
    	         });
    		},
    		del:true,
    		deltext:'删除',
    		delfunc: deleteChartInfoBox,search : false,
    		refresh : false
    	}).navButtonAdd(pager_selector,{
    			caption:"成交",
    			title:"成交",
    			onClickButton:function(){
    				var ids = $(grid_selector).jqGrid('getGridParam','selrow');
    				if(ids == null){
    					alert("请选择数据行");
    					return;
    				}
    				var data = jQuery(grid_selector).jqGrid('getRowData',ids);
    				if(data.ableState == '已成交'){
    					alert("此订单已经成交！");
    					return false;
    				}
    				$("#userInfoDiv_content").load("${path}/order/reservation/toFinal.action?uuid=" + data.uuid+"&money="+data.totalPrice, function () {
    	                $("#userInfoDiv").modal('show');
    	            });
    			}
    		}); 
    	
    	function deleteChartInfoBox(rowid){
    		var data = jQuery(grid_selector).jqGrid('getRowData', rowid);
    		if(confirm("您确认要删除此订单吗？")){
				$.post("${path}/order/reservation/delete.json", {
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
			reservationNum: $("#reservationNum").val(),
			applicant_uuid:$("#applicant_uuid").val(),
			building_uuid:$("#building_uuid").val(),
			office_uuid:$("#office_uuid").val()
		}}).trigger("reloadGrid");
	}
    function getOffices(){
    	var building_uuid=$("#building_uuid").val();
    	$("#office_uuid option").remove();
    	$("#office_uuid").append("<option value=''>全部</option>");
    	if(building_uuid != ""){
    		$.post("${path}/position/office/getOfficeByBuilding.json", {
    			"building_uuid" : building_uuid
    		}, function(data) {
    			for(var i=0;i<data.length;i++){
    				$("#office_uuid").append("<option value='"+data[i].uuid+"'>"+data[i].code+"</option>");
    			}
    		});
    	}
    }
    </script>
</head>
<body>
<div>
                    <div class="panel panel-default">
                        <!-- Default panel contents -->
                        <div class="panel-heading">未成交预订单列表</div>
                        <div class="panel-body">
                            <form class="form-horizontal" role="form">
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">预订号</label>
                                    <div class="col-xs-8">
                                        <input type="text" class="form-control input-sm" id="reservationNum" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">申请者</label>
                                    <div class="col-xs-8">
                                        <input type="text" class="form-control input-sm" id="applicant_uuid" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">办公楼</label>
                                    <div class="col-xs-8">
                                        <select id="building_uuid" class="form-control input-sm" onchange="getOffices()">
                                            <option value="">全部</option>
                                    	 	<c:forEach items="${buildinglist}" var="building">
                                    	 		<option value="${building.uuid}">${building.title}</option>
                                    	 	</c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-xs-5">
                                    <label for="" class="control-label col-xs-4">办公室</label>
                                    <div class="col-xs-8">
                                        <select id="office_uuid" class="form-control input-sm">
                                            <option value="">全部</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-xs-2 text-center">
                                     <button type="button" class="btn btn-default btn-sm"  onclick="toSearch();">查询</button>
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