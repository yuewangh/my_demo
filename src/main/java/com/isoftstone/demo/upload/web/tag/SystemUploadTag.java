package com.isoftstone.demo.upload.web.tag;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspContext;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.isoftstone.demo.upload.unit.UploadUnit;

/**
 * User: 姚丰利（lidey）
 * Date: 13-5-23
 * Time: 下午2:03
 * To change this template use File | Settings | File Templates.
 */
public class SystemUploadTag extends SimpleTagSupport {

    private Logger logger = LoggerFactory.getLogger(getClass());

    private String id;
    private String name = "fileInfo";
    private String extensions = "";
    private String callback = "";

    public void doTag() throws JspException, IOException {

        //获取context对象
        PageContext pageContext = (PageContext) this.getJspContext();
        HttpServletRequest request =
                (HttpServletRequest) pageContext.getRequest();
        JspContext context = getJspContext();
        // 获取页面输出流
        Writer out = context.getOut();
        StringBuilder sb = new StringBuilder();
        try {
            String text = UploadUnit.getUploadTemplate(id, name, extensions, callback, request.getContextPath());
            if (text == null)
                throw new NullPointerException("<sys:upload/> don`t find value, id is " + id);
            sb.append(text);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        // 在页面输出表格
        out.write(sb.toString());
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getExtensions() {
        return extensions;
    }

    public void setExtensions(String extensions) {
        this.extensions = extensions;
    }

    public String getCallback() {
        return callback;
    }

    public void setCallback(String callback) {
        this.callback = callback;
    }
}
