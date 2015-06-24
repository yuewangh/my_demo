package com.isoftstone.demo.cache.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.ehcache.Cache;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * User: 姚丰利（lidey）
 * Date: 13-8-2
 * Time: 下午2:37
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/clearPageCache")
public class CacheController {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    final Logger logger = LoggerFactory.getLogger(CacheController.class);

    private Cache cache;

    /**
     * @param cache the cache to set
     */
    public void setCache(Cache cache) {
        this.cache = cache;
    }

    /**
     * @return
     */
    @RequestMapping("/index")
    public ModelAndView index(HttpServletRequest request) {
        return null;
    }

    /**
     * @return
     */
    @ResponseBody
    @RequestMapping("/clearPageCache")
    public Map<String, Object> clearPageCache(HttpServletRequest request) {
        Map<String, Object> json = new HashMap<String, Object>();
        cache.removeAll();
        json.put("status", true);
        json.put("message", "页面缓存已清空。");
        return json;
    }
}
