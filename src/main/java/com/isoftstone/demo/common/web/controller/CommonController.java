package com.isoftstone.demo.common.web.controller;
import java.util.HashMap;
import java.util.Map;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.isoftstone.demo.common.util.DateUtil;


@Controller
@RequestMapping("/common")
public class CommonController {
	public CommonController() {
	}

	// 保存
	@RequestMapping("/addMonths")
	@ResponseBody
	public Map<String, Object> addMonths(String startDatestr,Integer duration) {
		Map<String, Object> map = new HashMap<String, Object>();
		String endDate = DateUtil.addMonths(startDatestr, duration);
		map.put("endDate", endDate);
		return map;
	}
}
