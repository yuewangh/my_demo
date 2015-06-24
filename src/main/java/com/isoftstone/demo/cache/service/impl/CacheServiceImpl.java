package com.isoftstone.demo.cache.service.impl;

import java.io.Serializable;
import java.util.List;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;

import com.isoftstone.demo.cache.service.CacheService;

/**
 * User: 姚丰利（lidey）
 * Date: 13-5-23
 * Time: 下午2:43
 * To change this template use File | Settings | File Templates.
 */
public class CacheServiceImpl implements CacheService {

    private Cache cache;

    /**
     * @param cache the cache to set
     */
    public void setCache(Cache cache) {
        this.cache = cache;
    }

    @Override
    public void put(String key, Object value) {
        //To change body of implemented methods use File | Settings | File Templates.
        Element element = new Element(key, (Serializable) value);
        cache.put(element);
    }

    @Override
    public Object get(String key) {
        Element element = cache.get(key);
        List list = cache.getKeys();
        if (element != null)
            return element.getObjectValue();  //To change body of implemented methods use File | Settings | File Templates.
        else
            return null;
    }
    @Override
    public void remove(String key) {
        cache.remove(key);
    }
}
