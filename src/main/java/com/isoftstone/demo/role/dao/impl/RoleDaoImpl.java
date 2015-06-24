/**
 *
 */
package com.isoftstone.demo.role.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.isoftstone.demo.common.dao.impl.BaseDaoSupport;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.role.dao.RoleDao;
import com.isoftstone.demo.role.model.Role;

/**
 * @author 姚丰利(lidey)
 *         创建时间：2012-8-7 上午11:36:25
 */
@Repository
public class RoleDaoImpl extends BaseDaoSupport<Role> implements RoleDao {

    /* (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#deleteRole(int)
     */
    public void deleteRole(String uuid) {
        // TODO Auto-generated method stub
        super.delete(uuid);
    }

    /* (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#deleteRole(com.isoftstone.portal.role.pojo.po.Role)
     * @author:范寅
     * @create time:2013/05/10 16:22
     */
    public void deleteRole(Role role) {
        // TODO Auto-generated method stub
    	StringBuilder hql = new StringBuilder();
        hql.append("update Role o set o.deleteDate=:deleteDate,o.modifyDate = :modifyDate where o.uuid =:uuid");
//        super.getHibernateTemplate().bulkUpdate(hql.toString(), new Date(), uuid);
        this.getSession().createQuery(hql.toString()).setParameter("deleteDate",new Date()).setParameter("modifyDate", new Date()).setParameter("uuid",role.getUuid()).executeUpdate();
        //super.delete(role);

    }

    /* (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#findAll()
     */
    public List<Role> findAll() {
        // TODO Auto-generated method stub
    	String hql = "FROM Role WHERE 1=1";
        return super.find(hql);
    }

    /* (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#getRole(int)
     */
    public Role getRole(String uuid) throws CustomException {
        // TODO Auto-generated method stub
        return super.get(uuid);
    }

    /* (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#saveRole(com.isoftstone.portal.role.pojo.po.Role)
     */
    public void saveRole(Role role) {
        // TODO Auto-generated method stub
        role.setCreateDate(new Date());
        role.setModifyDate(new Date());
        super.save(role);
    }

    /* (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#updateRole(com.isoftstone.portal.role.pojo.po.Role)
     */
    public void updateRole(Role role) {
        // TODO Auto-generated method stub
        role.setModifyDate(new Date());
        super.update(role);
    }

    /*
     * (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#findRoleInfoByKey(java.lang.String)
     * @author:范寅
     * @create time:2013/05/10 10:34
     */
    public Role findRoleInfoByKey(String key) {
        // TODO Auto-generated method stub
        String hql = "from Role r where r.key = :key";
        HashMap<String,Object> params = new HashMap<String,Object>();
        params.put("key",key);
        List<Role> roleList = super.find(hql, params);
        if (roleList.size() > 0)
            return roleList.get(0);
        return null;
    }

    /*
     * (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#countRoleInfoByParams(java.util.Map)
     * @author:范寅
     * @create time：2013/05/13 9:54
     */
    public int countRoleInfoByParams(Map<String, Object> params) {
        // TODO Auto-generated method stub
        int count = 0;
        try {
            StringBuilder hql = new StringBuilder();
            HashMap<String,Object> paramMap = new HashMap<String,Object>();
            StringBuilder where = new StringBuilder();
            hql.append("select count(r.uuid) from Role r ");
            if (params != null) {
                if (params.get("name") != null) {
                    if (where.length() > 0)
                        where.append(" and ");
                    where.append(" r.name like '%'||:name||'%' ");
                    paramMap.put("name",params.get("name"));
                }
                if (params.get("key") != null) {
                    if (where.length() > 0)
                        where.append(" and ");
                    where.append(" r.key like '%'||:key||'%' ");
                    paramMap.put("key",params.get("key"));
                }
                if (params.get("survivalStatus") != null) {
                    if (where.length() > 0)
                        where.append(" and ");
                    where.append(" r.survivalStatus = :survivalStatus ");
                    paramMap.put("survivalStatus",params.get("survivalStatus"));
                }
                if (params.get("hideStatus") != null) {
                    if (where.length() > 0)
                        where.append(" and ");
                    where.append(" r.hideStatus = :hideStatus ");
                    paramMap.put("hideStatus",params.get("hideStatus"));
                }
                if (where.length() > 0) {
                    hql.append(" where ");
                    hql.append(where);
                }
            }
            List countList = super.find(hql.toString(),paramMap);
            if (!countList.isEmpty())
                count = Integer.valueOf(countList.get(0).toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    /*
     * (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#findRoleInfoByParams(java.util.Map, int, int)
     * @author:范寅
     * @create time:2013/05/13 9:58
     */
    public List<Role> findRoleInfoByParams(Map<String, Object> params,
                                           int page, int pageSize) {
        // TODO Auto-generated method stub
        StringBuilder hql = new StringBuilder();
        StringBuilder where = new StringBuilder();
        HashMap<String,Object> paramMap = new HashMap<String,Object>();
        hql.append(" select r from Role r ");
        if (params != null) {
            if (params.get("name") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" r.name like '%'||:name||'%' ");
                paramMap.put("name",params.get("name"));
            }
            if (params.get("key") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" r.key like '%'||:key||'%' ");
                paramMap.put("key",params.get("key"));
            }
            if (params.get("survivalStatus") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" r.survivalStatus = :survivalStatus ");
                paramMap.put("survivalStatus",params.get("survivalStatus"));
            }
            if (params.get("hideStatus") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" r.hideStatus = :hideStatus ");
                paramMap.put("hideStatus",params.get("hideStatus"));
            }
            if (where.length() > 0) {
                hql.append(" where ");
                hql.append(where);
            }
        }
        hql.append(" order by r.onlyStatus , r.createDate desc");
        List<Role> roles = new ArrayList<Role>();
        try {
            roles = super.find(hql.toString(), paramMap, page, pageSize);
        } catch (Exception e) {
            System.out.println(e);
        }
        return roles;
    }

    /*
     * (non-Javadoc)
     * @see com.isoftstone.portal.role.dao.RoleDao#bulkDelete(java.lang.String, java.util.List)
     * @author 范寅
     * @create time 2013/05/16
     */
    public void deleteBulk(String ids) {
        // TODO Auto-generated method stub
        super.delete(ids);
    }
}
