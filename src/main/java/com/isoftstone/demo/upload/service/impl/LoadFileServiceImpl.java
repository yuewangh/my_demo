package com.isoftstone.demo.upload.service.impl;


import java.io.File;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.isoftstone.demo.upload.service.LoadFileService;

/**
 * Group: 姚丰利（lidey）
 * Date: 2014-08-24
 * Time: 02:28
 * To change this template use File | Settings | File Templates.
 */
@Service("uploadFileService")
public class LoadFileServiceImpl implements LoadFileService {

    @Value("${system.path}")
    private String rootPath;

    private static String UPLOAD_PATH = "/UPLOAD";

    @Override
    public File loadFileByFileUrl(String fileUrl) {
        StringBuilder filePath = new StringBuilder(rootPath);
        filePath.append(File.separator);
        filePath.append(UPLOAD_PATH);
        filePath.append(File.separator);
        if (!rootPath.endsWith("/") && !rootPath.endsWith("\\"))
            filePath.append(File.separator);
        filePath.append(fileUrl);
        File file = new File(filePath.toString());
        if (file.exists()) {
            return file;
        }
        return null;
    }
}
