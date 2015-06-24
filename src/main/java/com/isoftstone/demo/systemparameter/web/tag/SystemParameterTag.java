package com.isoftstone.demo.systemparameter.web.tag;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.isoftstone.demo.systemparameter.unit.ParamUnit;

/**
 * User: 姚丰利（lidey）
 * Date: 13-5-23
 * Time: 下午2:03
 * To change this template use File | Settings | File Templates.
 */
public class SystemParameterTag extends SimpleTagSupport {

    private Logger logger = LoggerFactory.getLogger(getClass());

    private String key;
    private String value;

    public void doTag() throws JspException, IOException {

        // 获取页面输出流
        Writer out = getJspContext().getOut();
        StringBuilder sb = new StringBuilder();
        try {
            Object obj = ParamUnit.getStrValueByKey(key);
            if (obj == null)
                throw new NullPointerException("<sys:param/> don`t find value, key is " + key);
            sb.append(obj);
        } catch (Exception e) {
            logger.error(e.getMessage());
            sb.append(value);
        }

        // 在页面输出表格
        out.write(sb.toString());

    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
