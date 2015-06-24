package com.isoftstone.demo.userManager.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.common.util.MD5PasswordEncoder;
import com.isoftstone.demo.userManager.constants.UserConstants;
import com.isoftstone.demo.userManager.model.User;
import com.isoftstone.demo.userManager.model.UserAccount;
import com.isoftstone.demo.userManager.service.AccountService;

/**
 * Created by lidey on 14-6-25.
 */
@Service()
@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
public class AccountServiceImpl extends UserServiceImpl<UserAccount> implements AccountService {

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveUserAccountBean(UserAccount accountBean) {
        accountBean.setPassword(MD5PasswordEncoder.encode(accountBean.getPassword(),accountBean.getLoginName()));
        accountBean.setIdentity(UserConstants.identity.ACCOUNT);
        userDao.saveUser(accountBean);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateUserAccountBean(UserAccount accountBean) throws CustomException {
        UserAccount userAccount = (UserAccount) userDao.getUser(accountBean.getUuid());
        userAccount.setName(accountBean.getName());
        userAccount.setDept(accountBean.getDept());
        userAccount.setJob(accountBean.getJob());
        userAccount.setGender(accountBean.getGender());
        userAccount.setTel(accountBean.getTel());
        userAccount.setMail(accountBean.getMail());
        userAccount.setSurvival(accountBean.getSurvival());
        userDao.updateUser(userAccount);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void updatePassword(UserAccount accountBean) throws CustomException {
        User user = userDao.getUser(accountBean.getUuid());
        user.setPassword(MD5PasswordEncoder.encode(accountBean.getPassword(), accountBean.getLoginName()));
        user.setPassword(accountBean.getPassword());
        userDao.updateUser(user);
    }
    @Override
    public PageModel<UserAccount> findAccountGridByParams(Map<String, Object> params, String page,String rows){
    	return findAccountGridByParams(params,page,rows,"","");
    }

    @Override
    public PageModel<UserAccount> findAccountGridByParams(Map<String, Object> params, String page,String rows,String sortBy,String ascDesc) {
        PageModel<UserAccount> pageBean = new PageModel<UserAccount>();
        try {
            pageBean.setPage(Integer.valueOf(page));
            pageBean.setLimit(Integer.valueOf(rows));
        } catch (NumberFormatException e) {
            logger.info(e.getMessage());
        }
        pageBean.setRecords(this.userDao.countUserByParams(params));
        if (pageBean.getTotal() > 0) {
            List<User> userAccountList = this.userDao.findUserByParams(params, pageBean.getPage(), pageBean.getLimit(),sortBy,ascDesc);
            for (User user : userAccountList) {
                pageBean.addRow((UserAccount) user);
            }
        } else {
            pageBean.setPage(1);
        }
        return pageBean;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateRoleAuthorized(String uid, String[] roles) throws CustomException {
        User user = userDao.loadUser(uid);
        user.getRoles().clear();
        //未选择任何角色时角色数组为null，添加非空验证
        if (roles != null) {
            for (String r : roles) {
            	if(r != null && !"".equals(r))
            		user.addRole(roleDao.getRole(r));
            }
        }
        userDao.updateUser(user);
    }
}
