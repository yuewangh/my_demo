<#include '/pages/localization/assign.ftl'>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${base}/styles/panel-grid.css">

    <link rel="stylesheet" href="${base}/scripts/jqGrid/css/ui.jqgrid.me.css">
    <script src="${base}/scripts/jqGrid/js/i18n/grid.locale-cn.js" type="text/javascript"></script>
    <script src="${base}/scripts/jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        information_draft_grid = "#information_draft_grid";
        information_draft_footer = "#information_draft_footer";
        information_draft_url = "${base}/library/information/${portletId}/getInformationDraftGrid.json";

        information_active_grid = information_draft_grid;

        $(function () {
            var draft_grid = $(information_draft_grid).jqGrid({
                url: information_draft_url,
                datatype: "json",
                height: 300,
                colNames: ['uuid', '标题', '作者', '类型编码', '状态编码', '类型', '状态', '创建日期', '编辑日期'],
                colModel: [
                    {name: 'uuid', index: 'uuid', hidden: true},
                    {name: 'title', index: 'title', width: 355},
                    {name: 'authorName', index: 'authorName', width: 190},
                    {name: 'type', index: 'type', hidden: true},
                    {name: 'status', index: 'status', hidden: true},
                    {name: 'typeStr', index: 'typeStr', width: 80},
                    {name: 'statusStr', index: 'statusStr', width: 80},
                    {name: 'createDateStr', index: 'createDateStr', sortable: false, width: 120},
                    {name: 'modifyDateStr', index: 'modifyDateStr', sortable: false, width: 120}
                ],
                viewrecords: true,
                rowNum: 10,
                rowList: [10, 20, 30],
                pager: information_draft_footer,
                altRows: true,
                caption: "",
                autowidth: true
            }).navGrid(information_draft_footer, {
                add: true,
                addtext: '创建',
                addfunc: function () {
                    $("#information_modal_content").load("${base}/library/information/${portletId}/addText.action", function () {
                        $("#information_form_div").modal('show');
                    });
                },
                edit: true,
                edittext: '编辑',
                editfunc: editInformation,
                refresh: true,
                refreshtext: '刷新',
                refreshicon: 'icon-refresh green',
                view: false,
                search: false,
                del: true,
                deltext: '删除',
                delfunc: deleteInformation
            });

            $('.information_draft .search-button').click(function () {
                searchFunction(".information_draft");
            });
        });
        //-----------------------------------------------------------------------

        information_manager_grid = "#information_manager_grid";
        information_manager_footer = "#information_manager_footer";
        information_manager_url = "${base}/library/information/${portletId}/getInformationManagerGrid.json";

        var manager_grid = $(function () {
            $(information_manager_grid).jqGrid({
                url: information_manager_url,
                datatype: "json",
                height: 300,
                colNames: ['uuid', '标题', '作者', '类型编码', '状态编码', '类型', '状态', '编辑日期', '发布日期'],
                colModel: [
                    {name: 'uuid', index: 'uuid', hidden: true},
                    {name: 'title', index: 'title', width: 355},
                    {name: 'authorName', index: 'authorName', width: 190},
                    {name: 'type', index: 'type', hidden: true},
                    {name: 'status', index: 'status', hidden: true},
                    {name: 'typeStr', index: 'typeStr', width: 80},
                    {name: 'statusStr', index: 'statusStr', width: 80},
                    {name: 'modifyDateStr', index: 'modifyDateStr', sortable: false, width: 120},
                    {name: 'promulgationDateStr', index: 'promulgationDateStr', sortable: false, width: 120}
                ],
                viewrecords: true,
                rowNum: 10,
                rowList: [10, 20, 30],
                pager: information_manager_footer,
                altRows: true,
                caption: "",
                autowidth: true
            }).navGrid(information_manager_footer, {
                add: false,
                edit: true,
                edittext: '编辑',
                editfunc: editInformation,
                refresh: true,
                refreshtext: '刷新',
                refreshicon: 'icon-refresh green',
                view: false,
                search: false,
                del: true,
                deltext: '删除',
                delfunc: deleteInformation
            });

            $('.information_manager .search-button').click(function () {
                searchFunction(".information_manager");
            });
        });
        //-----------------------------------------------------------------------
        function editInformation(rowid) {
            var data = jQuery(information_active_grid).jqGrid('getRowData', rowid);
            if (data.status != 'AUDIT') {
                if (data.status == 'PROMULGATION') {
                    var zDialog = new $.Zebra_Dialog('', {
                        'source': {
                            'inline': "您选择的信息:" + data.title +
                            "正在发布中,修改后将变成隐藏状态需要重新发布,编辑点击“确认”按钮。"
                        },
                        'width': 400,
                        'type': false,
                        'overlay_close': false,
                        'overlay_opacity': 0.75,
                        'title': '确认编辑',
                        'buttons': [
                            {
                                caption: '确认', claName: 'primary', callback: function () {
                                $("#information_modal_content").load("${base}/library/information/" + data.uuid + "/edit.action", function () {
                                    $("#information_form_div").modal('show');
                                });
                            }
                            },
                            {
                                caption: '取消', claName: 'default', callback: function () {
                            }
                            }
                        ]
                    });
                } else {
                    $("#information_modal_content").load("${base}/library/information/" + data.uuid + "/edit.action", function () {
                        $("#information_form_div").modal('show');
                    });
                }
            } else {
                var msg = "您选择的信息已经提交，正在等待管理员审批。";
                if (data.status == 'PROMULGATION')
                    msg = "发布中的信息不能修改，请先隐藏后在修改。";
                showDangerMessage(msg);
            }
        }

        function deleteInformation(rowid) {
            var data = jQuery(information_active_grid).jqGrid('getRowData', rowid);
            var zDialog = new $.Zebra_Dialog('', {
                'source': {'inline': "请确认是否删除信息：" + data.title + ",删除点击“确认”按钮。"},
                'width': 400,
                'type': false,
                'overlay_close': false,
                'overlay_opacity': 0.75,
                'title': '确认删除',
                'buttons': [
                    {
                        caption: '确认', claName: 'primary', callback: function () {
                        jQuery.post("${base}/library/information/delete.json", {"uuid": data.uuid},
                                function (json) {
                                    if (eval(json.status)) {
                                        showSuccessMessage(json.message);
                                        jQuery(information_active_grid).jqGrid().trigger("reloadGrid");
                                    } else {
                                        showDangerMessage(json.message);
                                    }
                                }, "json");
                    }
                    },
                    {
                        caption: '取消', claName: 'default', callback: function () {
                    }
                    }
                ]
            });
        }

        title = "";
        status = "";

        function searchFunction(active) {
            title = $(active + " .search-title").val();
            status = $(active + " .search-status").val();
            $(information_active_grid).jqGrid('setGridParam', {
                postData: {"title": title, "status": status},
                page: 1
            }).trigger("reloadGrid");
        }

        function reloadGrid() {
            $(information_active_grid).jqGrid('setGridParam', {
                page: 1
            }).trigger("reloadGrid");
        }


        function showSuccessMessage(content) {
            var success = '<div id="showSuccessMessage" class="alert alert-success" role="alert"><button type="button" class="close" data-dismiss="alert">' +
                    '<span aria-hidden="true">×</span><span class="sr-only">Close</span></button><strong>操作成功!</strong>' + content + '</div>';
            $('#actionMessageBox').append(success);
            setTimeout("$('#showSuccessMessage').alert('close');", 3000);
        }

        function showDangerMessage(content) {
            var success = '<div id="showDangerMessage" class="alert alert-danger" role="alert"><button type="button" class="close" data-dismiss="alert">' +
                    '<span aria-hidden="true">×</span><span class="sr-only">Close</span></button><strong>操作失败!</strong>' + content + '</div>';
            $('#actionMessageBox').append(success);
            setTimeout("$('#showDangerMessage').alert('close');", 3000);
        }
    </script>
</head>
<body>
<div class="panel panel-default panel-grid">
    <!-- Default panel contents -->
    <ul class="nav nav-tabs panel-heading" role="tablist">
        <li role="presentation" class="active">
            <a href=".information_draft" aria-controls="information_draft" role="tab"
               onclick="information_active_grid = information_draft_grid;reloadGrid();"
               data-toggle="tab">草稿箱</a>
        </li>
    <#--<li role="presentation">-->
    <#--<a href=".information_audit" aria-controls="information_audit" role="tab" data-toggle="tab">信息审批</a>-->
    <#--</li>-->
        <li role="presentation">
            <a href=".information_manager" aria-controls="information_manager" role="tab"
               onclick="information_active_grid = information_manager_grid;reloadGrid();"
               data-toggle="tab">信息管理</a>
        </li>
    </ul>
    <div class="panel-body tab-content">
        <div role="tabpanel" class="tab-pane active information_draft">
            <form class="form-horizontal" role="form">
                <div class="form-group col-xs-7">
                    <label for="" class="control-label col-xs-4">标题</label>

                    <div class="col-xs-8">
                        <input type="text" class="form-control input-sm  search-title" placeholder="">
                    </div>
                </div>
                <div class="form-group col-xs-3">
                    <label for="" class="control-label col-xs-4">状态</label>

                    <div class="col-xs-8">
                        <select class="form-control input-sm search-status">
                            <option value="">全部</option>
                            <option value="DRAFT">草稿</option>
                            <option value="AUDIT">待审批</option>
                            <option value="REJECT">未通过</option>
                        </select>
                    </div>
                </div>
                <div class="form-group col-xs-2 text-right">
                    <button type="button" class="btn btn-default btn-sm search-button">查询</button>
                </div>
            </form>
        </div>
        <div role="tabpanel" class="tab-pane information_audit">
            <form class="form-horizontal" role="form">
                <div class="form-group col-xs-10">
                    <label for="" class="control-label col-xs-4">标题</label>

                    <div class="col-xs-8">
                        <input type="text" class="form-control input-sm  search-title" placeholder="">
                    </div>
                </div>
                <div class="form-group col-xs-2 text-right">
                    <button type="button" class="btn btn-default btn-sm search-button">查询</button>
                </div>
            </form>
        </div>
        <div role="tabpanel" class="tab-pane information_manager">
            <form class="form-horizontal" role="form">
                <div class="form-group col-xs-7">
                    <label for="" class="control-label col-xs-4">标题</label>

                    <div class="col-xs-8">
                        <input type="text" class="form-control input-sm  search-title" placeholder="">
                    </div>
                </div>
                <div class="form-group col-xs-3">
                    <label for="" class="control-label col-xs-4">状态</label>

                    <div class="col-xs-8">
                        <select class="form-control input-sm search-status">
                            <option value="">全部</option>
                            <option value="PROMULGATION">发布</option>
                            <option value="HIDE">隐藏</option>
                        </select>
                    </div>
                </div>
                <div class="form-group col-xs-2 text-right">
                    <button type="button" class="btn btn-default btn-sm search-button">查询</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div id="actionMessageBox"></div>
<!-- Tab panes -->
<div class="tab-content">
    <div role="tabpanel" class="tab-pane active information_draft">
        <table id="information_draft_grid"></table>
        <div id="information_draft_footer"></div>
    </div>
    <div role="tabpanel" class="tab-pane information_audit">
        <table id="information_audit_grid"></table>
        <div id="information_audit_footer"></div>
    </div>
    <div role="tabpanel" class="tab-pane information_manager">
        <table id="information_manager_grid" style="width: 945px;" width="945px"></table>
        <div id="information_manager_footer"></div>
    </div>
</div>

<div class="modal fade" id="information_form_div" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" id="information_modal_content">
        </div>
    </div>
</div>
</body>
</html>