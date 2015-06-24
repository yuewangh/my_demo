package com.isoftstone.demo.information.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.information.constants.InformationConstants.status;
import com.isoftstone.demo.information.constants.InformationConstants.type;
import com.isoftstone.demo.information.model.Information;
import com.isoftstone.demo.information.model.InformationText;
import com.isoftstone.demo.information.service.InformationService;
import com.isoftstone.demo.operation_log.enumeration.ModeName;
import com.isoftstone.demo.operation_log.model.Log;
import com.isoftstone.demo.security.util.SecurityUtils;
import com.isoftstone.demo.userManager.model.User;


@Controller
@RequestMapping("/activity/manager")
public class ActivityController {
    @Autowired
    private InformationService informationService;

    @RequestMapping("/index")
    public String index() {
        return "/pages/activity/list.jsp";
    }
    
    @RequestMapping(method = RequestMethod.GET, value = "/list", headers = "Accept=application/json")
	@ResponseBody
	public PageModel<Information> list(
			@RequestParam(value="title",defaultValue="") String title,
			@RequestParam(value="page",defaultValue="1") String pageStr,
			@RequestParam(value="rows",defaultValue="5")String rows,
			@RequestParam(value="sidx",required=false)String sidx,
			@RequestParam(value="sord",required=false)String sord){
		HashMap<String,Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotEmpty(title)){
			params.put("title",title);
		}
		params.put("portletId","activity");
		int page = 1;
		try{
			page = Integer.valueOf(pageStr);
		}catch(Exception e){}
		int size = 1;
		try{
			size = Integer.valueOf(rows);
		}catch(Exception e){}
		Map<String,String> order = new HashMap<String,String>();
		if(StringUtils.isEmpty(sidx)){
			sidx = "createDate";
			sord = "desc";
		}
		order.put("ORDER_NAME", sidx);
		order.put("ORDER_TYPE", sord);
		PageModel<Information> model = informationService.findInformationGridByParam(params, page, size, order);
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
    	return new ModelAndView("/pages/activity/info.jsp");
    }
    @RequestMapping("/updateView")
    public ModelAndView updateView(@RequestParam(value="uuid",defaultValue="") String uuid,Model model){
    	if(!"".equals(uuid)){
    		//当前登录用户修改个人信息
			if("changePwd".equals(uuid)){
				User user = SecurityUtils.getUserInfoDetails();
				uuid = user.getUuid();
			}
			model.addAttribute("information",informationService.findInformationByUuid(uuid));
    	}
    	return new ModelAndView("/pages/activity/info.jsp");
    }
    /**
    * @Title: saveUser 
    * @Description: TODO 保存用户信息
    * @param @param userInfoBean
    * @return UserAccount
    * @throws
     */
	@Log(type = ModeName.ACTIVITY, content = "进行了保存操作")
    @RequestMapping("/saveActivity")
    @ResponseBody
    public Map<String,Object> saveActivity(@ModelAttribute InformationText information){
    	Map<String,Object> map = new HashMap<String,Object>();
    	boolean success = false;
    	String msg = "";
    	User user = SecurityUtils.getUserInfoDetails();
    	if(information != null && StringUtils.isNotEmpty(information.getUuid())){
    		informationService.updateInformation(information);
    		success = true;
    		msg = "修改活动信息保存成功！";
    		map.put("content","修改活动信息");
    	}else{
    		information.setCreateDate(new Date());
    		information.setModifyDate(new Date());
    		information.setStatus(status.PROMULGATION);
    		information.setType(type.TEXT);
    		information.setPortletId("activity");
    		information.setAuthorId(user.getUuid());
    		information.setAuthorName(user.getName());
    		informationService.saveInformation(information);
    		success = true;
    		msg = "新增活动信息保存成功！";
    		map.put("content","新增活动信息");
    	}
    	map.put("bId", information.getUuid());
    	map.put("success",success);
    	map.put("msg",msg);
    	return map;
    }

	@Log(type = ModeName.ACTIVITY, content = "进行了删除操作")
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String,Object> deleteActivity(@RequestParam(value="uuid",required=true)String uuid){
//    	User user = SecurityUtils.getUserInfoDetails();
    	Map<String,Object> map = new HashMap<String,Object>();
    	boolean success = false;
    	String msg = "删除失败！";
    	
    	informationService.deleteInformation(uuid);
    	success = true;
    	msg = "删除成功！";
    	map.put("bId",uuid);
    	
    	map.put("success",success);
    	map.put("msg",msg);
    	return map;
    }

    @RequestMapping("/showDetail")
    public ModelAndView showDetail(@RequestParam(value="uuid",required=true)String uuid,HttpServletRequest request){
//    	User user = SecurityUtils.getUserInfoDetails();
    	Information info = informationService.findInformationByUuid(uuid);
    	request.setAttribute("information",info);
    	return new ModelAndView("/pages/activity/detail.jsp");
    }
}
