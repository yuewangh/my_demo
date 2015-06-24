/**
 *
 */
package com.isoftstone.demo.userManager.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.userManager.model.User;

/**
 * @author 姚丰利(lidey)
 *         创建时间：2012-8-6 下午05:21:16
 */
public interface UserDao {

    /**
     * @param user
     */
    void saveUser(User user);

    /**
     * @param user
     */
    void updateUser(User user);

    /**
     * @param uuid
     * @return
     * @throws CustomException 
     */
    User getUser(Serializable uuid) throws CustomException;


    /**
     * @param uuid
     * @return
     * @throws CustomException 
     */
    User loadUser(Serializable uuid) throws CustomException;

    /**
     * @param uuid
     */
    void deleteUser(Serializable uuid);

    /**
     * @param uuid
     */
    void logicDeleteUser(Serializable uuid);

    /**
     * @param user
     */
    void deleteUser(User user);

    /**
     * @param loginName
     * @return
     */
    User findUserByLoginName(String loginName);

    /**
     * @param mail
     * @return
     */
    User findUserByEmail(String mail);
    
    /**
     * @param params
     * @param page
     * @param pageSize
     * @return
     */
    List<User> findUserByParams(Map<String, Object> params, int page, int pageSize,String sortBy,String ascDesc);

    /**
     * @param params
     * @return
     */
    int countUserByParams(Map<String, Object> params);
}
