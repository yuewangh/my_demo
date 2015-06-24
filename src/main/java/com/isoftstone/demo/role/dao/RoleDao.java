/**
 * 
 */
package com.isoftstone.demo.role.dao;

import java.util.List;
import java.util.Map;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.role.model.Role;

/**
 *
 */
public interface RoleDao {
	
	/**
	 * 
	 * @param uuid
	 */
	void deleteRole(String uuid);
	
	/**
	 * 
	 * @param role
	 */
	void deleteRole(Role role);
	
	/**
	 * 
	 * @param role
	 */
	void saveRole(Role role);
	
	/**
	 * 
	 * @param role
	 */
	void updateRole(Role role);
	
	/**
	 * 
	 * @param uuid
	 * @return
	 * @throws CustomException 
	 */
	Role getRole(String uuid) throws CustomException;
	
	/**
	 * 
	 * @return
	 */
	List<Role> findAll();
	
	/**
	 * 
	 * @param key
	 * @return
	 */
	Role findRoleInfoByKey(String key);
	
	/**
	 * 
	 * @param params
	 * @param page
	 * @param pageSize
	 * @return
	 */
	List<Role> findRoleInfoByParams(Map<String, Object> params, int page, int pageSize);
	
	/**
	 * 
	 * @param params
	 * @return
	 */
	int countRoleInfoByParams(Map<String, Object> params);

    /**
     *
     * @param ids
     */
	void deleteBulk(String ids);
}
