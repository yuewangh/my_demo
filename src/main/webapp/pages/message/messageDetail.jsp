<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<head>
</head>
<body>
<div class="modal-header">
    <h4 class="modal-title">${message.title }</h4>
</div>
<div class="modal-body">
       <div class="form-group">
          	${message.content }
       </div>
<div class="" style="margin-left:400px;margin-top:400px;">
    <button type="button" class="btn btn-default" onclick="javascript:history.go(-1)">返回</button>
</div>
    </div>
 </body>
