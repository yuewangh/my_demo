package com.isoftstone.demo.operation_log.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.common.util.PageOrder;
import com.isoftstone.demo.operation_log.enumeration.ModeName;
import com.isoftstone.demo.operation_log.model.Operation_log;
import com.isoftstone.demo.operation_log.service.Operation_logService;

@Controller
@RequestMapping("/system/operation_log")
public class Operation_logController {

	@Autowired
	private Operation_logService operation_logService;
	@RequestMapping("/tolist")
	@ResponseBody
	public ModelAndView index(HttpServletRequest request){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<Map<String,Object>> maplist =  ModeName.getListMap();
		String nowday = sdf.format(new Date());
		request.setAttribute("nowday", nowday);
		request.setAttribute("maplist", maplist);
		return new ModelAndView("/pages/operation_log/log_list.jsp");
	}
	@RequestMapping("/getList")
	@ResponseBody
	public PageModel<Operation_log> getList(
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate,
			@RequestParam(value = "modname", required = false) String modname,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
			HttpServletRequest request) {
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, String> order = new HashMap<String, String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (StringUtils.isNotEmpty(sidx))
			order.put(PageOrder.NAME, sidx);
		if (StringUtils.isNotEmpty(sord))
			order.put(PageOrder.TYPE, sord);
		if (StringUtils.isNotEmpty(name))
			params.put("name", name);
		if (StringUtils.isNotEmpty(modname))
			params.put("modname", modname);
		try {
			if (StringUtils.isNotEmpty(startDate)){
				params.put("startDate", sdf.parse(startDate));
			}else{
				params.put("startDate",new Date());
			}
			if (StringUtils.isNotEmpty(endDate)){
				params.put("endDate", sdf.parse(endDate));
			}else{
				params.put("endDate", new Date());
			}
				
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return operation_logService.getList(params, page, rows, order);
	}
}