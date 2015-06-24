<%--
  Created by IntelliJ IDEA.
  User: lidey
  Date: 14-2-24
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <link rel="stylesheet" type="text/css" href="${base}/scripts/jstree/themes/default/style.css"/>
    <script type="text/javascript" src="${base}/scripts/jstree/jstree.js"></script>
    <script type="text/javascript" src="${base}/scripts/jstree/jstree.checkbox.js"></script>
    <script type="text/javascript" src="${base}/scripts/jstree/jstree.wholerow.js"></script>
	<script type="text/javascript" src="${path}/scripts/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>

    <script type="text/javascript">

        (function ($) {
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) {
                    return unescape(r[2]);
                } else {
                    return null;
                }
            }
        })(jQuery);
        
        function submitAssign(){
            var idArray = new Array();
            $(".jstree-undetermined").each(function () {
                var tmp = $(this).parents('.jstree-node').attr('id');
                idArray.push(tmp);
            })

            $.each(categoryTree.jstree(true).get_selected(true), function (index, element) {
                var obj = categoryTree.jstree(true).get_node(element, true);
                idArray.push(obj.attr('id'));
            });
			$("#authIds").val(idArray.join(","));
			$("#Form1").ajaxSubmit({
                type: 'post',
                success: function (data) {
                   $("#roleInfoDiv").modal("hide");
                   $(grid_selector).setGridParam({url:data_url}).trigger("reloadGrid");
                }
            });
        }
        $(function () {
            var id = $('#uuid').val();
            categoryTree = $("#tree").jstree({
                "core": {
                    'data': {
                        'type': 'post',
                        'url': 'tree.json?uuid=' + id,
                        'data': function (node) {
                            return {'id': node.id};
                        }
                    }
//                    "multiple": true,
//                    "animation": 0,
//                    "check_callback": true
                },
//
                "checkbox": {
//                    "keep_selected_style": false,
                    "undetermined" : true
//                    "undetermined": false
//                            "keep_selected_style": false,
//                            "undetermined": false
                },
                "plugins": [ "checkbox", "wholerow" ]
            });
        });

    </script>

</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">分配权限</h4>
</div>
<div class="modal-body">
	<form name="Form1" id="Form1" class="pagination_form form-horizontal" role="form" method="POST"
      action="${base }/system/role/saveAssign.json">
	    <input type="hidden" id="uuid" name="roleId" value="${uuid }"/>
	    <input type="hidden" id="authIds" name="authIds" value=""/>
	            <div id="tree" class="clearfix " style="clear:left"></div>
	</form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" onclick="toSearch();" data-dismiss="modal">关闭</button>
    <button type="button" class="btn btn-primary" onclick="submitAssign()">
        保存
    </button>
</div>
</body>
</html>
