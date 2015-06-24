package com.isoftstone.demo.systemparameter.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.isoftstone.demo.common.dao.impl.BaseDaoSupport;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.systemparameter.dao.DictionaryDao;
import com.isoftstone.demo.systemparameter.model.DictionaryUnit;

@Repository
public class DictionaryUnitDaoImpl extends BaseDaoSupport<DictionaryUnit> implements
        DictionaryDao {

    @Override
    public DictionaryUnit getDictionaryUnit(String id) throws CustomException {
        return super.get(id);
    }

    @Override
    public DictionaryUnit findDictionaryUnitByKey(String key) {
        String hql = "select d from DictionaryUnit d where d.paramKey = :paramKey";
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("paramKey",key);
        List<DictionaryUnit> list = this.find(hql, params);
        if (!list.isEmpty())
            return list.get(0);
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public List<DictionaryUnit> findAllDictionaryUnit() {
        return super.find("select d from DictionaryUnit d order by id asc");
    }


}
