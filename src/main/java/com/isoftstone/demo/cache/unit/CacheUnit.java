package com.isoftstone.demo.cache.unit;

import com.isoftstone.demo.cache.service.CacheService;
import com.isoftstone.demo.cache.service.impl.CacheServiceImpl;
import com.isoftstone.demo.common.util.ApplicationContextUtil;
import com.isoftstone.demo.common.util.StringUtil;

/**
 * User: 姚丰利（lidey）
 * Date: 13-5-23
 * Time: 下午2:21
 * To change this template use File | Settings | File Templates.
 */
public class CacheUnit {


    private CacheUnit() {
    }

    private static CacheService service;

    private static CacheService initService() {
        if (service == null)
            service = ApplicationContextUtil.getSpringBean("cacheService", new CacheServiceImpl().getClass());
        return service;
    }

    /**
     * @param key
     * @param value
     */
    public static void put(String key, String value) {
        if (!StringUtil.isNull(key))
            initService().put(key, value);
    }

    /**
     * @param key
     * @return
     */
    public static Object get(String key) {
        return initService().get(key);
    }
}
