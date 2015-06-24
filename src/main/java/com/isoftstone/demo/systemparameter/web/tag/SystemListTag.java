package com.isoftstone.demo.systemparameter.web.tag;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.isoftstone.demo.cache.unit.CacheUnit;

/**
 * User: 姚丰利（lidey）
 * Date: 13-5-23
 * Time: 下午2:03
 * To change this template use File | Settings | File Templates.
 */
public class SystemListTag extends SimpleTagSupport {

    private Logger logger = LoggerFactory.getLogger(getClass());

    private String key;
    private String entry;

    public void doTag() throws JspException, IOException {

        try {
            Object obj = CacheUnit.get(key);
            if (obj == null)
                throw new NullPointerException("<sys:param/> don`t find value, key is " + key);
            if (obj instanceof Map) {
                JspFragment frag = getJspBody();

                for (Map.Entry<String, String> o : ((Map<String, String>) obj).entrySet()) {
                    getJspContext().setAttribute(entry, o);
                    frag.invoke(null);
                }
            }

        } catch (NullPointerException e) {
            logger.error(e.getMessage());
        }

    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getEntry() {
        return entry;
    }

    public void setEntry(String entry) {
        this.entry = entry;
    }
}
