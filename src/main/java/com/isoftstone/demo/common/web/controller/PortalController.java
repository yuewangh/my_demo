package com.isoftstone.demo.common.web.controller;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import com.isoftstone.demo.security.util.SecurityUtils;
import com.isoftstone.demo.userManager.model.User;

@Controller
@RequestMapping("/portal")
public class PortalController {
	@Autowired
	InformationService informationService;

	@RequestMapping("/index")
	public ModelAndView index(
			HttpServletRequest request,
			@RequestParam(value = "yytype", required = false, defaultValue = "") String yytype) {
		// 获取活动信息
		int activityNum = 3;//首页只获取3条数据
		HashMap<String,Object>map = new HashMap<String,Object>();
		map.put("activityAfterToday",new Date());

		Map<String,String> order = new HashMap<String,String>();
		order.put("ORDER_NAME", "activityDate");
		order.put("ORDER_TYPE", "desc");
		PageModel<Information> pm = informationService
				.findInformationGridByParam(map, 1,
						activityNum, order);
		List<Information> activityList = pm.getRows();
		if(activityList != null && activityList.size()<activityNum){
			map.clear();
			map.put("activityBeforeToday", new Date());
			pm = informationService
					.findInformationGridByParam(map, 1,
							activityNum-activityList.size(), order);
			for(Information info : pm.getRows()){
				activityList.add(info);
			}
		}
		request.setAttribute("activityList", activityList);
		return new ModelAndView("/portal/index/index.jsp");
	}

	@RequestMapping("/reserve")
	public ModelAndView reserve(HttpServletRequest request,
			String building_uuid, String startDatestr, Integer duration,
			String endDatestr) {
		String user_uuid = null;
		User usr = SecurityUtils.getUserInfoDetails();
		if (usr != null) {
			user_uuid = usr.getUuid();
		}
		request.setAttribute("user_uuid", user_uuid);
		request.setAttribute("building_uuid", building_uuid);
		request.setAttribute("startDatestr", startDatestr);
		request.setAttribute("duration", duration);
		request.setAttribute("endDatestr", endDatestr);
		return new ModelAndView("/portal/index/reserve.jsp");
	}

	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request) {
		return new ModelAndView("/portal/security/login.jsp");
	}

	@RequestMapping("/registerView")
	public ModelAndView register() {
		return new ModelAndView("/portal/security/register.jsp");
	}

}
