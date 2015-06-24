package com.isoftstone.demo.common.dao;


import java.io.Serializable;

import com.isoftstone.demo.common.exception.CustomException;

/**
 * Group: 姚丰利（lidey）
 * Date: 2014-08-16
 * Time: 12:56
 * To change this template use File | Settings | File Templates.
 */
public interface BaseDao<T> {

    /**
     * @param entry
     * @return
     */
    public T save(T entry);

    /**
     * @param entry
     * @return
     */
    public T update(T entry);

    /**
     * @param uuid
     */
    public void delete(Serializable uuid);


    /**
     * @param entry
     */
    public void delete(T entry);

    /**
     * @param uuids
     */
    public void batchDelete(Serializable[] uuids);

    /**
     * @param id
     * @return
     * @throws com.isoftstone.demo.common.exception.memory.beehive.exception.CustomException
     */
    public T get(Serializable id) throws CustomException;


    /**
     * @param id
     * @return
     * @throws com.isoftstone.demo.common.exception.memory.beehive.exception.CustomException
     */
    public T load(Serializable id) throws CustomException;;

}
