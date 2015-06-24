package com.isoftstone.demo.common.web.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
@RequestMapping("/portal/link")
public class PortalLinkController {
	public PortalLinkController() {
	}
	/***
	 * 平台价值
	 * */
	@RequestMapping("/platformValue")
	public ModelAndView platformValue(){
		return new ModelAndView("/portal/link/platformValue.jsp");
	}
	/***
	 * 平台服务
	 * */
	@RequestMapping("/platformService")
	public ModelAndView platformService(){
		return new ModelAndView("/portal/link/platformService.jsp");
	}
	/***
	 * 隐私政策
	 * */
	@RequestMapping("/privacyPolicy")
	public ModelAndView privacyPolicy(){
		return new ModelAndView("/portal/link/privacyPolicy.jsp");
	}
	/***
	 * 法律声明
	 * */
	@RequestMapping("/lawStatement")
	public ModelAndView lawStatement(){
		return new ModelAndView("/portal/link/lawStatement.jsp");
	}
	/***
	 * 联系我们
	 * */
	@RequestMapping("/contactUs")
	public ModelAndView contactUs(){
		return new ModelAndView("/portal/link/contactUs.jsp");
	}
	/***
	 * 关于我们
	 * */
	@RequestMapping("/aboutUs")
	public ModelAndView aboutUs(){
		return new ModelAndView("/portal/link/aboutUs.jsp");
	}
	
}
