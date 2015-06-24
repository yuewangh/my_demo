package com.isoftstone.demo.systemparameter.unit;

import org.springframework.beans.factory.annotation.Autowired;

import com.isoftstone.demo.common.util.ApplicationContextUtil;
import com.isoftstone.demo.systemparameter.service.SystemParameterService;
import com.isoftstone.demo.systemparameter.service.impl.SystemParameterServiceImpl;

/**
 * User: 姚丰利（lidey）
 * Date: 13-5-23
 * Time: 下午2:21
 * To change this template use File | Settings | File Templates.
 */
public class ParamUnit {

	@Autowired
    private static SystemParameterService systemParameterService;

    private static SystemParameterService initService() {
        if (systemParameterService == null)
            systemParameterService = ApplicationContextUtil.getSpringBean("systemParameterServiceImpl", new SystemParameterServiceImpl().getClass());
        return systemParameterService;
    }

    /**
     * @param key
     * @return
     */
    public static String getStrValueByKey(String key) {
        return initService().getValueByKey(key);
    }
}
