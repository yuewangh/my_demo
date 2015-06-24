package com.isoftstone.demo.information.service;

import java.util.Map;

import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.information.model.Information;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-04-23
 * Time: 20:29
 * To change this template use File | Settings | File Templates.
 */
public interface InformationService {

    /**
     * @param information
     */
    void saveInformation(Information information);

    /**
     * @param information
     */
    void updateInformation(Information information);

    /**
     * @param uuid
     */
    void deleteInformation(String uuid);

    /**
     * @param uuid
     * @return
     */
    Information findInformationByUuid(String uuid);

    /**
     * @param params
     * @param page
     * @param size
     * @param order
     */
    PageModel<Information> findInformationGridByParam(Map<String, Object> params, int page, int size, Map<String, String> order);
}
