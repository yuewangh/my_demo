package com.isoftstone.demo.upload.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jmimemagic.MagicException;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import net.sf.jmimemagic.MagicParseException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.isoftstone.demo.common.util.MineTypeUtil;
import com.isoftstone.demo.upload.service.LoadFileService;

/**
 * 项目名称：beehive
 * 开发人员：姚丰利（lidey）
 * 创建时间：14-4-29
 * <p/>
 * 请编写描述信息 .
 */
@Controller
@RequestMapping("/analysis")
public class UrlAnalysisController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private LoadFileService loadFileService;

    @RequestMapping(value = "/file")
    public ModelAndView file(@RequestParam("fileUrl") String fileUrl, HttpServletRequest request, HttpServletResponse response) {
        File file = loadFileService.loadFileByFileUrl(fileUrl);
        if (file != null) {
            try {
                response.reset();
                response.setContentType(MineTypeUtil.getMineType(file));
                response.setHeader("Cache-Control", "no-cache");
                response.setDateHeader("Expires", 0);
                response.setHeader("Content-disposition", "filename=" +
                        new String(file.getName().getBytes("utf-8"), "ISO8859-1"));
                response.setHeader("Content-Length", String.valueOf(file.length()));
                InputStream inputStream = new FileInputStream(file);
                OutputStream os = response.getOutputStream();
                byte[] buf = new byte[4096];
                int bytes = 0;
                while ((bytes = inputStream.read(buf)) != -1)
                    os.write(buf, 0, bytes);
                inputStream.close();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (MagicMatchNotFoundException e) {
                e.printStackTrace();
            } catch (MagicException e) {
                e.printStackTrace();
            } catch (MagicParseException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

}
