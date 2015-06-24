package com.isoftstone.demo.information.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import com.isoftstone.demo.common.dao.impl.BaseDaoSupport;
import com.isoftstone.demo.information.constants.InformationConstants;
import com.isoftstone.demo.information.dao.InformationDao;
import com.isoftstone.demo.information.model.Information;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-04-23
 * Time: 20:19
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class InformationDaoImpl extends BaseDaoSupport<Information> implements InformationDao {

    @Override
    public List<Information> findInformationByParams(Map<String, Object> params, int page, int size, Map<String, String> orders) {
        StringBuilder hql = new StringBuilder();
        hql.append("SELECT i FROM Information i ");
        hql.append(this.getWhere(params));
        if (orders != null && !orders.isEmpty())
            hql.append(this.getOrder(orders));
        List<Information> informationList = super.find(hql.toString(), params, page, size);
        return informationList;
    }

    @Override
    public int countInformationByParams(Map<String, Object> params) {
        StringBuilder hql = new StringBuilder();
        hql.append("SELECT count(i.uuid) FROM Information i ");
        hql.append(this.getWhere(params));
        int count = super.getTotalCount(hql.toString(), params);
        return count;
    }

    /**
     * @param params
     * @return
     */
    private StringBuilder getOrder(Map<String, String> params) {
        StringBuilder order = new StringBuilder();
        if (params != null && !params.isEmpty()) {
            if (StringUtils.isNotEmpty(params.get("ORDER_NAME"))) {
                order.append(" i.");
                order.append(params.get("ORDER_NAME"));
                if (StringUtils.isNotEmpty(params.get("ORDER_TYPE"))) {
                    order.append(" ");
                    order.append(params.get("ORDER_TYPE"));
                    order.append(" ");

                } else {
                    order.append(" asc ");
                }
            } else {
                order.append(" i.createDate desc ");
            }
        }
        if (order.length() > 0) {
            order.insert(0, " ORDER BY ");
        }
        return order;
    }

    /**
     * @param params
     * @return
     */
    private StringBuilder getWhere(Map<String, Object> params) {

        StringBuilder where = new StringBuilder();
        if (params != null && !params.isEmpty()) {
            if (params.get("title") != null && StringUtils.isNotEmpty(params.get("title").toString())) {
                where.append(" i.title like '%'||:title||'%' ");
            }
            if (params.get("authorId") != null && StringUtils.isNotEmpty(params.get("authorId").toString())) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" i.authorId =:authorId ");
            }
            if (params.get("portletId") != null && StringUtils.isNotEmpty(params.get("portletId").toString())) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" i.portletId =:portletId ");
            }
            if (params.get("status") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                if (params.get("status") instanceof InformationConstants.status)
                    where.append(" i.status = :status ");
                else if (params.get("status") instanceof List)
                    where.append(" i.status in (:status) ");
            }
            if (params.get("type") != null) {
                if (where.length() > 0)
                    where.append(" and ");
                if (params.get("type") instanceof InformationConstants.status)
                    where.append(" i.type = :type ");
                else if (params.get("type") instanceof List)
                    where.append(" i.type in (:type) ");
            }
            
            /*取活动时间在查询当天之后最近的三个*/

            if (params.get("activityAfterToday") != null && StringUtils.isNotEmpty(params.get("activityAfterToday").toString())) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" i.activityDate >= :activityAfterToday ");
            }
            if (params.get("activityBeforeToday") != null && StringUtils.isNotEmpty(params.get("activityBeforeToday").toString())) {
                if (where.length() > 0)
                    where.append(" and ");
                where.append(" i.activityDate < :activityBeforeToday ");
            }
        }
        if (where.length() > 0) {
            where.insert(0, " WHERE ");
        }
        return where;
    }
}
