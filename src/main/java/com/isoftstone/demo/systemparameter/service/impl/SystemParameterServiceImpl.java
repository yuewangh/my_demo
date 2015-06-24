package com.isoftstone.demo.systemparameter.service.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.isoftstone.demo.cache.service.CacheService;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.common.util.StringUtil;
import com.isoftstone.demo.systemparameter.dao.DictionaryDao;
import com.isoftstone.demo.systemparameter.dao.SystemParameterDao;
import com.isoftstone.demo.systemparameter.model.DictionaryUnit;
import com.isoftstone.demo.systemparameter.model.SystemParameter;
import com.isoftstone.demo.systemparameter.service.SystemParameterService;

@Service
@Transactional(propagation= Propagation.NOT_SUPPORTED,readOnly=true)
public class SystemParameterServiceImpl implements SystemParameterService {
    final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SystemParameterDao systemParameterDao;
    @Autowired
    private DictionaryDao dictionaryDao;
    @Autowired
    private CacheService cacheService;


    public void setSystemParameterDao(SystemParameterDao systemParameterDao) {
        this.systemParameterDao = systemParameterDao;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteSystemParameterByID(String id) {
        systemParameterDao.deleteSystemParameterByID(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteSystemParameterByIds(String[] ids) {
        for (String id : ids) {
            try {
                systemParameterDao.deleteSystemParameterByID(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //To change body of implemented methods use File | Settings | File Templates.
    }

    /**
     *
     */
    @PostConstruct/*初始化方法 init-method*/
    @Transactional(propagation = Propagation.REQUIRED)
    private void init() {
        List<DictionaryUnit> dictionaryUnits = dictionaryDao.findAllDictionaryUnit();
        try {
            for (DictionaryUnit dictionaryUnit : dictionaryUnits) {
                List<SystemParameter> systemParameterList = systemParameterDao.findSystemParametersByDuId(dictionaryUnit.getUuid());
                if ("none".equals(dictionaryUnit.getParamType())) {
                    for (SystemParameter param : systemParameterList) {
                    	cacheService.put(param.getParamKey(), param.getParamVal());
                    }
                } else {
                    Map<String, String> paramMap = new LinkedHashMap<String, String>();
                    for (SystemParameter param : systemParameterList) {
                        paramMap.put(param.getParamVal(), param.getParamName());
                    }
                    cacheService.put(dictionaryUnit.getParamKey(), paramMap);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* (non-Javadoc)
     * @see com.isoftstone.portal.systemparameter.service.SystemParameterService#findAll()
     * 查询全部系统参数
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public List<SystemParameter> findAll() {
        List<SystemParameter> polist = systemParameterDao.findAllSystemParameter();
        return polist;
    }

    /* (non-Javadoc)
     * @see com.isoftstone.portal.systemparameter.service.SystemParameterService#saveSystemParameter(com.isoftstone.portal.systemparameter.pojo.vo.SystemParameterBean)
     * 保存系统参数
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveSystemParameter(SystemParameter systemParameter) throws CustomException {
        try {
			systemParameterDao.saveSystemParameter(systemParameter);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateSystemParameter(SystemParameter systemParameterBean) throws CustomException {
        SystemParameter systemParameter = systemParameterDao.loadSystemParameter(systemParameterBean.getUuid());
        systemParameter.setParamKey(systemParameterBean.getParamKey());
        systemParameter.setParamVal(systemParameterBean.getParamVal());
        systemParameter.setParamName(systemParameterBean.getParamName());
        systemParameter.setParamType(systemParameterBean.getParamType());
        systemParameter.setDuId(systemParameterBean.getDuId());
        systemParameterDao.updateSystemParameter(systemParameter);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void refreshSystemParameter(SystemParameter systemParameterBean) throws CustomException {
        //To change body of implemented methods use File | Settings | File Templates.
        if (systemParameterBean != null && StringUtils.isNotEmpty(systemParameterBean.getParamType())) {
            DictionaryUnit dictionaryUnit = dictionaryDao.getDictionaryUnit(systemParameterBean.getDuId());
            if ("none".equals(dictionaryUnit.getParamType())) {
            	cacheService.put(systemParameterBean.getParamKey(), systemParameterBean.getParamVal());
            } else {
                this.refreshSystemParameter(dictionaryUnit.getUuid());
            }
        }
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void refreshSystemParameter(String duId) {
        //To change body of implemented methods use File | Settings | File Templates.
        if (duId != null && StringUtils.isNotEmpty(duId)) {
            try {
                DictionaryUnit dictionaryUnit = dictionaryDao.getDictionaryUnit(duId);
                List<SystemParameter> systemParameterList = systemParameterDao.findSystemParametersByDuId(dictionaryUnit.getUuid());
                Map<String, String> paramMap = new LinkedHashMap<String, String>();
                for (SystemParameter param : systemParameterList) {
                    paramMap.put(param.getParamVal(), param.getParamName());
                }
                cacheService.put(dictionaryUnit.getParamKey(), paramMap);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /* (non-Javadoc)
     * @see com.isoftstone.portal.systemparameter.service.SystemParameterService#loadSystemParameterBean(int)
     * 通过主键查找系统参数
     */
    @Override
    public SystemParameter loadSystemParameterBean(String id) throws CustomException {
        SystemParameter po = systemParameterDao.loadSystemParameter(id);
        return po;
    }

    /* (non-Javadoc)
     * @see com.isoftstone.portal.systemparameter.service.SystemParameterService#findGridByParams(java.util.Map, java.lang.String)
     * 通过PageBean这个工具bean条件查询出系统信息
     * 并且是可以查询不同的页数page
     * 信息
     */
    public PageModel<SystemParameter> findGridByParams(
            Map<String, Object> params, int page,int size, Map<String, String> orders) {
        PageModel<SystemParameter> pageModel = new PageModel<SystemParameter>();
        try {
        	pageModel.setPage(Integer.valueOf(page));
            pageModel.setLimit(size);
        } catch (NumberFormatException e) {
            logger.info(e.getMessage());
        }
        pageModel.setRecords(this.systemParameterDao.countSystemParameterByParams(params));
        if (pageModel.getTotal()> 0) {
            List<SystemParameter> liList = this.systemParameterDao.findSystemParameterByParams(params, page, pageModel.getLimit());
            pageModel.setRows(liList);
        }
        return pageModel;
    }

    @Override
    public List<DictionaryUnit> getAllDictionaryUnitBean() {
        List<DictionaryUnit> list = dictionaryDao.findAllDictionaryUnit();
        return list;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public DictionaryUnit findDictionaryUnitBeanById(String id) {
        try {
            DictionaryUnit dictionaryUnit = dictionaryDao.getDictionaryUnit(id);
            return dictionaryUnit;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public String getValueByKey(String key) {
        if (!StringUtil.isNull(key)) {
            try {
                Object val = cacheService.get(key);
                if (val == null)
                    throw new NullPointerException("缓存没有相关的key信息，key=" + key);
                return val.toString();
            } catch (NullPointerException e) {
                SystemParameter systemParameter = systemParameterDao.findSystemParameterByKey(key);
                if (systemParameter != null) {
                	cacheService.put(systemParameter.getParamKey(), systemParameter.getParamVal());
                    return systemParameter.getParamVal();
                }
            }

        }
        return null;
    }

    @Override
    public boolean validateForName(String duId, String name) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", name);
        map.put("duId", duId);
        if (this.systemParameterDao.countSystemParameterByParams(map) > 0)
            return false;
        else
            return true;
    }

    public void setDictionaryDao(DictionaryDao dictionaryDao) {
        this.dictionaryDao = dictionaryDao;
    }

	public void setCacheService(CacheService cacheService) {
		this.cacheService = cacheService;
	}
}