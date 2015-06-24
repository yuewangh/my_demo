package com.isoftstone.demo.role.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.isoftstone.demo.common.dao.impl.BaseDaoSupport;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.role.dao.ResourceDao;
import com.isoftstone.demo.role.model.Resource;

@Repository
public class ResourceDaoImpl extends BaseDaoSupport<Resource> implements ResourceDao {

    @Override
    public void deleteResource(String uuid) {
        super.delete(uuid);
    }

    @Override
    public void deleteResource(Resource resource) {
        super.delete(resource);
    }

    public List<Resource> findAll() {
        return super.find("from Resource r order by r.orderNo asc");
    }

    @Override
    public List<Resource> findRootNode() {
        return super.find("from Resource r where r.parent = null");
    }

    @Override
    public void saveResource(Resource resource) {
        super.save(resource);
    }

    @Override
    public void updateResource(Resource resource) {
        super.update(resource);
    }

    @Override
    public Resource getResource(String uuid) throws CustomException {
        return super.get(uuid);
    }

    @Override
    public Resource findResourceInfoByKey(String key) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<Resource> findResourceInfoByParams(Map<String, Object> params,
                                                   int page, int pageSize) {
        StringBuilder hql = new StringBuilder();
        StringBuilder where = new StringBuilder();
        HashMap<String,Object> paramMap = new HashMap<String,Object>();
        hql.append("select r from Resource r ");

        if (params.get("name") != null) {
            if (where.length() > 0) {
                where.append(" and ");
            }
            where.append(" r.name like '%'||:name||'%'");
            paramMap.put("name",params.get("name"));
        }
        if (params.get("pResource") != null) {
            if (where.length() > 0) {
                where.append(" and ");
            }
            where.append(" r.parent.uuid =:pResource");
            paramMap.put("pResource",params.get("pResource"));
        }
        if (where.length() > 0) {
            hql.append(" where ");
            hql.append(where);
        }
        hql.append(" order by r.createDate");
        List<Resource> resources = new ArrayList<Resource>();

        resources = super.find(hql.toString(), paramMap,page, pageSize);
        return resources;
    }

    @Override
    public int countResourceInfoByParams(Map<String, Object> params) {
        // TODO Auto-generated method stub
        int count = 0;
        StringBuilder hql = new StringBuilder();
        HashMap<String,Object> paramMap = new HashMap<String,Object>();
        StringBuilder where = new StringBuilder();
        hql.append("select count(r.uuid) from Resource r");
        if (params.get("name") != null) {
            if (where.length() > 0) {
                where.append(" and ");
            }
            where.append(" r.name like '%'||:name||'%'");
            paramMap.put("name",params.get("name"));
        }
        if (params.get("pResource") != null) {
            if (where.length() > 0) {
                where.append(" and ");
            }
            where.append(" r.parent.uuid =:pResource");
            paramMap.put("pResource",params.get("pResource"));
        }
        if (where.length() > 0) {
            hql.append(" where ");
            hql.append(where);
        }
        hql.append(" order by r.createDate");
        List countList = super.find(hql.toString(), paramMap);
        if (!countList.isEmpty())
            count = Integer.valueOf(countList.get(0).toString());
        return count;
    }

}
