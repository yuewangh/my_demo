package com.isoftstone.demo.userManager.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.userManager.model.User;
import com.isoftstone.demo.userManager.model.UserPersona;
import com.isoftstone.demo.userManager.service.UserService;

@Controller
@RequestMapping("/portal/user")
public class UserPortalController<T extends User> {
	@Autowired
	@Qualifier("userService")
	UserService<User> userService;
	T user;

	private String getVerifyUrl(HttpServletRequest request) {
        StringBuilder verifyUrl = new StringBuilder();
        verifyUrl.append(request.getScheme());
        verifyUrl.append("://");
        verifyUrl.append(request.getServerName());
        verifyUrl.append(":");
        verifyUrl.append(request.getServerPort());
        verifyUrl.append(request.getContextPath());
        verifyUrl.append("/portal/user/verifyMail.vhtml?ticket=");
        return verifyUrl.toString();
    }

    /**
     * @return
     */
    private String getActivationMailUrl(HttpServletRequest request) {
        StringBuilder verifyUrl = new StringBuilder();
        verifyUrl.append(request.getScheme());
        verifyUrl.append("://");
        verifyUrl.append(request.getServerName());
        verifyUrl.append(":");
        verifyUrl.append(request.getServerPort());
        verifyUrl.append(request.getContextPath());
        verifyUrl.append("/portal/user/activationMail.vhtml?ticket=");
        return verifyUrl.toString();
    }


    /**
     * @return
     */
    private String getChangePasswordUrl(HttpServletRequest request) {
        StringBuilder verifyUrl = new StringBuilder();
        verifyUrl.append(request.getScheme());
        verifyUrl.append("://");
        verifyUrl.append(request.getServerName());
        verifyUrl.append(":");
        verifyUrl.append(request.getServerPort());
        verifyUrl.append(request.getContextPath());
        verifyUrl.append("/portal/user/changePassword.vhtml?ticket=");
        return verifyUrl.toString();
    }

    /**
     * @return
     */
    @RequestMapping("/register")
    public ModelAndView register(@ModelAttribute UserPersona userBean,HttpServletRequest request) {
        try {
            String challengeResponse = request.getParameter("code");
            String captchaID = (String)request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY);
            //获取输入的验证码
            if(challengeResponse != null && challengeResponse.equals(captchaID)){
                user = (T) userService.register(userBean, getVerifyUrl(request));
                request.setAttribute("ticket", userBean.getUuid());
                return new ModelAndView("redirect:waitVerifyMail.vhtml?ticket="+userBean.getUuid());
            }else{
                request.setAttribute("errMsg","你输入的验证码错误，请重新输入");
                request.setAttribute("userInfo",userBean);
                return new ModelAndView("/portal/security/register.jsp");
            }
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("userInfo",userBean);
            request.setAttribute("errMsg","系统异常，请联系系统管理员!");
        }
        return new ModelAndView("/portal/security/register.jsp");
    }

    /**
     * @return
     */
    @RequestMapping("/waitVerifyMail")
    public ModelAndView message(@RequestParam(value="ticket",defaultValue="")String ticket,@RequestParam(value="uuid",defaultValue="")String uuid,HttpServletRequest request) {
        request.setAttribute("title","消息提示");
        request.setAttribute("subTitle","等待邮件验证");
        String href = "#";
        if (StringUtils.isNotEmpty(ticket)) {
        	href = getActivationMailUrl(request)+ticket;
        }

        if (StringUtils.isNotEmpty(uuid)) {
        	href = getActivationMailUrl(request)+uuid;
        }
        request.setAttribute("message", "您的账号已经注册成功，正在等待邮件确认，请尽快登录您的邮箱激活账号，没有收到邮件点击<a href=\""+href+"\"><button>重新发送</button>。</a>");//this.getText("USER.VERIFY.WAIT.MESSAGE", new String[]{getActivationMailUrl() + ticket}));
        return new ModelAndView("/portal/security/message.jsp");
    }

    /**
     * @return
     */
    @RequestMapping("activationMail")
    public ModelAndView activationMail(@RequestParam(value="ticket",required=true)String ticket,HttpServletRequest request) {
        if (StringUtils.isNotEmpty(ticket)) {
            try {
				userService.activationMail(ticket, getVerifyUrl(request));
	            request.setAttribute("subTitle","邮件发送成功");
	            String href = getActivationMailUrl(request) + ticket;
	            request.setAttribute("message", "您的激活邮件已经发送成功，请尽快登录您的邮箱激活账号，没有收到邮件点击<a href=\""+href+"\"><button>重新发送</button>。</a>");
			} catch (CustomException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
	            request.setAttribute("subTitle","邮件发送失败");
	            request.setAttribute("message", "系统异常，请稍候重试，如再次失败请联系系统管理员");
			}
            request.setAttribute("title","消息提示");
        }
        return new ModelAndView("/portal/security/message.jsp");
    }

    /**
     * @return
     */
    @RequestMapping("/changePassword")
    public ModelAndView changePassword(@RequestParam(value="ticket",required=true)String ticket,HttpServletRequest request) {
        String uuid = userService.getUuidByTicket(ticket);
        if (StringUtils.isNotEmpty(uuid)) {
            this.user = (T) new User();
            user.setUuid(uuid);
            request.setAttribute("userInfo",user);
            return new ModelAndView("/portal/security/changePassword.jsp");
        } else {
            request.setAttribute("title","消息提示");
            request.setAttribute("message","您的找回密码邮件已经过期，请重新找回密码。");
        }
        return new ModelAndView("/portal/security/message.jsp");
    }


    /**
     * @return
     */
    @RequestMapping("savePassword")
    public ModelAndView savePassword(@ModelAttribute User user,HttpServletRequest request) {
        request.setAttribute("title","消息提示");
    	try{
    		String rePassword = request.getParameter("rePassword");
	        if (user.getPassword().equals(rePassword)) {
	            userService.savePassword(user);
	            request.setAttribute("message","您的密码修改成功。");
	        }else{
	            request.setAttribute("message","两次输入的密码不一致。");
	        }
    	}catch(Exception e){
    		e.printStackTrace();
    		request.setAttribute("message","系统异常！请重试！");
    	}
        return new ModelAndView("/portal/security/message.jsp");
    }

    @RequestMapping("verifyMail")
    public ModelAndView verifyMail(@RequestParam(value="ticket",required=true)String ticket,HttpServletRequest request) {
        if (StringUtils.isNotEmpty(ticket)) {
            try {
                userService.activationUser(ticket);
                request.setAttribute("message","您的账号激活成功，可以正常登录平台。");
            } catch (Exception e) {
                if ("NOT_VERIFY".equals(e.getMessage()))
                    request.setAttribute("message","您的账号已经激活成功，账号不能重复激活。");
            }
            request.setAttribute("title","消息提示");
            request.setAttribute("subTitle","邮件验证成功！");
            request.setAttribute("message", "您的账号激活成功，可以正常登录平台。<script>alert(\"邮件验证成功！\")</script>");
        } else {

        }
        return new ModelAndView("/portal/security/message.jsp");
    }

    /**
     * @return
     */
    @RequestMapping("/forgetPassword")
    public ModelAndView forgetPassword(@RequestParam(value="loginName",required=true)String loginName,@RequestParam(value="registerMail",required=true)String registerMail,HttpServletRequest request) {
        if (StringUtils.isNotEmpty(loginName)) {
            try {
				userService.forgetPassword(loginName,registerMail, getChangePasswordUrl(request));
	            request.setAttribute("title","消息提示");
	            request.setAttribute("message","您的找回密码邮件发送成功，请尽快登录您的邮箱修改密码。");
			} catch (CustomException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
	            request.setAttribute("title","消息提示");
	            request.setAttribute("message","您输入的用户或邮箱不正确！邮箱必须与注册用户时填写的邮箱一致！。");
			}
        } else {

        }
        return new ModelAndView("/portal/security/message.jsp");
    }
}
