package com.isoftstone.demo.common.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.isoftstone.demo.common.dao.BaseDao;
import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.exception.CustomExceptionEnum;

/**
 * User: 姚丰利（lidey）
 * Date: 13-1-5
 * Time: 上午10:49
 * To change this template use File | Settings | File Templates.
 */
@SuppressWarnings({ "unchecked", "rawtypes" })
public abstract class BaseDaoSupport<T> implements BaseDao<T> {

    /**
     * Log instance.
     */
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    private Class<T> entityClass;

    @Autowired
    private SessionFactory sessionFactory;

    /**
     * @param sessionFactory
     */
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

	public BaseDaoSupport() {
        Type t = getClass().getGenericSuperclass();
        Type arg;
        if (t instanceof ParameterizedType) {
            arg = ((ParameterizedType) t).getActualTypeArguments()[0];
        } else if (t instanceof Class) {
            arg = ((ParameterizedType) ((Class) t).getGenericSuperclass()).getActualTypeArguments()[0];
        } else {
            logger.error("Can not handle type construction for '{}'!", getClass());
            throw new RuntimeException("Can not handle type construction for '" + getClass() + "'!");
        }

        if (arg instanceof Class) {
            this.entityClass = (Class<T>) arg;
        } else if (arg instanceof ParameterizedType) {
            this.entityClass = (Class<T>) ((ParameterizedType) arg).getRawType();
        } else {
            logger.error("Problem dtermining generic class for '{}'!", getClass());
            throw new RuntimeException("Problem dtermining generic class for '" + getClass() + "'! ");
        }
    }

    /**
     * 获取session
     * @return
     */
    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }
    
    protected Session openSession(){
    	return sessionFactory.openSession();
    }
    /**
     * get获取单个实体
     */
	@Override
    public T get(Serializable uuid) throws CustomException {
        Object entry = null;
        Session session = this.getSession();
        entry = session.get(entityClass, uuid);
        if (entry == null) {
            logger.debug("Got null for extracted ID; returning null.The UUID is [{}].", uuid);
            throw new CustomException(CustomExceptionEnum.QUERY_NULL);
        }
        return (T) entry;
    }
	 /**
     * load获取单个实体
     */
    @Override
    public T load(Serializable uuid) throws CustomException {
        Object entry = null;
        Session session = this.getSession();
        entry = session.load(entityClass, uuid);
        if (entry == null) {
            logger.debug("Got null for extracted ID; returning null.The UUID is [{}].", uuid);
            throw new CustomException(CustomExceptionEnum.QUERY_NULL);
        }
        return (T) entry;
    }
    /**
     * save单个实体
     */
    @Override
    public T save(T entry) {
        Session session = this.getSession();
        session.save(entry);
        return entry;
    }
    /**
     * update单个实体
     */
    @Override
    public T update(T entry) {
        Session session = this.getSession();
        session.merge(entry);
        return entry;
    }
    /**
     * 删除单个实体根据主键
     */
    @Override
    public void delete(Serializable uuid) {
        Session session = this.getSession();
        try {
            T entry = this.get(uuid);
            session.delete(entry);
        } catch (CustomException e) {
            logger.debug("Got null for extracted ID; returning null.The UUID is [{}].", uuid);
        }
    }
    /**
     * 删除单个实体根据根据对象
     */
    @Override
    public void delete(T entry) {
        Session session = this.getSession();
        session.delete(entry);
    }
    /**
     * 根据主键批量删除
     */
    @SuppressWarnings("unused")
	@Override
    public void batchDelete(Serializable[] uuids) {
        Session session = this.getSession();
        if (uuids != null) {
            for (Serializable uuid : uuids) {
                this.delete(uuid);
            }
        }
    }

    /**
     * 执行修改hql
     * @param hql
     * @param params
     */
    protected void execute(String hql, Map<String, Object> params) {
        Session session = this.getSession();
        Query query = session.createQuery(hql);
        if (params != null) {
            query.setProperties(params);
        }
        query.executeUpdate();
    }

    /**
     * 执行查询hql带参数返回list
     * @param hql
     * @param params
     * @return
     */
    protected List<T> find(String hql, Map<String, Object> params) {
        Session session = this.getSession();
        Query query = session.createQuery(hql);
        query = this.setParams(params, query);
        List<T> result = query.list();
        return result;
    }

    /**
     * 执行查询hql返回list
     * @param hql
     * @return
     */
    protected List<T> find(String hql) {
    	try{
            Session session = this.getSession();
            Query query = session.createQuery(hql);
            List<T> result = query.list();
            return result;
    	}catch(Exception e){
    		Session session = sessionFactory.openSession();
            Query query = session.createQuery(hql);
            List<T> result = query.list();
            session.close();
            return result;
    	}
    }

    /**
     * 执行查询hql带参数返回实体
     * @param hql
     * @param params
     * @return
     * @throws NullPointerException
     */
    protected T findEntry(String hql, Map<String, Object> params) throws CustomException {
        Session session = this.getSession();
        Query query = session.createQuery(hql);
        query = this.setParams(params, query);
        List<T> result = query.list();
        if (!result.isEmpty())
            return result.get(0);
        else {
            logger.debug("returning null.The hql is [{}].", hql);
            throw new CustomException(CustomExceptionEnum.QUERY_NULL);
        }
    }

    /**
     * 获取总数（待参数）返回int
     * @param hql
     * @param params
     * @return
     */
    protected int getTotalCount(String hql, Map<String, Object> params) {
        int result = 0;
        Session session = this.getSession();
        Query query = session.createQuery(hql);
        query = this.setParams(params, query);
        result = this.getNum(query.list());
        return result;
    }

    /**
     * 获取分页list（待参数）
     * @param hql
     * @param params
     * @param pageNo
     * @param pageSize
     * @return
     */
    protected List<T> find(String hql, Map<String, Object> params, int pageNo, int pageSize) {
        Session session = this.getSession();
        Query query = session.createQuery(hql);
        query = this.setParams(params, query);
        if (pageNo > 0 && pageSize > 0) {
            query.setFirstResult((pageNo - 1) * pageSize).setMaxResults(pageSize);
        }
        List<T> result = query.list();
        return result;
    }

    /**
     * 获取分页后条数
     * @param hql
     * @param params
     * @param pageNo
     * @param pageSize
     * @return
     */
    protected int getTotalCount(String hql, Map<String, Object> params, int pageNo, int pageSize) {
        int result = 0;
        Session session = this.getSession();
        Query query = session.createQuery(hql);
        query = this.setParams(params, query);
        if (pageNo > 0 && pageSize > 0) {
            query.setFirstResult((pageNo - 1) * pageSize).setMaxResults(pageSize);
        }
        result = this.getNum(query.list());
        return result;
    }

    /**
     * 功能：得到记录数的方法
     *
     * @param list
     * @return
     */
    @SuppressWarnings("null")
	protected int getNum(List list) {
        int result = 0;
        if (list != null || list.size() > 0)
            result = Integer.parseInt(list.get(0).toString());
        return result;
    }

    /**
     *刷新session
     */
    protected void flush() {
        Session session = this.getSession();
        session.flush();
    }

    /**
     * 设置查询条件
     * @param params
     * @param query
     * @return
     */
    private Query setParams(Map<String, Object> params, Query query) {
        if (params != null) {
            for (Map.Entry<String, Object> entry : params.entrySet()) {
                if (entry.getValue() instanceof List)
                    query.setParameterList(entry.getKey(), (List) entry.getValue());
                else if (entry.getValue() instanceof Object[])
                    query.setParameterList(entry.getKey(), (Object[]) entry.getValue());
                else if (entry.getValue() instanceof String)
                    query.setParameter(entry.getKey(), entry.getValue());
                else if (entry.getValue() instanceof Object)
                    query.setParameter(entry.getKey(), entry.getValue());
            }
        }
        return query;
    }
    
    /**
     * 根据对象ID逻辑删除对象
     *
     * @param uuid
     */
    protected void logicDelete(Serializable uuid) {
        StringBuilder hql = new StringBuilder();
        hql.append("update ");
        hql.append(entityClass.getName());
        hql.append(" o set o.deleteDate=:date where o.uuid =:uuid");
//        super.getHibernateTemplate().bulkUpdate(hql.toString(), new Date(), uuid);
        this.getSession().createQuery(hql.toString()).setParameter("date",new Date()).setParameter("uuid",uuid).executeUpdate();
    }

    /**
     * 执行原生sql查询
     * @param hql
     * @param params
     * @param pageNo
     * @param pageSize
     * @return
     */
    protected List<String> findBysql(String sql) {
        Session session = this.getSession();
        Query query = session.createSQLQuery(sql);
        List<String> result = query.list();
        return result;
    }
    /**
     * 执行原生sql查询
     * @param hql
     * @param params
     * @param pageNo
     * @param pageSize
     * @return
     */
    protected List<T> findObjBysql(String sql) {
    	Session session = this.getSession();
    	Query query = session.createSQLQuery(sql).addEntity(this.entityClass);
    	List<T> result = query.list();
    	return result;
    }
}
