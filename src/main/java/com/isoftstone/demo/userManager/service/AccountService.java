package com.isoftstone.demo.userManager.service;


import java.util.Map;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.userManager.model.UserAccount;

/**
 * Created by lidey on 14-6-25.
 */
public interface AccountService extends UserService<UserAccount> {


    /**
     * @param accountBean
     */
    public void saveUserAccountBean(UserAccount accountBean);


    /**
     * @param accountBean
     * @throws CustomException 
     */
    public void updateUserAccountBean(UserAccount accountBean) throws CustomException;

    /**
     *
     * @param accountBean
     * @throws CustomException 
     */
    public void updatePassword(UserAccount accountBean) throws CustomException;

    /**
     *
     * @param params
     * @param page
     * @return
     */
    public PageModel<UserAccount> findAccountGridByParams(Map<String, Object> params, String page,String rows,String sortBy,String ascDesc);


    public PageModel<UserAccount> findAccountGridByParams(Map<String, Object> params, String page,String rows);
    /**
     *
     * @param uid
     * @param roles
     * @throws CustomException 
     */
    public void updateRoleAuthorized(String uid, String[] roles) throws CustomException;
}
