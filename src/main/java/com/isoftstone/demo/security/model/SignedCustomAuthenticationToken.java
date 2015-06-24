package com.isoftstone.demo.security.model;

import java.util.Collection;

import org.springframework.security.authentication.AbstractAuthenticationToken;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-04-21
 * Time: 16:35
 * To change this template use File | Settings | File Templates.
 */
public class SignedCustomAuthenticationToken extends AbstractAuthenticationToken {

    private String requestSignature;

    public SignedCustomAuthenticationToken(String requestSignature) {
        super((Collection) null);
        this.requestSignature = requestSignature;
    }

    public String getRequestSignature() {
        return requestSignature;
    }

    public void setRequestSignature(String requestSignature) {
        this.requestSignature = requestSignature;
    }

    @Override
    public Object getCredentials() {
        return null;
    }

    @Override
    public Object getPrincipal() {
        return this.requestSignature;
    }
}
