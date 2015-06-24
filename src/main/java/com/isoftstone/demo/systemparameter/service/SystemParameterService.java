package com.isoftstone.demo.systemparameter.service;

import java.util.List;
import java.util.Map;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.systemparameter.model.DictionaryUnit;
import com.isoftstone.demo.systemparameter.model.SystemParameter;


/**
 * @author fenghuc
 */
public interface SystemParameterService {

    /**
     * @param systemParameterBean
     * @throws CustomException 
     */
    public void saveSystemParameter(SystemParameter systemParameterBean) throws CustomException;

    /**
     * @param systemParameterBean
     * @throws CustomException 
     */
    public void updateSystemParameter(SystemParameter systemParameterBean) throws CustomException;

    /**
     * @param systemParameterBean
     * @throws CustomException 
     */
    public void refreshSystemParameter(SystemParameter systemParameterBean) throws CustomException;

    /**
     * @param duId
     */
    public void refreshSystemParameter(String duId);

    /**
     * @param id
     * @return
     */
    public void deleteSystemParameterByID(String id);

    /**
     * @param ids
     * @return
     */
    public void deleteSystemParameterByIds(String[] ids);

    /**
     * @return
     */
    public List<SystemParameter> findAll();


    /**
     * @param id
     * @return
     * @throws CustomException 
     */
    public SystemParameter loadSystemParameterBean(String id) throws CustomException;

    /**
     * @param params
     * @param page
     * @return
     */
    public PageModel<SystemParameter> findGridByParams(
            Map<String, Object> params, int page,int size, Map<String, String> orders);

    /**
     * @return
     */
    public List<DictionaryUnit> getAllDictionaryUnitBean();

    /**
     * @return
     */
    public DictionaryUnit findDictionaryUnitBeanById(String id);

    /**
     *
     * @param key
     * @return
     */
    public String getValueByKey(String key);

    /**
     *
     * @param duId
     * @param name
     * @return
     */
    public boolean validateForName(String duId,String name);

}
