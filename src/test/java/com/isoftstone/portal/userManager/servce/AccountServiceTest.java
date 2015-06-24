package com.isoftstone.portal.userManager.servce;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.isoftstone.demo.userManager.constants.GenderFormat;
import com.isoftstone.demo.userManager.constants.UserConstants;
import com.isoftstone.demo.userManager.model.UserAccount;
import com.isoftstone.demo.userManager.service.AccountService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring-*.xml"})
public class AccountServiceTest {

    @Autowired
    AccountService accountService;

    @Test
    public void testSaveUserAccountBean() throws Exception {

        UserAccount accountBean = new UserAccount();
        accountBean.setLoginName("admin");
        accountBean.setPassword("admins");
        accountBean.setSurvival(UserConstants.survival.ENABLE);
        accountBean.setIdentity(UserConstants.identity.ACCOUNT);
        accountBean.setName("后台管理员");
        accountBean.setGender(GenderFormat.MALE);
        accountBean.setJob("管理员");
        accountBean.setMail("admin@mail.com");
        accountService.saveUserAccountBean(accountBean);
        accountService.findUserBeanByLoginName("lidey");
        accountBean.getUuid();
    }

    /*@Test
    public void testUpdateUserAccountBean() throws Exception {
        UserAccount accountBean = accountService.findUserBeanByLoginName("admin");
        accountBean.setIdentity(UserConstants.identity.ACCOUNT);
        accountService.saveUserAccountBean(accountBean);
    }*/
}