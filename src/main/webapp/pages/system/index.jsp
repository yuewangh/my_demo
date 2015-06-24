<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>

</head>
<body>
<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">会议列表</div>
    <div class="panel-body">
        <form class="form-horizontal" role="form">
            <div class="form-group col-xs-5">
                <label for="" class="control-label col-xs-4">会议编号</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control input-sm" id="" placeholder="">
                </div>
            </div>
            <div class="form-group col-xs-5">
                <label for="" class="control-label col-xs-4">会议名称</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control input-sm" id="" placeholder="">
                </div>
            </div>
            <div class="form-group col-xs-5">
                <label for="" class="control-label col-xs-4">会议状态</label>
                <div class="col-xs-8">
                    <select id="" class="form-control input-sm">
                        <option>未发布</option>
                        <option>已结束</option>
                        <option>进行中</option>
                    </select>
                </div>
            </div>
            <div class="form-group col-xs-5">
                <label for="" class="control-label col-xs-4">会议日期</label>
                <div class="col-xs-8 pr0">
                    <input type="text" class="form-control w4 input-sm" id="" placeholder="">
                    <span class="w1 text-center">至</span>
                    <input type="text" class="form-control w4 input-sm" id="" placeholder="">
                </div>
            </div>
            <div class="form-group col-xs-2 text-right">
                <button type="submit" class="btn btn-default btn-sm">查询</button>
            </div>
        </form>
    </div>
</div>
<table></table>
<div></div>
</body>
</html>