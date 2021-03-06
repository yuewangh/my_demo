<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp"%>
<head>
<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="${path}/scripts/My97DatePicker/WdatePicker.js" ></script>

<script type="text/javascript">
	$(function(){
		_form = $("#editDictionaryForm").validate();
		$("a[id^='smenu']").each(function () {
		    $(this).removeAttr("class");
		    var href = $(this).attr("href");
		    var ss = window.location.href;
		    var len = 5;
		    if(ss.indexOf("?")==-1){
		    	 $("#smenu0").attr("class", "active");
		    }
		    if("${path}" == ""){
		    	len = 4;
		    }
		    if(href.split("/").length < len){
		    	if (ss.indexOf(href.split("?")[1]) != -1) {
		            $(this).attr("class", "active");
		        }
		    }else{
		    	if (ss.indexOf(href.substr(href.lastIndexOf("/"),href.length)) != -1) {
		            $(this).attr("class", "active");
		        }
		    }
		});
	});
	function submitDictionary() {
        //if(_form.form()){
        	//var picture = $("#dictionaryImage").val();
			//if(picture!=null&&picture!=""){
				$("#editDictionaryForm").ajaxSubmit({
					dataType : "json",
	                success: function (data) {
	                	if(data.success){
	                	alert(data.opt+"参数信息成功！");
	                	window.location.href="${path}/dictionary/index.vhtml?duId=${systemParameter.duId }";
	                	}else{
	                		alert(data.opt+"参数信息失败！");
	                	}
	                }
	            });
			//}else{
				//alert("请上传参数图片");
				//return false;
			//}
       // }
    }
</script>
</head>
<body>
<div class="modal-header">
<c:if test="${systemParameter!=null}"><h2 class="modal-title">${systemParameter.paramName}</h2></c:if>
	<c:if test="${dictionaryUnit!=null}"><h2 class="modal-title">新增${dictionaryUnit.paramName }参数</h2></c:if>
</div>
<div class="modal-body">
<form id="editDictionaryForm" class="pagination_form form-horizontal" role="form" method="post"
      action="${path}/dictionary/saveOrUpdate.vhtml">
    	<input style="display:none" name="uuid" id="uuid" value="${systemParameter.uuid }"/>
   		<input style="display:none" name="duId" id="duId" value="${systemParameter.duId }"/>
   		<input style="display:none" name="paramType" id="type" value="${systemParameter.paramType }"/>
    <div class="panel">
        <!-- Default panel contents -->
        <div class="panel-body">
            <div class="row">
                       <c:choose>
                <c:when test="${dictionaryUnit.paramKey!='SYSTEM.INDEX.BANNER'}">
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><font style="color: red;">※</font>参数编码</label>

                        <div class="col-sm-8">
                        <c:choose>
                             <c:when test="${systemParameter.uuid==null}">
                                <input name="paramKey" 
                                             class="form-control" placeholder="参数编码"
                                             data-rule-required="true"
                                             data-msg-required="请录入参数编码。"
                                             data-rule-minlength="3"
                                             data-rule-Atoz="true"
                                             data-msg-minlength="参数编码最少为3个字符"
                                             maxlength="30"/>
<%--                                              data-rule-remote="${path}/dictionary/isNotExist.json" --%>
<!--                                              data-msg-remote="您输入的参数编码已经存在，请输入其它的编码。" -->
                           </c:when>
                            <c:otherwise>
                                <input name="paramKey" value="${systemParameter.paramKey }"
                                             class="form-control" readonly="true"/>
                           </c:otherwise>
                           </c:choose>
                            <span class="help-inline"></span>

                            <p class="help-block"></p>
                        </div>
                    </div>
                </c:when>
              	<c:otherwise>
                    <input style="display:none" name="paramKey" value="${systemParameter.paramKey }"/>
                </c:otherwise>
                </c:choose>
                   <div class="form-group">
                    <label class="col-sm-2 control-label"><font style="color: red;">※</font>参数名称</label>

                    <div class="col-sm-8">
                    <c:choose>
                    <c:when test="${systemParameter.uuid==null}">
                            <input name="paramName" placeholder="参数名称"
                                         class="form-control"
                                         data-rule-required="true"
                                         data-msg-required="请录入参数名称。"
                                         data-rule-minlength="1"
                                         data-msg-minlength="参数名称最少为1个字符"
                                         data-msg-remote="参数名称已使用"
                                         data-rule-commonString="true"
                                         data-rule-remote="${path}/dictionary/nameIsNotExist.json?duId=${systemParameter.duId}"
                                         maxlength="50"/>
                        </c:when>
                        <c:otherwise> 
                            <input name="paramName" placeholder="参数名称" value="${systemParameter.paramName }"
                                         class="form-control"
                                         maxlength="50"/>
                       </c:otherwise>
						</c:choose>
                        <span class="help-inline"></span>

                        <p class="help-block"></p>
                    </div>
                </div>
                <!--
                <div class="form-group">
                    <label class="col-sm-2 control-label">描述</label>

                    <div class="col-sm-8">
                        <s:textarea name="systemParameter.summary" placeholder="描述"
                                    data-rule-maxlength="80"
                                    data-msg-maxlength="请录入80字以内的描述信息。"
                                    rows="4" cols="40" class="form-control"/>
                        <span class="help-inline"></span>

                        <p class="help-block"></p>
                    </div>
                </div>
                -->
                <div class="form-group">
                    <label class="col-sm-2 control-label"><font style="color: red;">※</font>参数值</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${systemParameter.paramType=='int'}">
                                <input name="paramVal"  value="${systemParameter.paramVal }"
                                             data-rule-number="true"
                                             data-msg-number="请录入数字类型的参数值。"
                                             class="form-control" placeholder="参数值"
                                             maxlength="30"/>
                            </c:when>
                            <c:when test="${systemParameter.paramType=='image'}">
                              <div class="col-sm-2"><a id="selectImage" class="btn btn-primary" href="#">上传图片</a></div>
                               <sys:upload id="selectImage" extensions="jpg,gif,png">
                                <jsp:attribute name="callback">
                                    $('#dictionaryImage').val(fileInfo.url);
                                    $('#showDictionaryImage').attr('src',fileInfo.url);
		                        </jsp:attribute>
                            	</sys:upload>
                                <input style="display:none" name="paramVal" id="dictionaryImage" value="${systemParameter.paramVal}"/>
                                <div class="col-sm-6">
                                    <img id="showDictionaryImage" width="320" height="240" src="${systemParameter.paramVal}">
                                </div>
                            </c:when>
                            <c:when test="${systemParameter.paramType=='file'}">
                                <div class="col-sm-6">
                                <input name="paramVal" class="form-control" id="dictionaryFile" value="${systemParameter.paramVal}" readonly="readonly"/>
                                </div>
                              	<div class="col-sm-2"><a id="selectFile" class="btn btn-primary" href="#">上传文件</a></div>
                               <sys:upload id="selectFile" extensions="*">
                                <jsp:attribute name="callback">
                                    $('#dictionaryFile').val(fileInfo.url);
		                        </jsp:attribute>
                            	</sys:upload>
                            </c:when>
                            <c:when test="${systemParameter.paramType=='text'}">

                                <link rel="stylesheet" href="${path}/scripts/ueditor/themes/default/css/ueditor.css" type="text/css">
    <script type="text/javascript" charset="utf-8">
        window.UEDITOR_HOME_URL = "${path}/scripts/ueditor/";
    </script>
    <script type="text/javascript" charset="utf-8" src="${path}/scripts/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${path}/scripts/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="${path}/scripts/ueditor/lang/zh-cn/zh-cn.js"></script>

                                <script type="text/javascript">
                                    var editor = UE.getEditor('myEditor');
                                </script>
                                <textarea id="myEditor" name="paramVal" cols="50" cssStyle="height: 500px;" rows="50">${systemParameter.paramVal }</textarea>
                            </c:when>
                            <c:otherwise>
                                <input name="paramVal"  value="${systemParameter.paramVal }"
                                             class="form-control" placeholder="参数内容"
                                             data-rule-required="true"
									         data-rule-commonString="true"
                                             data-msg-required="请录入参数内容。"
                                             data-rule-minlength="1"
                                             data-msg-minlength="参数内容最少为1个字符"
                                             maxlength="100"/>
                            </c:otherwise>
                        </c:choose>
                        <span class="help-inline"></span>

                        <p class="help-block"></p>
                    </div>
                </div>
            </div>
            <c:if test="${not empty summary}">
                <div class="form-group">
                    <label class="col-sm-2 control-label">描述</label>
                    <label class="col-sm-8 control-label " style="text-align: left;">${summary}</label>

                </div>
            </c:if>
            <div class="form-group">
                <label class="col-sm-5 control-label"></label>

                <div class="col-sm-5">
                    <br>
                    <button type="button" class="btn btn-primary" onclick="submitDictionary();">保存</button>

                    <button type="button" class="btn btn-default" onclick="window.location.href='${path}/dictionary/index.vhtml?duId=${systemParameter.duId}'">
                        返回
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>
</div>
</body>
</html>
