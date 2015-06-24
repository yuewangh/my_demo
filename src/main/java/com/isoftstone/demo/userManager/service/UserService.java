package com.isoftstone.demo.userManager.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.userManager.model.User;

/**
 * Created by lidey on 14-6-25.
 */
public interface UserService<T> {

    /**
     * @param params
     * @param page
     * @return
     */
    public PageModel<T> findUserGridByParams(Map<String, Object> params, String page,String sortBy,String ascDesc);
    public PageModel<T> findUserGridByParams(Map<String, Object> params, String page);

    /**
     * @param uuid
     * @return
     * @throws CustomException 
     */
    public T findUserBeanByUuid(String uuid) throws CustomException;

    /**
     * @param loginName
     * @return
     */
    public T findUserBeanByLoginName(String loginName);

    /**
     * @param loginName
     * @return
     */
    public boolean validateLoginName(String loginName);
    
    /**
     * @param mail
     * @param uuid
     * @return
     */
    public boolean validateEmail(String mail);

    /**
     * @param loginName
     * @param uuid
     * @return
     */
    public boolean validateLoginName(String loginName, String uuid);

    /**
     * @param uuid
     * @param oldPassword
     * @param password
     */
    public void resetPassword(String uuid, String oldPassword, String password);

    /**
     * @param userBean
     * @param url
     */
    public T register(T user, String url);

    /**
     * @param ticket
     */
    public void activationUser(String ticket) throws CustomException;

    /**
     * @param ticket
     * @param url
     * @throws CustomException 
     */
    public void activationMail(String ticket, String url) throws CustomException;

    /**
     * @param loginName
     * @param url
     * @throws CustomException 
     */
    public void forgetPassword(String loginName,String mail, String url) throws CustomException;

    /**
     *
     * @param ticket
     * @return
     */
    public String getUuidByTicket(String ticket);

    /**
     *
     * @param userBean
     * @throws CustomException 
     */
    public void savePassword(T user) throws CustomException;

    /**
     *
     * @param uuid
     */
    public void deleteUserByUuid(String uuid);
}
