package com.isoftstone.demo.operation_log.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.operation_log.dao.Operation_logDao;
import com.isoftstone.demo.operation_log.enumeration.ModeName;
import com.isoftstone.demo.operation_log.model.Operation_log;
import com.isoftstone.demo.operation_log.service.Operation_logService;

@Service
@Transactional(propagation= Propagation.NOT_SUPPORTED,readOnly=true)
public class Operation_logServiceImpl implements Operation_logService {

	@Autowired
	private Operation_logDao operation_logDao;
	//新增
	@Transactional(propagation = Propagation.REQUIRED)
	public void insert(Operation_log operation_log) {
		operation_logDao.insert(operation_log);
	}
	//获取总数
	public int getCount(Map<String, Object> params){
		return operation_logDao.getCount(params);
	}

	//分页查询
	public PageModel<Operation_log> getList(Map<String, Object> params, int page,int size, Map<String, String> orders){
		PageModel<Operation_log> pm = new PageModel<Operation_log>();
		int records = operation_logDao.getCount(params);
		pm.setRecords(records);
		pm.setPage(page);
		pm.setLimit(size);
		if (pm.getTotal() > 0) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			List<Operation_log> rows = operation_logDao.getList(params, page, size, orders);
			for(int i=0;i<rows.size();i++){
				Operation_log row = rows.get(i);
				Date operdate = row.getOperdate();
				if(operdate != null){
					row.setOperdatestr(sdf.format(operdate));
				}
				String name = row.getModname();
				String modeName = ModeName.valueOf(name).displayCode;
				row.setModname(modeName);
				pm.addRow(row);
			}
			pm.setRows(rows);
		} else {
			pm.setPage(1);
		}
		return pm;
	}

}