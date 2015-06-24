package com.isoftstone.portal.userManager.servce.impl;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring-*.xml",
        "classpath*:/com/isoftstone/demo/*/config/applicationContext-*.xml"})
@Transactional
public class UserDetailsServiceImplTest {

    @Autowired
    private UserDetailsService userDetailsService;

    @Test
    public void testLoadUserByUsername() throws Exception {
        String username="persona";
        UserDetails userDetails=userDetailsService.loadUserByUsername(username);
        Assert.assertNotNull(userDetails);
        Assert.assertTrue(userDetails.isEnabled());
    }
}