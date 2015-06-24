package com.isoftstone.demo.security.util;

import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.authentication.encoding.MessageDigestPasswordEncoder;

/**
* 项目名称：demo   
* 类名称：CustomPasswordEncoder   
* 类描述：   为对应前台jquery md5加密言后与后台加密方式不一样，如下实现 密码+登录名称组合后通过md5不加密言方式生成密码
* 创建人：xlzhangf   
* 创建时间：2015年4月29日 下午1:39:16   
* 修改人：xlzhangf   
* 修改时间：2015年4月29日 下午1:39:16   
* 修改备注：   
* @version    
*
 */
@SuppressWarnings("deprecation")
public class CustomPasswordEncoder extends Md5PasswordEncoder {

	@Override
	public String encodePassword(String rawPass, Object salt) {
        super.setEncodeHashAsBase64(false);
        String pwd = super.encodePassword(rawPass+salt, "");
        return pwd;
	}

	@Override
	public boolean isPasswordValid(String encPass, String rawPass, Object salt) {
		// TODO Auto-generated method stub
		super.setEncodeHashAsBase64(false);

        return super.isPasswordValid(encPass, rawPass+salt, "");
	}

}
