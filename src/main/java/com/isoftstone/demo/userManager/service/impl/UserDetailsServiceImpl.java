package com.isoftstone.demo.userManager.service.impl;

import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Hibernate;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.isoftstone.demo.role.model.Resource;
import com.isoftstone.demo.role.model.Role;
import com.isoftstone.demo.userManager.constants.UserConstants;
import com.isoftstone.demo.userManager.model.User;
import com.isoftstone.demo.userManager.model.UserAccount;
import com.isoftstone.demo.userManager.model.UserPersona;

@Service(value = "userDetailsService")
@Transactional(propagation= Propagation.NOT_SUPPORTED,readOnly=true)
public class UserDetailsServiceImpl extends UserServiceImpl<User> implements UserDetailsService {

	public UserDetailsServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public UserDetails loadUserByUsername(String s)
			throws UsernameNotFoundException {
        if (StringUtils.isEmpty(s))
            throw new UsernameNotFoundException("用户名 : " + s + " 未找到.");
        User user = userDao.findUserByLoginName(s);
        Role roleBean = null;
        if (user == null)
            throw new UsernameNotFoundException("用户名 : " + s + " 未找到.");
        switch (user.getIdentity()) {
            case PERSONA:
            	UserPersona personaBean = (UserPersona)user;
                roleBean = new Role();
                roleBean.setKey("SYSTEM_USER");
                personaBean.addRole(roleBean);
                roleBean = new Role();
                if(UserConstants.survival.ENABLE==user.getSurvival()) {
                    roleBean.setKey("SYSTEM_PERSONA");
                }else{
                    roleBean.setKey("SYSTEM_VERIFY");
                }
                personaBean.addRole(roleBean);
                return personaBean;
            /*case COMPANY:
                UserCompanyBean companyBean = new UserCompanyBean(user);
                roleBean = new RoleBean();
                roleBean.setKey("SYSTEM_USER");
                companyBean.addRoleBean(roleBean);
                roleBean = new RoleBean();
                if(SurvivalFormat.ENABLE==user.getSurvival()) {
                    roleBean.setKey("SYSTEM_PERSONA");
                }else{
                    roleBean.setKey("SYSTEM_VERIFY");
                }
                companyBean.addRoleBean(roleBean);
                return companyBean;*/
            case ACCOUNT:
                UserAccount accountBean = (UserAccount)user;
                roleBean = new Role();
                roleBean.setKey("SYSTEM_USER");
                accountBean.addRole(roleBean);
                roleBean = new Role();
                roleBean.setKey("SYSTEM_ACCOUNT");
                accountBean.addRole(roleBean);
                if(user.getLoginName().equals("admin")){
                	roleBean = new Role();
                    roleBean.setKey("SYS_SUPER");
                    accountBean.addRole(roleBean);
                }
                Hibernate.initialize(user.getRoles());
                for (Role role : user.getRoles()) {
                    if (!role.isSurvivalStatus())
                        continue;
                    roleBean = role;
                    accountBean.addRole(roleBean);
                    Hibernate.initialize(role.getPrivileges());
                    Set<Resource> resources = role.getPrivileges();
                    for (Resource r : resources) {
                        accountBean.addGrantedAuthority(r);
                    }
                }
                return accountBean;
            default:
                throw new UsernameNotFoundException("用户名 : " + s + " 不能正确识别用户身份信息.");
        }
    }
	
	

}
