package com.isoftstone.portal.userManager.dao.impl;

import com.isoftstone.demo.userManager.constants.IdentityEnum;
import com.isoftstone.demo.userManager.constants.SurvivalFormat;
import com.isoftstone.demo.userManager.constants.UserConstants;
import com.isoftstone.demo.userManager.dao.UserDao;
import com.isoftstone.demo.userManager.model.UserPersona;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring-*.xml",
        "classpath*:/com/isoftstone/demo/*/config/applicationContext-*.xml"})
//@Transactional 是否回滚
public class UserDaoImplTest {

    @Autowired
    private UserDao userDao;

    @Test
    public void testAddPersona() throws Exception {
        String userName = "persona";
        UserPersona userPersona=new UserPersona();
        userPersona.setLoginName(userName);
//        userPersona.setPassword(MD5.sign("123456","persona","utf8"));
        userPersona.setMail("persona@163.com");
        userPersona.setIdentity(UserConstants.identity.PERSONA);
        userPersona.setSurvival(UserConstants.survival.ENABLE);
        userPersona.setAddress("陕西省西安市");
        //userPersona.setJob("果农");
        userPersona.setTel("13800138000");
        userPersona.setName("个人会员一");
        userDao.saveUser(userPersona);
//        Assert.assertNotNull(userDao.findUserByLoginName(userName));
//        User user = userDao.findUserByLoginName("admin");
//        user.setIdentity(IdentityEnum.ACCOUNT);
//        userDao.saveUser(user);
    }

    @Test
    public void testAddCompany() throws Exception {
//        String userName = "company";
//        UserCompany userPersona=new UserCompany();
//        userPersona.setLoginName(userName);
//        userPersona.setPassword(MD5.sign("123456","company","utf8"));
//        userPersona.setMail("company@163.com");
//        userPersona.setIdentity(IdentityEnum.COMPANY);
//        userPersona.setSurvival(SurvivalFormat.ENABLE);
//        userPersona.setName("企业会员一");
//        userPersona.setAddress("陕西省延安市");
//        userPersona.setContacts("张三");
//        userPersona.setTel("13800138000");
//        userDao.saveUser(userPersona);
//        Assert.assertNotNull(userDao.findUserByLoginName(userName));
    }
}