<!doctype html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/includes/taglibs.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>客户端下载</title>
    <link rel="stylesheet" type="text/css" href="${base}/app/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${base}/app/css/main.css">

</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12 pl0 pr0">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div style="margin:-10px -10px 10px;"><img src="${base}/app/images/dl.jpg" style="width:100%;"></div>
                        <blockquote>
                            <p>欢迎您下载云享客客户端，您可以便捷查询到符合您需求得办公位置,并享受更好得服务。</p>
                            <footer>注：<a href="${base}/app/androidApp.jsp">Android请点击这里</a></footer>
                        </blockquote>
                        <form role="form" >
                          <!--   <button type="submit" ></button> -->
                            	<a class="btn btn-danger btn-block btn-lg" href="<sys:param key="APP_ANDROID_DOWNLOAD_URL"/>">IOS点击下载</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>