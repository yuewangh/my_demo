package com.isoftstone.demo.upload.web.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.upload.model.UploadFileBean;
import com.isoftstone.demo.upload.service.UploadFileService;

/**
 * 项目名称：beehive
 * 开发人员：姚丰利（lidey）
 * 创建时间：14-4-29
 * <p/>
 * 请编写描述信息 .
 */
@Controller
@RequestMapping("/upload/file")
public class UploadMultiFileController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private UploadFileService uploadFileService;

    @RequestMapping(value = "/multiFile", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public List<UploadFileBean> multiFile(@RequestParam("path") String path,
                                          MultipartHttpServletRequest request, Model model) {

        List<UploadFileBean> uploadFileBeanList = new ArrayList<UploadFileBean>();
        try {
            uploadFileBeanList = uploadFileService.uploadMultiFile(request, path);
        } catch (CustomException e) {
            logger.error("根文件路径必须存在且是文件夹类型,请确认并重新配置config.properties");
            e.printStackTrace();
        }
        return uploadFileBeanList;
    }


    @RequestMapping(value = "/singleFile", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public UploadFileBean singleFile(MultipartHttpServletRequest request, Model model) {
        String path = request.getParameter("path");

        List<UploadFileBean> uploadFileBeanList = new ArrayList<UploadFileBean>();
        try {
            uploadFileBeanList = uploadFileService.uploadMultiFile(request, path);
        } catch (CustomException e) {
            logger.error("根文件路径必须存在且是文件夹类型,请确认并重新配置config.properties");
            e.printStackTrace();
        }
        if (!uploadFileBeanList.isEmpty())
            return uploadFileBeanList.get(0);
        else
            return null;
    }

}
