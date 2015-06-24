<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <sitemesh:write property='head'/>
    <script type="text/javascript">
    $(function(){
		$.ajax({
            'url': '${path}/dictionary/menu.json',
            'dataType': 'json',
            timeout: 6 * 1000,
            success: function (data) {
            	for(var index in data){
            		$("#dictionaryList").append("<li><a id='smenu"+index+"' href='${path}/dictionary/index.vhtml?duId="+data[index].uuid+"''><i class=''></i>"+data[index].paramName+"</a></li>");
            	}
            	$("a[id^='smenu']").each(function () {
            	    $(this).removeAttr("class");
            	    var href = $(this).attr("href");
            	    var ss = window.location.href;
            	    var len = 4;
            	    if(ss.indexOf("?")==-1){
            	    	 $("#smenu0").attr("class", "active");
            	    }
            	    if("${path}" == ""){
            	    	len = 3;
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
            }
			}); 
  });
    </script>
</head>
<body>
<!--内容-->
<div id="wrap">
    <div class="container">
        <div class="container">
            <div class="container UCContainer">
                <div class="row">
                    <div class="col-xs-2 UCMenu">
                        <ul id="sideNav" class="nav nav-pills nav-stacked show-arrows">
                            <li class="hasSub"><a href="#" class="expand"><i class="glyphicon glyphicon-th-list"></i>数据字典 </a>
                                <ul id="dictionaryList" class="nav sub show" style="display: block;">
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="col-xs-10">
                        <sitemesh:write property='body'/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>