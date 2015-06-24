/**
 * 
 */
package com.isoftstone.demo.security.util;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import com.isoftstone.demo.userManager.model.User;

/**
 * @author 姚丰利(lidey)
 * 创建时间：2012-8-7 上午09:59:57 
 */
public class SecurityUtils {
	
	/**
	 * 
	 * @return
	 */
	public static User getUserInfoDetails() {
		User user=null;
		try{
			SecurityContext sc = SecurityContextHolder.getContext();   
		    Authentication auth = sc.getAuthentication();   
		    Object principal = auth.getPrincipal();   
		    if (principal instanceof User) {
		    	user = (User) principal;
		    } 
		}catch(Exception e){
			e.printStackTrace();
		}
	    return user;
	}
	
}
