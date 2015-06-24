package com.isoftstone.demo.role.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.isoftstone.demo.common.model.TreeBean;
import com.isoftstone.demo.role.dao.ResourceDao;
import com.isoftstone.demo.role.model.Resource;
import com.isoftstone.demo.role.service.ResourceService;
@Service
@Transactional(propagation= Propagation.NOT_SUPPORTED,readOnly=true)
public class ResourceServiceImpl implements ResourceService {
    final Logger logger = LoggerFactory.getLogger(ResourceServiceImpl.class);
    @Autowired
    private ResourceDao resourceDao;


    public ResourceDao getResourceDao() {
        return resourceDao;
    }

    public void setResourceDao(ResourceDao resourceDao) {
        this.resourceDao = resourceDao;
    }

    @Override
    public List<Resource> findAll() {
        return resourceDao.findAll();
    }

    @Override
    public Resource findResourceInfoByKey(String key) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteResource(Resource resource) throws CustomException {
        Resource resource1 = resourceDao.getResource(resource.getUuid());
        resourceDao.deleteResource(resource1);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveResource(Resource resource) {
        if (null != resource.getUuid()) {
            resourceDao.updateResource(resource);
        } else {
            resourceDao.saveResource(resource);
        }

    }

    @Override
    public PageModel<Resource> findResourceInfoGridByParams(
            Map<String, Object> params, String page) {

        PageModel<Resource> pageBean = new PageModel<Resource>();
        try {
            pageBean.setPage(Integer.valueOf(page));
        } catch (NumberFormatException e) {
            logger.info(e.getMessage());
        }
        pageBean.setRecords(this.resourceDao.countResourceInfoByParams(params));

        if (pageBean.getTotal() > 0) {
            List<Resource> resourceList = this.resourceDao.findResourceInfoByParams(params, pageBean.getPage(), pageBean.getLimit());
            for (Resource resource : resourceList) {
                pageBean.addRow(resource);
            }
        } else {
            pageBean.setPage(1);
        }
        return pageBean;
    }

    @Override
    public Resource getResourceById(String uuid) throws CustomException {
        Resource resource = resourceDao.getResource(uuid);
        return resource;
    }

    @Override
    public List<TreeBean> getAuthorizedTree(List<Resource> authorizedResourceList) {
        List<TreeBean> treeList = new ArrayList<TreeBean>();
        Map<String, Resource> userResourceMap = new HashMap<String, Resource>();
        TreeBean treeBean = null;

        if (authorizedResourceList != null && authorizedResourceList.size() > 0)
            for (Resource resource : authorizedResourceList)
                userResourceMap.put(resource.getUuid(), resource);

        List<Resource> resources = this.resourceDao.findAll();
        for (Resource resource : resources) {
            treeBean = new TreeBean();
            treeBean.setId(resource.getUuid());
            treeBean.setText(resource.getName());
            if (StringUtils.isNotEmpty(resource.getParentId()))
                treeBean.setParent(resource.getParentId());
            if (resource.getChildren().isEmpty()&&userResourceMap.get(resource.getUuid()) != null)
                treeBean.setSelected(true);
            treeList.add(treeBean);
        }

        return treeList;
    }

    public Map getAuthortyTree2(Set<Resource> authorizedResrouces) {
        // TODO Auto-generated method stub
//		List<TreeBean> treeList = new ArrayList<TreeBean>();

        Map treeMap = new HashMap();

        List<Resource> resources = this.resourceDao.findRootNode();

        TreeBean treeBean = null;
        Map<String, String> idMap = new HashMap<String, String>();

        for (Resource rb : authorizedResrouces) {
            idMap.put(rb.getUuid(), rb.getUuid());
        }
        Map result = new HashMap();
        for (Resource r : resources) {
            treeMap = this.toTreeMap(result, r, idMap);
        }

        return treeMap;
    }

    private Map toTreeMap(Map result, Resource r, Map selected) {
//		Map result = new HashMap();
        String id = String.valueOf(r.getUuid());
        result.put("id", id);
        String text = r.getName();
        result.put("text", text);
        Map stats = new HashMap();
        stats.put("opened", true);
        if (selected.get(r.getUuid()) != null) {
            stats.put("selected", true);
        }
        result.put("state", stats);
        Set children = new HashSet();
        if (r.getChildren() != null) {
            for (Resource child : r.getChildren()) {
                Map childMap = new HashMap();
                children.add(this.toTreeMap(childMap, child, selected));
            }
        }
        result.put("children", children);
        return result;
    }

}
