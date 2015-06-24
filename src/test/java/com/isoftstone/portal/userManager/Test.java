package com.isoftstone.portal.userManager;

import com.isoftstone.demo.security.util.CustomPasswordEncoder;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CustomPasswordEncoder md5 = new CustomPasswordEncoder();
		System.out.println("summer    :"+md5.encodePassword("123456", "summer"));
//		System.out.println("18518225359    :"+md5.encode("123456", "18518225359"));
//		System.out.println("member004    :"+md5.encode("123456", "member004"));
//		System.out.println("ceshi429    :"+md5.encode("123456", "ceshi429"));
	}

}
