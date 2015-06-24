package com.isoftstone.demo.common.web.controller;

import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.isoftstone.demo.security.util.SecurityUtils;
import com.isoftstone.demo.userManager.constants.UserConstants.identity;
import com.isoftstone.demo.userManager.constants.UserConstants.survival;
import com.isoftstone.demo.userManager.model.User;

@Controller
@RequestMapping()
public class IndexController {

    @Value("${security.use.ValidateCode}")
    private String allowEmptyValidateCode = "false";

    @Autowired
    private Producer captchaProducer;
    

    private RequestCache requestCache = new HttpSessionRequestCache();

    @RequestMapping("/signin")
    public ModelAndView signin(Model model, HttpServletRequest request,HttpServletResponse response) {
        model.addAttribute("showCode", "true".equals(allowEmptyValidateCode));

        SavedRequest savedRequest = requestCache.getRequest(request, response);
        if(savedRequest != null){
	        String targetUrl = savedRequest.getRedirectUrl();
	        if(targetUrl != null && targetUrl.contains("/portal/")){
	        	return new ModelAndView("redirect:/portal/login.vhtml");
	        }
        }
        return new ModelAndView("/pages/security/signin.jsp");
    }

    @RequestMapping("/welcome")
    public ModelAndView index(HttpServletRequest request) {
    	User user = SecurityUtils.getUserInfoDetails();
    	request.setAttribute("user",user);
        return new ModelAndView("/pages/security/welcome.jsp");
    }
    @RequestMapping("/login")
    public ModelAndView login(){
    	User user = SecurityUtils.getUserInfoDetails();
    	if(identity.ACCOUNT.equals(user.getIdentity())){
    		return new ModelAndView("redirect:/welcome.vhtml");
    	}
    	if(identity.PERSONA.equals(user.getIdentity())){
    		if(survival.VERIFY.equals(user.getSurvival())){
    			return new ModelAndView("redirect:/portal/user/waitVerifyMail.vhtml?ticket="+user.getUuid());
    		}else{
    			return new ModelAndView("redirect:/portal/index.vhtml");
    		}
    	}
    	return new ModelAndView("");
    }

    @RequestMapping("/captcha")
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

        response.setDateHeader("Expires", 0);
        // Set standard HTTP/1.1 no-cache headers.
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        // Set IE extended HTTP/1.1 no-cache headers (use addHeader).
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        // Set standard HTTP/1.0 no-cache header.
        response.setHeader("Pragma", "no-cache");
        // return a jpeg
        response.setContentType("image/jpeg");
        // create the text for the image
        String capText = captchaProducer.createText();
        // store the text in the session
        request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);
        // create the image with the text
        BufferedImage bi = captchaProducer.createImage(capText);
        ServletOutputStream out = response.getOutputStream();
        // write the data out
        ImageIO.write(bi, "jpg", out);
        try {
            out.flush();
        } finally {
            out.close();
        }
        return null;
    }
}
