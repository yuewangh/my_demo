package com.isoftstone.demo.platform.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.information.model.Information;
import com.isoftstone.demo.information.service.InformationService;

@RequestMapping("/portal/platform")
@Controller
public class PortalPlatformController {
	@Autowired
	InformationService informationService;

	@RequestMapping("/index")
	public ModelAndView index(@RequestParam(value="page",defaultValue="1")String pageStr,
			@RequestParam(value="size",defaultValue="10")String sizeStr,
			@RequestParam(value="order",defaultValue="")String order,
			HttpServletRequest request){
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("portletId","platform");
		int page = 1;
		try{
			page = Integer.parseInt(pageStr);
		}catch(Exception e){
			
		}
		int size = 1;
		try{
			size = Integer.parseInt(sizeStr);
		}catch(Exception e){
			
		}
		Map<String,String> orderMap = new HashMap<String,String>();
		if(order != null && !"".equals(order)){
			orderMap.put(order,order);
		}
		PageModel<Information> pm = informationService.findInformationGridByParam(params, page, size, orderMap);
		request.setAttribute("pageModel",pm);
		return new ModelAndView("/portal/platform/index.jsp");
	}
}
