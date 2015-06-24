/**
 * 
 */
package com.isoftstone.demo.role.dao;

import java.util.List;
import java.util.Map;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.role.model.Resource;


public interface ResourceDao {
	
	/**
	 * 
	 * @param uuid
	 */
	void deleteResource(String uuid);
	
	/**
	 * 
	 * @param resource
	 */
	void deleteResource(Resource resource);
	
	/**
	 * 
	 * @param resource
	 */
	void saveResource(Resource resource);
	
	/**
	 * 
	 * @param resource
	 */
	void updateResource(Resource resource);
	
	/**
	 * 
	 * @param uuid
	 * @return
	 * @throws CustomException 
	 */
	Resource getResource(String uuid) throws CustomException;
	
	/**
	 * 
	 * @return
	 */
	List<Resource> findAll();

    /**
     *
     * @return
     */
    List<Resource> findRootNode();
	
	/**
	 * 
	 * @param key
	 * @return
	 */
	Resource findResourceInfoByKey(String key);
	
	/**
	 * 
	 * @param params
	 * @param page
	 * @param pageSize
	 * @return
	 */
	List<Resource> findResourceInfoByParams(Map<String, Object> params, int page, int pageSize);
	
	/**
	 * 
	 * @param params
	 * @return
	 */
	int countResourceInfoByParams(Map<String, Object> params);

}
