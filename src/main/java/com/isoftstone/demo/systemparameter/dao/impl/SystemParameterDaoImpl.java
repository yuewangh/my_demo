package com.isoftstone.demo.systemparameter.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.isoftstone.demo.common.dao.impl.BaseDaoSupport;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.systemparameter.dao.SystemParameterDao;
import com.isoftstone.demo.systemparameter.model.SystemParameter;


/**
 * @author fenghuc
 */
@Repository
public class SystemParameterDaoImpl extends BaseDaoSupport<SystemParameter> implements SystemParameterDao {

    @Override
    public void saveSystemParameter(SystemParameter systemParameter) {
        super.save(systemParameter);
    }

    @Override
    public void updateSystemParameter(SystemParameter systemParameter) {
        super.update(systemParameter);
    }

    @Override
    public void deleteSystemParameter(SystemParameter systemParameter) {
        super.delete(systemParameter);
    }

    @Override
    public void deleteSystemParameterByID(String id) {
        super.delete(id);
    }

    @Override
    public List<SystemParameter> findSystemParameterByParams(
            Map<String, Object> params, int page, int pageSize) {
        StringBuilder hql = new StringBuilder();
        StringBuilder where = new StringBuilder();
        hql.append("select s from SystemParameter s");
        if (params != null) {
            if (params.get("paramName") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" s.paramName like '%'||:paramName||'%' ");
            }
            if (params.get("paramKey") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" s.paramKey like '%'||:paramKey||'%' ");
            }
            if (params.get("duId") != null) {
                try {
                    if (where.length() > 0)
                        where.append(" and ");
                    if (params.get("duId") != null && !"".equals(params.get("duId"))) {
                        where.append(" s.duId = :duId ");
                    } else {
                        where.append(" s.duId is null ");
                        params.remove("duId");
                    }
                } catch (ClassCastException e) {

                }
            }
            if (where.length() > 0) {
                hql.append(" where ");
                hql.append(where);
            }
        }
        return super.find(hql.toString(), params, page, pageSize);
    }

    @Override
    public List<SystemParameter> findSystemParametersByDuId(String duId) {
    	String hql = "from SystemParameter s where s.duId=:duId";
    	try{
    		return this.getSession().createQuery(hql).setParameter("duId",duId).list();//.find("from SystemParameter s where s.duId=?", duId);  //To change body of implemented methods use File | Settings | File Templates.
    	}catch(Exception e){
    		Session session = this.openSession();
    		List<SystemParameter> list = session.createQuery(hql).setParameter("duId",duId).list();
    		session.close();
    		return list;
    	}
        
    }

    @Override
    public List<SystemParameter> findAllSystemParameter() {
        return super.find("from SystemParameter");
    }

    @Override
    public SystemParameter getSystemParameter(int id) throws CustomException {
        return super.get(id);
    }

    @Override
    public SystemParameter loadSystemParameter(String id) throws CustomException {
        return super.get(id);
    }

    @SuppressWarnings("unchecked")
    @Override
    public int countSystemParameterByParams(Map<String, Object> params) {
    	Map<String,Object> map = new HashMap<String,Object>();	
        int count = 0;
        StringBuilder hql = new StringBuilder();
        List<Object> paramList = new ArrayList<Object>();
        StringBuilder where = new StringBuilder();
        hql.append("select count(s.uuid) from SystemParameter s ");
        if (params != null) {
            if (params.get("paramName") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" s.paramName like '%'||:paramName||'%' ");
                map.put("paramName", params.get("paramName"));
            }
            if (params.get("name") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" s.paramName = :name ");
                map.put("name", params.get("name"));
            }
            if (params.get("paramKey") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" s.paramKey like '%'||:paramKey||'%' ");
                map.put("paramKey", params.get("paramKey"));
            }
            if (params.get("duId") != null) {
                try {
                    if (where.length() > 0)
                        where.append(" and ");
                    if (!"".equals(params.get("duId"))) {
                        where.append(" s.duId = :duId ");
                        map.put("duId", params.get("duId"));
                    } else {
                        where.append(" s.duId is  null ");
                    }
                } catch (ClassCastException e) {
                }
            }
            if (where.length() > 0) {
                hql.append(" where ");
                hql.append(where);
            }
        }
        int totalCount = super.getTotalCount(hql.toString(),map);
        return totalCount;
    }

    @Override
    public SystemParameter findSystemParameterByKey(String key) {
        List<SystemParameter> paramList = super.find("from SystemParameter s where s.paramKey='"+key+"'");
        if (paramList.size() >= 1)
            return paramList.get(0);
        else
            return null;
    }
}
