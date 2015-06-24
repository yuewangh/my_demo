package com.isoftstone.demo.upload.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.upload.model.UploadFileBean;

/**
 * Group: 姚丰利（lidey）
 * Date: 2014-08-23
 * Time: 21:48
 * To change this template use File | Settings | File Templates.
 */
public interface UploadFileService {

    /**
     * 多文件上传服务
     * @param request
     * @param modulePath
     * @return
     */
    public List<UploadFileBean> uploadMultiFile(MultipartHttpServletRequest request, String modulePath) throws CustomException;

    /**
     * 单文件上传服务
     * @param request
     * @param modulePath
     * @return
     */
    public UploadFileBean uploadOneFile(MultipartHttpServletRequest request, String modulePath) throws CustomException;
}
