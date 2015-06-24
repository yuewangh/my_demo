package com.isoftstone.demo.userManager.web.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.common.util.MD5PasswordEncoder;
import com.isoftstone.demo.operation_log.enumeration.ModeName;
import com.isoftstone.demo.operation_log.model.Log;
import com.isoftstone.demo.role.model.Role;
import com.isoftstone.demo.role.service.RoleService;
import com.isoftstone.demo.security.util.SecurityUtils;
import com.isoftstone.demo.userManager.constants.UserConstants;
import com.isoftstone.demo.userManager.constants.UserConstants.identity;
import com.isoftstone.demo.userManager.constants.UserConstants.survival;
import com.isoftstone.demo.userManager.model.User;
import com.isoftstone.demo.userManager.model.UserAccount;
import com.isoftstone.demo.userManager.service.AccountService;
import com.isoftstone.demo.userManager.service.UserService;

@Controller
@RequestMapping("/system/account")
public class AccountUserController {
	@Autowired
	AccountService accountService;
	@Autowired
	UserService<UserAccount> userService;
	@Autowired
	RoleService roleService;
	@InitBinder("userInfoBean")    
    public void initBinder2(WebDataBinder binder) {    
            binder.setFieldDefaultPrefix("userInfoBean.");    
    }    
	/**
	* @Title: index 
	* @Description: TODO 进入用户管理首页
	* @param @return
	* @return ModelAndView
	* @throws
	 */
	@RequestMapping("/index")
	public ModelAndView index(){
		return new ModelAndView("/pages/user/list.jsp");
	}
	/**
	* @Title: list 
	* @Description: TODO 异步获取用户列表信息
	* @param @param loginName
	* @param @param page
	* @param @return
	* @return PageModel<UserAccount>
	* @throws
	 */
    @RequestMapping(method = RequestMethod.GET, value = "/list", headers = "Accept=application/json")
	@ResponseBody
	public PageModel<UserAccount> list(
			@RequestParam(value="loginName",defaultValue="") String loginName,
			@RequestParam(value="name",defaultValue="") String name,
			@RequestParam(value="survival",defaultValue="") String survival,
			@RequestParam(value="page") String page,
			@RequestParam(value="rows")String rows,
			@RequestParam(value="sidx",required=false)String sidx,
			@RequestParam(value="sord",required=false)String sord){
		HashMap<String,Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotEmpty(loginName)){
			params.put("loginName",loginName);
		}
		if(StringUtils.isNotEmpty(name)){
			params.put("name",name);
		}
		if(StringUtils.isNotEmpty(survival)){
			params.put("survival",UserConstants.parseSurvival(survival));
		}
		params.put("identity",identity.ACCOUNT);
		PageModel<UserAccount> model = accountService.findAccountGridByParams(params, page,rows,sidx,sord);
		return model;
	}
    /**
    * @Title: add 
    * @Description: TODO 用户信息维护页面
    * @param @return
    * @return ModelAndView
    * @throws
     */
    @RequestMapping("/addView")
    public ModelAndView addView(){
    	return new ModelAndView("/pages/user/userInfo.jsp");
    }
    @RequestMapping("/updateView")
    public ModelAndView updateView(@RequestParam(value="uuid",defaultValue="") String uuid,Model model){
    	if(!"".equals(uuid)){
    		try {
    			//当前登录用户修改个人信息
    			if("changePwd".equals(uuid)){
    				User user = SecurityUtils.getUserInfoDetails();
    				uuid = user.getUuid();
    			}
    			model.addAttribute("userInfoBean",accountService.findUserBeanByUuid(uuid));
			} catch (CustomException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	return new ModelAndView("/pages/user/userInfo.jsp");
    }
    /**
    * @Title: saveUser 
    * @Description: TODO 保存用户信息
    * @param @param userInfoBean
    * @return UserAccount
    * @throws
     */
    @Log(type=ModeName.USER,content="")
    @RequestMapping("/saveUser")
    @ResponseBody
    public Map<String,Object> saveUser(@ModelAttribute UserAccount userInfoBean){
    	Map<String,Object> map = new HashMap<String,Object>();
    	boolean success = false;
    	String msg = "操作失败！";
//    	User user = SecurityUtils.getUserInfoDetails();
    	if(userInfoBean != null && StringUtils.isNotEmpty(userInfoBean.getUuid())){
    		try {
				accountService.updateUserAccountBean(userInfoBean);
				success = true;
				msg = "修改用户信息成功！";
			} catch (CustomException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				msg = "系统异常！请稍候重试！";
			}
    	}else{
    		userInfoBean.setRegisterDate(new Date());
    		userInfoBean.setSurvival(survival.ENABLE);
    		userInfoBean.setIdentity(identity.ACCOUNT);
    		accountService.saveUserAccountBean(userInfoBean);
			success = true;
			msg = "新增用户信息成功！";
    	}
    	map.put("bId",userInfoBean.getUuid());
    	map.put("content",msg);
    	map.put("success",success);
    	map.put("msg", msg);
    	return map;
    }
    @RequestMapping(method = RequestMethod.GET, value = "/validateLoginName", headers = "Accept=application/json")
    @ResponseBody
    public Boolean validateLoginName(@RequestParam(value="loginName",defaultValue="") String loginName,HttpServletRequest request) {
        boolean exist = this.userService.validateLoginName(loginName);
        return exist;
    }
    /**
	* @Title: validateMail 
	* @Description: TODO 验证邮箱地址是否已经注册过
	* @param @param email
	* @param @param request
	* @param @return
	* @return Boolean
	* @throws
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/validateMail", headers = "Accept=application/json")
    @ResponseBody
    public Boolean validateMail(@RequestParam(value="email",required=true) String email,HttpServletRequest request) {
        boolean exist = this.userService.validateEmail(email);
        return exist;
    }

	@RequestMapping(method = RequestMethod.GET, value = "/validateCaptcha", headers = "Accept=application/json")
    @ResponseBody
    public Boolean validateCaptcha(@RequestParam(value="code",required=true) String code,HttpServletRequest request) {
        String captchaID = (String)request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY);
        if(code.equals(captchaID)){
        	return true;
        }else{
        	return false;
        }
    }

	@Log(type=ModeName.USER,content="删除")
    @RequestMapping(method = RequestMethod.GET, value = "/delete", headers = "Accept=application/json")
    @ResponseBody
    public Map<String,Object> deleteUser(@RequestParam(value="uuid")String uuid){
    	Map<String,Object> map = new HashMap<String,Object>();
    	boolean success = false;
    	String msg = "";
    	if(StringUtils.isNotEmpty(uuid)){
    		User user;
			try {
				user = userService.findUserBeanByUuid(uuid);
				map.put("bId",user.getUuid());
				if(!user.getLoginName().equals("admin")){
	    			userService.deleteUserByUuid(uuid);
	    			success = true;
	    			msg="删除成功！";
	    		}else{
	    			msg="删除失败！系统管理员不可删除！";
	    		}
			} catch (CustomException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				msg = "系统异常！请稍候重试！";
			}
    		
		}else{
			msg="请选择要删除的记录！";
		}
    	map.put("content",msg);
    	map.put("success",success);
    	map.put("msg", msg);
    	return map;
    }
    
    @RequestMapping(value="/showRole")
    public ModelAndView showRoleView(@RequestParam(value="uuid",required=true)String id,HttpServletRequest request){
        List<Role> list = roleService.findAll();
        UserAccount user;
		try {
			user = (UserAccount) this.accountService.findUserBeanByUuid(id); 
			List<Role> userRoleList = new ArrayList<Role>();
			for (Iterator iterator = user.getRoles().iterator(); iterator.hasNext();) {
				Role role = (Role) iterator.next();
				userRoleList.add(role);
			}
	        request.setAttribute("userId", id);
	        request.setAttribute("roleList", list);
	        request.setAttribute("userRoleList", userRoleList);
		} catch (CustomException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return new ModelAndView("/pages/user/showRole.jsp");
    }
    @RequestMapping(value="/saveUserRole")
    @ResponseBody
	@Log(type=ModeName.USER,content="分配用户角色")
    public Map<String,Object> saveUserRole(@RequestParam(value="userId",required=true)String userId,@RequestParam(value="roleIds",required=true)String[] roleIdGroup){
    	Map<String,Object> map = new HashMap<String,Object>();
    	boolean flag = false;
    	String msg = "权限分配失败!";
    	String roleString = "";
    	map.put("bId",userId);
    	try {
            UserAccount user = (UserAccount) this.accountService.findUserBeanByUuid(userId);
            accountService.updateRoleAuthorized(userId, roleIdGroup);

            roleString = user.getLoginName() + ":";
            if(roleIdGroup != null){
	            for (String roleId : roleIdGroup) {
	            	if(roleId == null || "".equals(roleId))
	            		continue;
	                Role roleBean = roleService.getRoleById(roleId);
	                roleString += roleBean.getName() + ";";
	            }
            }else{
            	roleString = "清除用户所有角色！";
            }
            flag = true;
            msg = "权限分配成功！";
        } catch (Exception e) {
            e.printStackTrace();
        }
    	map.put("content",msg+roleString);
    	map.put("success",flag);
    	map.put("msg", msg);
    	return map;
    }
    @RequestMapping(value="/changePasswordView")
    public ModelAndView showChangPwd(){
    	return new ModelAndView("/pages/user/changePassword.jsp");
    }

	@Log(type=ModeName.USER,content="修改密码")
    @RequestMapping(value="/savePassword")
    @ResponseBody
    public Map<String,Object> savePassword(@RequestParam(value="oldPwd",required=true)String oldPwd,
    		@RequestParam(value="pwd",required=true)String pwd,HttpServletRequest request){
    	HashMap<String,Object> map = new HashMap<String,Object>();
    	boolean flag = false;
    	String msg = "密码修改失败！";
    	UserAccount user = (UserAccount)SecurityUtils.getUserInfoDetails();
    	map.put("bId",user.getUuid());
    	oldPwd = MD5PasswordEncoder.encode(oldPwd, user.getLoginName());
    	if(oldPwd.equals(user.getPassword())){
    		user.setPassword(pwd);
        	try {
				userService.savePassword(user);
				user.setPassword(MD5PasswordEncoder.encode(pwd, user.getLoginName()));
				flag = true;
				msg = "密码修改成功！";
				map.put("content", "密码修改成功！");
			} catch (CustomException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				msg = "密码修改失败！系统异常！请稍候重试！";
				map.put("content", "密码修改失败！系统异常！请稍候重试！");
			}
    	}else{
    		msg = "输入的旧密码有误！";
			map.put("content", "密码修改失败！输入的旧密码有误！");
    	}
    	
    	map.put("success",flag);
    	map.put("msg",msg);
    	return map;
    }
    @RequestMapping("/forgetPasswordView")
	public ModelAndView forgetPasswordView(){
		return new ModelAndView("/pages/security/forgetPwd.jsp");
	}
}
