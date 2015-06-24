package com.isoftstone.demo.security.web.support;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-03-20
 * Time: 15:45
 * To change this template use File | Settings | File Templates.
 */
public class CustomLoginHandler extends
        SavedRequestAwareAuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response, Authentication authentication)
            throws ServletException, IOException {
        super.onAuthenticationSuccess(request, response, authentication);

        //这里可以追加开发人员自己的额外处理

    }
}
