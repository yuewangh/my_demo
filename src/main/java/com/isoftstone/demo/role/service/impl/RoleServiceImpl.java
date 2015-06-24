package com.isoftstone.demo.role.service.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.role.dao.ResourceDao;
import com.isoftstone.demo.role.dao.RoleDao;
import com.isoftstone.demo.role.model.Resource;
import com.isoftstone.demo.role.model.Role;
import com.isoftstone.demo.role.service.RoleService;
import com.isoftstone.demo.userManager.model.User;
@Service
@Transactional(propagation= Propagation.NOT_SUPPORTED,readOnly=true)
public class RoleServiceImpl implements RoleService {
    final Logger logger = LoggerFactory.getLogger(RoleServiceImpl.class);
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private ResourceDao resourceDao;

    /**
     * @param roleDao the roleDao to set
     */
    public void setRoleDao(RoleDao roleDao) {
        this.roleDao = roleDao;
    }

    public void setResourceDao(ResourceDao resourceDao) {
        this.resourceDao = resourceDao;
    }

    /*
     * (non-Javadoc)
     * @see com.isoftstone.portal.role.service.RoleService#findAll()
     */
    public List<Role> findAll() {
        return roleDao.findAll();
    }

    /*
     * (non-Javadoc)
     * @see com.isoftstone.portal.role.service.RoleService#findRoleInfoByKey()
     * @author:范寅
     * @create time:2013/05/10 10:55
     */
    public Role findRoleInfoByKey(String key) {
        // TODO Auto-generated method stub
        if (StringUtils.isNotEmpty(key.trim())) {
            Role role = roleDao.findRoleInfoByKey(key);
            if (role == null)
                return null;
        }
        return roleDao.findRoleInfoByKey(key);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void saveRole(Role role) {
        // TODO Auto-generated method stub
        if (!role.isOnlyStatus()) {
            if (StringUtils.isNotEmpty(role.getUuid())) {
                roleDao.updateRole(role);
            } else {
                roleDao.saveRole(role);
            }
        }
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void saveAssign(String roleId, String authIds) throws CustomException {

        Role role = roleDao.getRole(roleId);

        Set<Resource> privileges = new HashSet<Resource>();

        String[] authIdsArray = authIds.split(",");

        for (String authId : authIdsArray) {
            if (StringUtils.isNotEmpty(authId)) {
                Resource r = resourceDao.getResource(authId);
                privileges.add(r);
            }
        }
        role.setPrivileges(privileges);

        roleDao.saveRole(role);

    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteRole(Role role) {
        // TODO Auto-generated method stub
        if (!role.isOnlyStatus()) {
            roleDao.deleteRole(role);
        }
    }

    public PageModel<Role> findRoleInfoGridByParams(Map<String, Object> params,
                                                       String page,String rows) {
    	PageModel<Role> pageModel = new PageModel<Role>();
        try {
        	pageModel.setPage(Integer.valueOf(page));
        	pageModel.setLimit(Integer.valueOf(rows));
        } catch (NumberFormatException e) {
            logger.info(e.getMessage());
        }
        pageModel.setRecords(this.roleDao.countRoleInfoByParams(params));
        if (pageModel.getTotal() > 0) {
            List<Role> roleList = this.roleDao.findRoleInfoByParams(params, pageModel.getPage(), pageModel.getLimit());
            for (Role role : roleList) {
            	pageModel.addRow(role);
            }
        } else {
        	pageModel.setPage(1);
        }
        return pageModel;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteBulkRole(String ids) {
        if (StringUtils.isNotEmpty(ids)) {
            for (String uuid : ids.split(",")) {
                roleDao.deleteBulk(uuid);
            }
        }
    }

    public Role getRoleById(String uuid) throws CustomException {
        Role role = roleDao.getRole(uuid);

        for (Resource r : role.getPrivileges()) {
            role.addPrivilege(r);
        }

        for (User u : role.getUsers()) {
            role.addUsers(u);
        }

        return role;
    }
}
