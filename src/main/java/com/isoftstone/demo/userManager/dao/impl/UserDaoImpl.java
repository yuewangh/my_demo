package com.isoftstone.demo.userManager.dao.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import com.isoftstone.demo.common.dao.impl.BaseDaoSupport;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.userManager.constants.UserConstants;
import com.isoftstone.demo.userManager.dao.UserDao;
import com.isoftstone.demo.userManager.model.User;

/**
 * Created by lidey on 14-6-24.
 */
@Repository
public class UserDaoImpl extends BaseDaoSupport<User> implements UserDao {
	private String delCondi = " and u.deleteDate is null ";
    @Override
    public void saveUser(User user) {
        user.setRegisterDate(new Date());
        super.save(user);
    }

    @Override
    public void updateUser(User user) {
        super.update(user);
    }

    @Override
    public User getUser(Serializable uuid) throws CustomException {
        return super.get(uuid);
    }

    @Override
    public User loadUser(Serializable uuid) throws CustomException {
        return super.load(uuid);
    }

    @Override
    public void deleteUser(Serializable uuid) {
        super.delete(uuid);
    }

    @Override
    public void logicDeleteUser(Serializable uuid) {
        super.logicDelete(uuid);
    }

    @Override
    public void deleteUser(User user) {
        super.delete(user);
    }

    @Override
    public User findUserByLoginName(String loginName) {
        List<User> userList = super.find("from User u where u.loginName='"+ loginName+"' "+delCondi);
        if (userList.size() > 0)
            return userList.get(0);
        return null;
    }
    @Override
	public User findUserByEmail(String mail) {
		// TODO Auto-generated method stub
    	List<User> userList = super.find("from User u where u.mail='"+mail+"' "+delCondi);
        if (userList.size() > 0)
            return userList.get(0);
        return null;
	}
    /**
     * @param params
     * @return
     */
    private StringBuilder getWhereHql(Map<String, Object> params) {

        StringBuilder where = new StringBuilder();
        if (params != null && !params.isEmpty()) {
            if (params.get("loginName") != null && StringUtils.isNotEmpty(params.get("loginName").toString())) {
                where.append(" u.loginName like '%'||:loginName||'%' ");
            }
            if (params.get("name") != null && StringUtils.isNotEmpty(params.get("name").toString())) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" u.name like '%'||:name||'%' ");
            }
            if (params.get("survival") != null && params.get("survival") instanceof UserConstants.survival) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" u.survival = :survival ");
            }
            if (params.get("identities") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" u.identity in (:identities) ");
            }
            if (params.get("tel") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" u.tel in (:tel) ");
            }
            if (params.get("identity") != null && params.get("identity") instanceof UserConstants.identity) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" u.identity = :identity ");
            }
        }
        if(where.length() > 0)
        	where.append(" and ");
        where.append(" u.deleteDate is null ");
        
        if (where.length() > 0) {
            where.insert(0, " WHERE ");
        }
        return where;
    }

    @Override
    public List<User> findUserByParams(Map<String, Object> params, int page, int pageSize,String sortBy,String ascDesc) {
        StringBuilder hql = new StringBuilder();
        hql.append("SELECT u FROM User u ");
        hql.append(this.getWhereHql(params));
        if(sortBy != null && !"".equals(sortBy)){
            hql.append(" ORDER BY u."+sortBy+" "+ascDesc+" ");
        }else{
            hql.append(" ORDER BY u.registerDate desc ");
        }
        List<User> userList = super.find(hql.toString(), params, page, pageSize);
        return userList;
    }

    @Override
    public int countUserByParams(Map<String, Object> params) {
        StringBuilder hql = new StringBuilder();
        hql.append("SELECT count(u.uuid) FROM User u ");
        hql.append(this.getWhereHql(params));
        int count = super.getTotalCount(hql.toString(), params);
        return count;
    }
}
