<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>


<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">活动信息</h4>
</div>
<div class="modal-body">
    <form id="information_form" class=" form-horizontal" role="form" method="post">
	    <div class="modal-body row">
	        <div class="col-sm-12">
	            <div class="row">
	                <div class="col-sm-3 ">
	                    <span class="media-left ph">
	                        <img id="titleImageSrc" src="<c:if test="${information.pictureUrl == \"\"  || information == null}" var="flag">${base}/images/pictures.png</c:if><c:if test="${!flag }">${information.pictureUrl}</c:if>" alt="标题图片"
	                             style="width: 200px;height: auto;">
	                    </span>
	                </div>
	                <div class="col-sm-9">
	                    <div class="form-group has-feedback">
	                        <label class="col-sm-2 control-label no-padding-right">活动标题：</label>
	
	                        <div class="col-xs-10 col-sm-10">
	                            ${information.title}
	                        </div>
	                    </div>
	                    <div class="form-group has-feedback">
	                        <label class="col-sm-2 control-label no-padding-right">活动时间：</label>
	
	                        <div class="col-xs-7 col-sm-7">
	                            <fmt:formatDate value="${information.activityDate}" pattern="yyyy-MM-dd HH:mm"/>
			
	                        </div>
	                    </div>
	                    <div class="form-group has-feedback">
	                        <label class="col-sm-2 control-label no-padding-right">活动地点：</label>
	
	                        <div class="col-xs-7 col-sm-7">
	                            ${information.activityAddress}
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label no-padding-right">简介：</label>
	
	                        <div class="col-xs-10 col-sm-10">
	                        ${information.summary}
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="col-sm-12" style="padding-top: 20px;">
	                    ${information.content}
	                </div>
	            </div>
	        </div>
	    </div>
	</form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
</div>
