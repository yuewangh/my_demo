<#include '/pages/localization/assign.ftl'>
<#import '/pages/upload/uploadTag.ftl' as upload>
<style type="text/css">
    .form-horizontal .editPh {
        background: rgba(0, 0, 0, 0.5);
        width: 200px;
        height: 22px;
        line-height: 22px;
        color: #fff;
        text-align: center;
        position: absolute;
        bottom: 0;
    }

    .form-horizontal .editPh a {
        color: #fff;
    }
</style>

<script type="text/javascript" src="${base}/scripts/validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/messages_zh.js"></script>
<script type="text/javascript" src="${base}/scripts/validation/additional-methods.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${base}/scripts/jquery-migrate-1.1.1.min.js"></script>

<link rel="stylesheet" href="${base}/scripts/ueditor/themes/default/css/ueditor.css" type="text/css">
<script type="text/javascript" charset="utf-8">
    window.UEDITOR_HOME_URL = "${base}/scripts/ueditor/";
</script>
<script type="text/javascript" charset="utf-8" src="${base}/scripts/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/scripts/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/scripts/ueditor/lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript">
    $(function () {
        UE.getEditor('content');

        var validator = $("#information_form").validate({
            bootstrap: true
        });

        $('#submitButton').click(function () {
            submitForm("${base}/library/information/promulgation/text.json");
        });
        $('#saveButton').click(function () {
        <#if information.status=='PROMULGATION'>
            submitForm("${base}/library/information/hide/text.json");
        <#else >
            submitForm("${base}/library/information/save/text.json");
        </#if>
        });

        function submitForm(url) {
            if (validator.form()) {
                $("#information_form").attr('action', url).ajaxSubmit({
                    type: 'post',
                    success: function (json) {
                        if (eval(json.status)) {
                            showSuccessMessage(json.message);
                            reloadGrid();
                        } else {
                            showDangerMessage(json.message);
                        }
                    }
                });
            }
        }

    });
</script>
<form id="information_form" class=" form-horizontal" role="form" method="post">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">编辑信息</h4>
    </div>
    <div class="modal-body row">
        <input type="hidden" name="uuid" value="${information.uuid!''}">
        <input type="hidden" name="type" value="${information.type!''}">
        <input type="hidden" name="portletId" value="${information.portletId!''}">

        <div class="col-sm-12">
            <div class="row">
                <div class="col-sm-3 ">
                    <span class="media-left ph">
                        <@upload.singleFile 'selectImage' 'fileInfo' 'jpg,gif,png'>
                            $('#titleImageVal').val(fileInfo.url);
                            $('#titleImageSrc').attr('src',fileInfo.url);
                        </@upload.singleFile>
                            <input id="titleImageVal" name="pictureUrl" value="${information.pictureUrl!''}"
                                   type="hidden">
                        <img id="titleImageSrc" src="${base}${information.pictureUrl!'/images/pictures.png'}" alt="标题图片"
                             style="width: 200px;height: auto;">
                        <p class="editPh"><a href="#">修改标题图片</a></p>
                    </span>
                </div>
                <div class="col-sm-9">
                    <div class="form-group has-feedback">
                        <label class="col-sm-2 control-label no-padding-right">标题：</label>

                        <div class="col-xs-10 col-sm-10">
                            <input type="text" id="title" name="title"
                                   placeholder="标题"
                                   class="form-control" maxlength="20"
                                   data-rule-required="true"
                                   value="${information.title!''}">
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label class="col-sm-2 control-label no-padding-right">作者：</label>

                        <div class="col-xs-7 col-sm-7">
                            <input type="text" id="authorName" name="authorName"
                                   placeholder="作者"
                                   class="form-control" maxlength="20"
                                   data-rule-required="true"
                                   value="${information.authorName!''}">
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label class="col-sm-2 control-label no-padding-right">信息来源：</label>

                        <div class="col-xs-7 col-sm-7">
                            <input type="text" id="informationSource" name="informationSource"
                                   placeholder="信息来源"
                                   class="form-control" maxlength="30"
                                   value="${information.informationSource!''}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">简介：</label>

                        <div class="col-xs-10 col-sm-10">
                        <textarea id="summary" name="summary"
                                  placeholder="简介"
                                  class="form-control" rows="3"
                                  maxlength="50">${information.summary!''}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12" style="padding-top: 20px;">
                    <textarea id="content" name="content" style="height: 400px;"
                            >${information.content!''}</textarea>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button id="submitButton" type="button" class="btn btn-danger" data-dismiss="modal">发布</button>
        <button id="saveButton" type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
    </div>
</form>
