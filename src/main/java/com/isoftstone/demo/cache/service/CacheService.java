package com.isoftstone.demo.cache.service;

/**
 * User: 姚丰利（lidey）
 * Date: 13-5-23
 * Time: 下午2:40
 * To change this template use File | Settings | File Templates.
 */
public interface CacheService {

    /**
     *
     * @param key
     * @param value
     */
    public void put(String key, Object value);

    /**
     *
     * @param key
     * @return
     */
    public Object get(String key);
    /**
    *
    * @param key
    */
   public void remove(String key);
}
