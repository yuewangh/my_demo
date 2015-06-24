package com.isoftstone.demo.systemparameter.dao;

import java.util.List;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.systemparameter.model.DictionaryUnit;

public interface DictionaryDao {

    /**
     * @param id
     * @return
     * @throws CustomException 
     */
    public DictionaryUnit getDictionaryUnit(String id) throws CustomException;

    /**
     * @param key
     * @return
     */
    public DictionaryUnit findDictionaryUnitByKey(String key);

    /**
     * @return
     */
    public List<DictionaryUnit> findAllDictionaryUnit();


}
