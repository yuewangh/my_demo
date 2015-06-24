package com.isoftstone.demo.operation_log.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import com.isoftstone.demo.common.dao.impl.BaseDaoSupport;
import com.isoftstone.demo.operation_log.dao.Operation_logDao;
import com.isoftstone.demo.operation_log.model.Operation_log;

@Repository
public class Operation_logDaoImpl extends BaseDaoSupport<Operation_log> implements Operation_logDao{

	//新增
	public void insert(Operation_log operation_log) {
		save(operation_log);
	}
	//获取总数
	public int getCount(Map<String, Object> params) {
		StringBuilder hql = new StringBuilder();
		hql.append("SELECT count(u.uuid) FROM Operation_log u ");
		hql.append(this.getWhereHql(params));
		int count = super.getTotalCount(hql.toString(), params);
		return count;
	}
	//分页查询
	public List<Operation_log> getList(Map<String, Object> params, int page, int size, Map<String, String> orders) {
		StringBuilder hql = new StringBuilder();
		hql.append("SELECT u FROM Operation_log u");
		hql.append(this.getWhereHql(params));
		if (orders != null && !orders.isEmpty()){
			hql.append(this.getOrderSql(orders));
		}
		List<Operation_log> list = (List<Operation_log>) super.find(hql.toString(), params, page, size);
		return list;
	}
	//获取排序sql
	private StringBuilder getOrderSql(Map<String, String> params) {
		StringBuilder order = new StringBuilder();
		if (params != null && !params.isEmpty()) {
			if (StringUtils.isNotEmpty(params.get("ORDER_NAME"))) {
				 order.append(" u.");
				order.append(params.get("ORDER_NAME"));
				if (StringUtils.isNotEmpty(params.get("ORDER_TYPE"))) {
					order.append(" ");
					order.append(params.get("ORDER_TYPE"));
					order.append(" ");
				} else {
					order.append(" asc ");
				}
			} else {
				order.append(" u.operdate desc ");
			}
		}
		if (order.length() > 0) {
			order.insert(0, " ORDER BY ");
		}
		return order;
	}
	//获取条件sql
	private StringBuilder getWhereHql(Map<String, Object> params) {
		StringBuilder where = new StringBuilder();
		if (params != null && !params.isEmpty()) {
			if (params.get("modname") != null && StringUtils.isNotEmpty(params.get("modname").toString())) {
                where.append(" u.modname = :modname ");
	         }
	         if (params.get("name") != null && StringUtils.isNotEmpty(params.get("name").toString())) {
	        	 if (where.length() > 0)
	        		 where.append(" and ");
	             where.append("( u.loginname like '%'||:name||'%' or  u.fullname like '%'||:name||'%' )");
	         }
	         if (params.get("startDate") != null) {
	        	 if (where.length() > 0)
	        	 	where.append(" and ");
	        	 where.append(" date(u.operdate) >= :startDate ");
	         }
	         if (params.get("endDate") != null) {
	        	 if (where.length() > 0)
	        		 where.append(" and ");
	        	 where.append(" date(u.operdate) <= :endDate ");
	         }
		}
		if (where.length() > 0) {
			where.insert(0, " WHERE ");
		}
		return where;
	}

}