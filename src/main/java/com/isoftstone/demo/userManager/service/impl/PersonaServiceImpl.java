package com.isoftstone.demo.userManager.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.common.util.MD5PasswordEncoder;
import com.isoftstone.demo.userManager.constants.UserConstants.identity;
import com.isoftstone.demo.userManager.model.User;
import com.isoftstone.demo.userManager.model.UserPersona;
import com.isoftstone.demo.userManager.service.PersonaService;

/**
 * Created by lidey on 14-7-13.
 */
@Service(value="personaService")
@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
public class PersonaServiceImpl extends UserServiceImpl<UserPersona> implements PersonaService {

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void updatePersonaInfo(UserPersona userBean) throws CustomException {

        UserPersona userPersona = (UserPersona) userDao.getUser(userBean.getUuid());
        if(userBean.getMail() != null && !"".equals(userBean.getMail()))
        	userPersona.setMail(userBean.getMail());
        userPersona.setName(userBean.getName());
        userPersona.setAddress(userBean.getAddress());
        if(userBean.getTel() != null && !"".equals(userBean.getTel()))
        	userPersona.setTel(userBean.getTel());
        userPersona.setBirthday(userBean.getBirthday());
        userPersona.setGender(userBean.getGender());
        userPersona.setJobInfo(userBean.getJobInfo());
        userPersona.setUnit(userBean.getUnit());
        if (userBean.getSurvival() != null)
            userPersona.setSurvival(userBean.getSurvival());
        userDao.updateUser(userPersona);
    }

	@Override
	public PageModel<UserPersona> findPersonaGridByParams(
			Map<String, Object> params, String page, String rows) {
		return findPersonaGridByParams(params,page,rows,"","");
	}
	@Override
	public PageModel<UserPersona> findPersonaGridByParams(
			Map<String, Object> params, String page, String rows,String sortBy,String ascDesc) {
		PageModel<UserPersona> pageBean = new PageModel<UserPersona>();
        try {
            pageBean.setPage(Integer.valueOf(page));
            pageBean.setLimit(Integer.valueOf(rows));
        } catch (NumberFormatException e) {
            logger.info(e.getMessage());
        }
        pageBean.setRecords(this.userDao.countUserByParams(params));
        if (pageBean.getTotal() > 0) {
            List<User> userList = this.userDao.findUserByParams(params, pageBean.getPage(), pageBean.getLimit(),sortBy,ascDesc);
            for (User user : userList) {
                pageBean.addRow((UserPersona) user);
            }
        } else {
            pageBean.setPage(1);
        }
        return pageBean;
	}

	@Override
    @Transactional(propagation = Propagation.REQUIRED)
	public void savePersonaInfo(UserPersona userPersona) throws CustomException {
		// TODO Auto-generated method stub\
		userPersona.setPassword(MD5PasswordEncoder.encode(userPersona.getPassword(),userPersona.getLoginName()));
		userPersona.setIdentity(identity.PERSONA);
		userDao.saveUser(userPersona);
	}
}
