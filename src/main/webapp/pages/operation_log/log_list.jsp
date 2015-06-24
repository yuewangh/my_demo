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
    	data_url = "${path}/system/operation_log/getList.json";
    	$(grid_selector).jqGrid({
    		url: data_url,
            datatype: "json",
            height: 220,
            colNames: [ 'uuid', '操作模块', '操作用户','用户姓名', '用户IP', '操作日期', '操作描述','成功/失败','失败原因'],
            colModel: [
                {name: 'uuid', index: 'uuid', width: 60, hidden: true},
                {name: 'modname', index: 'modname', width: 80},
                {name: 'loginname', index: 'loginname', width: 40, sortable: false},
                {name: 'fullname', index: 'fullname', width: 40},
                {name: 'userip', index: 'userip', width: 50},
                {name: 'operdatestr', index: 'operdate', width: 50},
                {name: 'content', index: 'content', width: 60},
                {name: 'successed', index: 'successed', width: 40,formatter: successedFmatter},
                {name: 'cause', index: 'cause', width: 40,formatter: causeFmatter}
                
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
    		del:false
    		}); 
    	
    	function causeFmatter(obj){
    		if(obj != null && obj != ""){
    			return "<a href=\"javascript:;\" onclick=\"getDetail('"+obj+"')\" title='点击查看原因'>查看</a>"
    		} else {
    			return "";
    		}
    		
    	}
    	function successedFmatter(obj){
    		if("SUCCESSED" == obj){
    			return "成功";
    		}else if("FAILED" == obj){
    			return "失败";
    		}
    	}
    });
    function getDetail(obj){
    	 $("#userInfoDiv_content").html(obj);
         $("#userInfoDiv").modal('show');
    }
    function toSearch(){
		$(grid_selector).jqGrid('setGridParam', {postData: {
			startDate: $("#startDate").val(),
			endDate:$("#endDate").val(),
			modname:$("#modname").val(),
			name:$("#name").val()
		}}).trigger("reloadGrid");
	}
    </script>
</head>
<body>
<div>
                    <div class="panel panel-default">
                        <!-- Default panel contents -->
                        <div class="panel-heading">操作日志列表</div>
                        <div class="panel-body">
                            <form class="form-horizontal" role="form">
                                <div class="form-group col-xs-6">
                                    <label for="" class="control-label col-xs-3">操作模块</label>
                                    <div class="col-xs-9">
                                          <select id="modname" class="form-control input-sm" onchange="getOffices()">
                                            <option value="">全部</option> 
                                    	 	<c:forEach items="${maplist}" var="mode">
                                    	 		<option value="${mode.id}">${mode.name}</option>
                                    	 	</c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-xs-6">
                                    <label for="" class="control-label col-xs-4">操作用户</label>
                                    <div class="col-xs-8">
                                        <input type="text" class="form-control input-sm" id="name" placeholder="请输入操作用户或用户姓名">
                                    </div>
                                </div>
                                <div class="form-group col-xs-6">
                                    <label for="" class="control-label col-xs-3">操作日期</label>
                                    <div class="col-xs-9">
                                    	<input id="startDate" class="form-control w4" type="text" value="${nowday}" onFocus="var endDate=$dp.$('endDate');WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){endDate.focus();},maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:true})"/>
                                        <span class="w1 text-center">至</span>
                                       <input id="endDate" class="form-control w4" type="text" value="${nowday}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:true})"/>
                                    </div>
                                </div>
                                <div class="form-group col-xs-6 text-center">
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
<!--失败原因-->
<div class="modal fade" id="userInfoDiv" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" id="userInfoDiv_content" style="min-height: 100px">
            
        </div>
    </div>
</div>

</body>
</html>