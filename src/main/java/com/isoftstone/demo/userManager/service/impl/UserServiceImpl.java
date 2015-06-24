package com.isoftstone.demo.userManager.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.isoftstone.demo.cache.service.CacheService;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.common.util.MD5PasswordEncoder;
import com.isoftstone.demo.common.util.StringUtil;
import com.isoftstone.demo.common.util.TemplateUtil;
import com.isoftstone.demo.mail.service.SendMailService;
import com.isoftstone.demo.role.dao.RoleDao;
import com.isoftstone.demo.role.model.Role;
import com.isoftstone.demo.userManager.constants.UserConstants;
import com.isoftstone.demo.userManager.constants.UserConstants.identity;
import com.isoftstone.demo.userManager.constants.UserConstants.survival;
import com.isoftstone.demo.userManager.dao.UserDao;
import com.isoftstone.demo.userManager.model.User;
import com.isoftstone.demo.userManager.model.UserAccount;
import com.isoftstone.demo.userManager.model.UserPersona;
import com.isoftstone.demo.userManager.service.UserService;

import freemarker.cache.ClassTemplateLoader;
import freemarker.cache.TemplateLoader;
import freemarker.template.TemplateException;

/**
 * Created by lidey on 14-6-25.
 */
@Service(value="userService")
@Transactional(propagation= Propagation.NOT_SUPPORTED,readOnly=true)
public class UserServiceImpl<T extends User> implements UserService<T> {

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    protected UserDao userDao;
    @Autowired
    protected RoleDao roleDao;
    @Autowired
    private SendMailService sendMailServie;
    @Autowired
    private CacheService userCacheService;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
    public void setSendMailServie(SendMailService sendMailServie) {
        this.sendMailServie = sendMailServie;
    }

    public void setUserCacheService(CacheService userCacheService) {
        this.userCacheService = userCacheService;
    }

    @Override
    public PageModel<T> findUserGridByParams(Map<String, Object> params, String page) {
    	return findUserGridByParams(params,page,"","");
    }
    @Override
    public PageModel<T> findUserGridByParams(Map<String, Object> params, String page,String sortBy,String ascDesc) {
        PageModel<T> pageBean = new PageModel<T>();
        try {
            pageBean.setPage(Integer.valueOf(page));
        } catch (NumberFormatException e) {
            logger.info(e.getMessage());
        }

        pageBean.setRecords(this.userDao.countUserByParams(params));
        if (pageBean.getRecords() > 0) {
            List<User> userAccountList = this.userDao.findUserByParams(params, pageBean.getPage(), pageBean.getLimit(),sortBy,ascDesc);
            for (User user : userAccountList) {
                pageBean.addRow((T) user);
            }
        } else {
            pageBean.setPage(1);
        }
        return pageBean;
    }

    @Override
    public T findUserBeanByUuid(String uuid) throws CustomException {
        User user = userDao.getUser(uuid);
        if (user == null)
            return null;
        User userBean = null;
        switch (user.getIdentity()) {
//            case COMPANY:
//                userBean = new UserCompanyBean(user);
//                break;
            case PERSONA:
                userBean = (UserPersona) user;
                break;
            case ACCOUNT:
                userBean = (UserAccount) user;
                break;
            default:
                userBean = user;
        }
        for (Role role : user.getRoles()) {
            userBean.addRole(role);
        }
        return (T) userBean;
    }

    @Override
    public T findUserBeanByLoginName(String loginName) {
        return (T)userDao.findUserByLoginName(loginName);
    }

    @Override
    public boolean validateLoginName(String loginName) {
        User user = userDao.findUserByLoginName(loginName);
        if (user != null)
            return false;
        else
            return true;
    }

    @Override
    public boolean validateEmail(String mail) {
        // TODO Auto-generated method stub
        User user = userDao.findUserByEmail(mail);
        if (user != null)
            return false;
        else
            return true;
    }

    @Override
    public boolean validateLoginName(String loginName, String uuid) {
        return false;
    }

    @Override
    @Transactional(propagation= Propagation.REQUIRED)
    public void resetPassword(String uuid, String oldPassword, String password) {

    }

    @Override
    @Transactional(propagation= Propagation.REQUIRED)
    public T register(T user, String url) {
        Map<String, Object> root = new HashMap<String, Object>();
        if("".equals(url)){
        	user.setSurvival(survival.ENABLE);
        }else{
        	user.setSurvival(UserConstants.survival.VERIFY);
        }
        user.setIdentity(identity.PERSONA);
        if(user.getPassword().length() != 32 )
        	user.setPassword(MD5PasswordEncoder.encode(user.getPassword(), user.getLoginName()));
        userDao.saveUser(user);
		if(!"".equals(url)){
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String path  = request.getScheme() + "://"
		            + request.getServerName() + ":" + request.getServerPort()
		            + request.getContextPath();
			root.put("url", url + user.getUuid());
	        root.put("user", user);
	        root.put("path", path);
	        sendMailServie.send(user.getMail(), "众创空间-云享客平台:账号激活", getTempContent(root, "activationMail.ftl"));
		}
        
        return user;
    }

    @Override
    @Transactional(propagation= Propagation.REQUIRED)
    public void activationUser(String ticket) throws CustomException {
        User user = userDao.loadUser(ticket);
        if (user != null) {
            if (user.getSurvival() != UserConstants.survival.VERIFY)
                throw new CustomException("NOT_VERIFY");
            user.setSurvival(UserConstants.survival.ENABLE);
            userDao.updateUser(user);
        }
    }

    @Override
    public void activationMail(String ticket, String url) throws CustomException {
        Map<String, Object> root = new HashMap<String, Object>();
        User user = userDao.getUser(ticket);
        if (user != null) {
            root.put("url", url + user.getUuid());
            root.put("user", user);
            sendMailServie.send(user.getMail(), "众创空间-云享客平台:账号激活", getTempContent(root, "activationMail.ftl"));
        }
    }

    @Override
    public void forgetPassword(String loginName,String mail, String url) throws CustomException {
        Map<String, Object> root = new HashMap<String, Object>();
        String ticket = StringUtil.getRandomString(32);
        User user = userDao.findUserByLoginName(loginName);
        if (user != null && user.getMail().equals(mail)) {
            userCacheService.put(ticket, user.getUuid());
            root.put("url", url + ticket);
            root.put("user", user);
            sendMailServie.send(user.getMail(), "众创空间-云享客平台:密码找回", getTempContent(root, "forgetPasswordMail.ftl"));
        } else {
        	throw new CustomException();
        }
    }

    @Override
    public String getUuidByTicket(String ticket) {
        String uuid = null;
        Object uuidObj = userCacheService.get(ticket);
        if (uuidObj != null) {
            uuid = uuidObj.toString();
            userCacheService.remove(ticket);
        }
        return uuid;
    }

    @Override
    @Transactional(propagation= Propagation.REQUIRED)
    public void savePassword(User userBean) throws CustomException {
        User user = userDao.loadUser(userBean.getUuid());
        if (user != null) {
        	if(userBean.getPassword().length() != 32){
        		user.setPassword(MD5PasswordEncoder.encode(userBean.getPassword(), user.getLoginName()));
        	}else{
        		user.setPassword(userBean.getPassword());
        	}
//            user.setPassword(userBean.getPassword());
            userDao.updateUser(user);
        }
    }

    @Override
    @Transactional(propagation= Propagation.REQUIRED)
    public void deleteUserByUuid(String uuid) {
        userDao.logicDeleteUser(uuid);
    }

    /**
     * @param root
     * @param name
     * @return
     */
    private String getTempContent(Map<String, Object> root, String name) {
        try {
            TemplateLoader templateLoader = new ClassTemplateLoader(UserService.class, "template/");
            return TemplateUtil.formatString(root, templateLoader, name);
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (TemplateException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return null;
    }

}
