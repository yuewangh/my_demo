package com.isoftstone.demo.userManager.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.operation_log.enumeration.ModeName;
import com.isoftstone.demo.operation_log.model.Log;
import com.isoftstone.demo.userManager.constants.UserConstants;
import com.isoftstone.demo.userManager.constants.UserConstants.identity;
import com.isoftstone.demo.userManager.constants.UserConstants.survival;
import com.isoftstone.demo.userManager.model.UserPersona;
import com.isoftstone.demo.userManager.service.PersonaService;
@RequestMapping("/system/persona")
@Controller
public class PersonaUserController {
	
	@Autowired
	PersonaService personaService;
	@RequestMapping("/index")
	public ModelAndView index(){
		return new ModelAndView("/pages/user/personaList.jsp");
	}
	@RequestMapping(value="/list")
	@ResponseBody
	public PageModel<UserPersona> list(
			@RequestParam(value="loginName",defaultValue="") String loginName,
			@RequestParam(value="name",defaultValue="") String name,
			@RequestParam(value="survival",defaultValue="") String survival,
			@RequestParam(value="tel",defaultValue="") String tel,
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
		if(StringUtils.isNotEmpty(tel)){
			params.put("tel",tel);
		}
		if(StringUtils.isNotEmpty(survival)){
			params.put("survival",UserConstants.parseSurvival(survival));
		}
		params.put("identity",identity.PERSONA);
		PageModel<UserPersona> model = personaService.findPersonaGridByParams(params, page, rows,sidx,sord);
		return model;
	}

    @RequestMapping(method = RequestMethod.GET, value = "/delete", headers = "Accept=application/json")
    @ResponseBody
    public Boolean deleteUser(@RequestParam(value="uuid")String uuid){
    	if(StringUtils.isNotEmpty(uuid)){
			personaService.deleteUserByUuid(uuid);
			return true;
		}
    	return false;
    }
	
	@RequestMapping("/addOrupdateView")
	public ModelAndView updateView(@RequestParam(value="uuid",defaultValue="")String uuid,Model model){
		UserPersona user = new UserPersona();
		if(uuid != null && !"".equals(uuid)){
				try {
					user = personaService.findUserBeanByUuid(uuid);
				} catch (CustomException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		model.addAttribute("userInfoBean",user);
		return new ModelAndView("/pages/user/personaInfo.jsp");
	}
	@RequestMapping("/savePersona")
	@ResponseBody
	@Log(type=ModeName.USER,content="修改会员")
	public Map<String,Object> saveUpdate(@ModelAttribute UserPersona userInfoBean){
		HashMap<String,Object> map = new HashMap<String,Object>();
		boolean flag = false;
		String msg = "";
		try {
			if(userInfoBean.getUuid() != null && !"".equals(userInfoBean.getUuid())){
				msg = "会员用户修改失败！";
				personaService.updatePersonaInfo(userInfoBean);
				map.put("bId",userInfoBean.getUuid());
				msg = "会员用户修改成功!";
			}else{
				msg = "会员用户添加失败！";
				userInfoBean.setIdentity(identity.PERSONA);
				userInfoBean.setRegisterDate(new Date());
				//暂时不要邮箱验证
				userInfoBean.setSurvival(survival.ENABLE);
				personaService.savePersonaInfo(userInfoBean);
				msg = "会员用户添加成功！";
			}
			flag = true;
		} catch (CustomException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			msg = "系统异常！操作失败！请稍候再试！";
		}
		map.put("success",flag);
		map.put("msg",msg);
		map.put("content",msg);
		return map;
	}
	
}
