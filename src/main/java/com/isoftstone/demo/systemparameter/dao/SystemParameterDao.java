package com.isoftstone.demo.systemparameter.dao;

import java.util.List;
import java.util.Map;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.systemparameter.model.SystemParameter;






/**
 * @author fenghuc
 *
 */
public interface SystemParameterDao {
	/**
	 * 
	 * @param systemParameter
	 */
	public void updateSystemParameter(SystemParameter systemParameter);
	
	/**
	 * 
	 * @param systemParameter
	 */
	public void saveSystemParameter(SystemParameter systemParameter);
	
	/**
	 * @param id
	 * @throws CustomException 
	 */
	public SystemParameter getSystemParameter(int id) throws CustomException;
	
	/**
	 * @param id
	 * @throws CustomException 
	 */
	public SystemParameter loadSystemParameter(String id) throws CustomException;
	
	/**
	 * 
	 * @param systemParameter
	 */
	public void deleteSystemParameter(SystemParameter systemParameter);
	
	
	/**
	 * @param id
	 * @return
	 */
	public void deleteSystemParameterByID(String id);
	
	/**
	 * 
	 * @param params
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<SystemParameter> findSystemParameterByParams(Map<String, Object> params, int page, int pageSize);

    /**
     *
     * @param duId
     * @return
     */
    public List<SystemParameter> findSystemParametersByDuId(String duId);

	/**
	 * @return
	 */
	public List<SystemParameter> findAllSystemParameter();
	
	/**
	 * @param params
	 * @return
	 */
	public int countSystemParameterByParams(Map<String, Object> params);

    /**
     *
     * @param key
     * @return
     */
	public SystemParameter findSystemParameterByKey(String key);
}
