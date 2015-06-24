package com.isoftstone.demo.security.web.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.TextEscapeUtils;

import com.google.code.kaptcha.Constants;
import com.isoftstone.demo.security.model.SignedCustomAuthenticationToken;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-04-21
 * Time: 16:37
 * To change this template use File | Settings | File Templates.
 */
public class CustomLoginFilter extends
        UsernamePasswordAuthenticationFilter {


    private boolean postOnly = true;
    private boolean allowEmptyValidateCode = false;
    private String validateCodeParameter = DEFAULT_VALIDATE_CODE_PARAMETER;
    public static final String SPRING_SECURITY_LAST_USERNAME_KEY = "SPRING_SECURITY_LAST_USERNAME";
    // session中保存的验证码
    // 输入的验证码
    public static final String DEFAULT_VALIDATE_CODE_PARAMETER = "j_code";

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request,
                                                HttpServletResponse response) throws AuthenticationException {
        if (postOnly && !request.getMethod().equals("POST")) {
            throw new AuthenticationServiceException(
                    "Authentication method not supported: "
                            + request.getMethod());
        }

        String username = obtainUsername(request);
        String password = obtainPassword(request);

        if (username == null) {
            username = "";
        }

        if (password == null) {
            password = "";
        }

        username = username.trim();

        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(
                username, password);

        // Place the last username attempted into HttpSession for views
        HttpSession session = request.getSession(false);

        if (session != null || getAllowSessionCreation()) {
            request.getSession().setAttribute(
                    SPRING_SECURITY_LAST_USERNAME_KEY,
                    TextEscapeUtils.escapeEntities(username));
        }

        //测试自定义投票器
        if ("lidey".equals(username)) {
            return this.getAuthenticationManager().authenticate(new SignedCustomAuthenticationToken(username));
        }

        // Allow subclasses to set the "details" property
        setDetails(request, authRequest);
        // check validate code
        if (isAllowEmptyValidateCode())
            checkValidateCode(request);

        return this.getAuthenticationManager().authenticate(authRequest);
    }

    /**
     * <li>比较session中的验证码和用户输入的验证码是否相等</li>
     */
    protected void checkValidateCode(HttpServletRequest request) {
        String sessionValidateCode = obtainSessionValidateCode(request);
        String validateCodeParameter = obtainValidateCodeParameter(request);
        if (StringUtils.isEmpty(validateCodeParameter)
                || !sessionValidateCode.equalsIgnoreCase(validateCodeParameter)) {
            throw new AuthenticationServiceException(this.messages.getMessage("AbstractUserDetailsAuthenticationProvider.badCode", new Object[]{}, "您输入的验证码错误！"));
        }
    }

    private String obtainValidateCodeParameter(HttpServletRequest request) {
        return request.getParameter(validateCodeParameter);
    }

    protected String obtainSessionValidateCode(HttpServletRequest request) {
        Object obj = request.getSession()
                .getAttribute(Constants.KAPTCHA_SESSION_KEY);
        return null == obj ? "" : obj.toString();
    }

    public boolean isPostOnly() {
        return postOnly;
    }

    @Override
    public void setPostOnly(boolean postOnly) {
        this.postOnly = postOnly;
    }

    public boolean isAllowEmptyValidateCode() {
        return allowEmptyValidateCode;
    }

    public void setAllowEmptyValidateCode(boolean allowEmptyValidateCode) {
        this.allowEmptyValidateCode = allowEmptyValidateCode;
    }
}