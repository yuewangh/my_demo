package com.isoftstone.demo.security.service;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.util.Assert;

import com.isoftstone.demo.security.model.SignedCustomAuthenticationToken;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-04-21
 * Time: 16:36
 * To change this template use File | Settings | File Templates.
 */
public class CustomAuthenticationProvider implements AuthenticationProvider {

    private UserDetailsService userDetailsService;

    public void setUserDetailsService(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

        Assert.isInstanceOf(SignedCustomAuthenticationToken.class, authentication, "数据异常");
        String username = authentication.getPrincipal() == null ? "NONE_PROVIDED" : authentication.getName();

        //username
        System.out.println("user name: " + authentication.getName());
        //password
        System.out.println("password: " + authentication.getCredentials());


        UserDetails userDetails = (UserDetails) this.userDetailsService.loadUserByUsername(authentication.getName());

        UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(
                userDetails, authentication.getCredentials(), userDetails.getAuthorities());
        return result;
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return SignedCustomAuthenticationToken.class.isAssignableFrom(aClass);
    }
}