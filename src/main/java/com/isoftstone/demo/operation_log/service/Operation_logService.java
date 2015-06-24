package com.isoftstone.demo.operation_log.service;

import java.util.Map;

import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.operation_log.model.Operation_log;

public interface Operation_logService {
	//新增
	public void insert(Operation_log operation_log);
	//获取总数
	public int getCount(Map<String, Object> params);
	//分页查询
	public PageModel<Operation_log> getList(Map<String, Object> params, int page,int size, Map<String, String> orders);

}
