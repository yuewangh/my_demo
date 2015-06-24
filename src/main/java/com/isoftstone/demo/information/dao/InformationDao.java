/**
 *
 */
package com.isoftstone.demo.information.dao;

import java.util.List;
import java.util.Map;

import com.isoftstone.demo.common.dao.BaseDao;
import com.isoftstone.demo.information.model.Information;

/**
 * @author 姚丰利(lidey)
 *         创建时间：2012-8-6 下午03:44:20
 */
public interface InformationDao extends BaseDao<Information> {


    /**
     *
     * @param params
     * @param page
     * @param size
     * @param orders
     * @return
     */
    public List<Information> findInformationByParams(Map<String, Object> params, int page, int size, Map<String, String> orders);

    /**
     *
     * @param params
     * @return
     */
    public int countInformationByParams(Map<String, Object> params);
}
