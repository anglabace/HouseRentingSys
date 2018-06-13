package com.ruanyf.houserenting.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.ruanyf.houserenting.dao.HouseDao;
import com.ruanyf.houserenting.entity.House;

/**
 * 房源DAO实现类
 * 
 * @author Feng
 */
public class HouseDaoImpl extends HibernateDaoSupport implements HouseDao {

    public void save(House house) {
        getHibernateTemplate().save(house);
    }

    @SuppressWarnings("unchecked")
    @Override
    public int getCount() {
        String hql = "select count(*) from House";
        List<Long> list = (List<Long>) getHibernateTemplate().find(hql);
        if (list.size() > 0) {
            return list.get(0).intValue();
        }
        return 0;
    }

    @Override
    public List<House> findByPage(int begin, int pageSize) {
        return findByPage(begin, pageSize, "id");
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<House> findByPage(int begin, int pageSize, String orderPropertyName) {
        DetachedCriteria criteria = DetachedCriteria.forClass(House.class);
        criteria.addOrder(Order.desc(orderPropertyName));
        return (List<House>) getHibernateTemplate().findByCriteria(criteria, begin, pageSize);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<House> findByPageExceptWithdraw(int begin, int pageSize, String orderPropertyName) {
        DetachedCriteria criteria = DetachedCriteria.forClass(House.class);
        criteria.addOrder(Order.desc(orderPropertyName));
        criteria.add(Restrictions.eq("status", 1));
        return (List<House>) getHibernateTemplate().findByCriteria(criteria, begin, pageSize);
    }

//    @SuppressWarnings("unchecked")
//    @Override
//    public List<House> findByPageExceptWithdraw(int begin, int pageSize, String orderPropertyName, String keyword) {
//        String hql="from House where user.id like :id"; //参数名称查询  
//        Query query=..createQuery(hql);     
//         query.setString("id", "%"+id+"%");         
//        list=query.list();     
//        transaction.commit();     
//        session.close();     
//
//        String hql = "from House where"
//        
//        DetachedCriteria criteria = DetachedCriteria.forClass(House.class);
//        criteria.addOrder(Order.desc(orderPropertyName));
//        criteria.add(Restrictions.)
//        criteria.add(Restrictions.eq("status", 1));
//        return (List<House>) getHibernateTemplate().findByCriteria(criteria, begin, pageSize);
//    }

    @Override
    public House findById(int id) {
        return getHibernateTemplate().get(House.class, id);
    }

    @Override
    public void delete(House house) {
        getHibernateTemplate().delete(house);
    }

    @Override
    public void update(House house) {
        getHibernateTemplate().update(house);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<House> findAll() {
        return (List<House>) getHibernateTemplate().find("from House");
    }

    @SuppressWarnings("unchecked")
    @Override
    public int getVisitCount() {
        String hql = "select sum(visitCount) from House";
        List<Long> list = (List<Long>) getHibernateTemplate().find(hql);
        if (list.size() > 0) {
            return list.get(0).intValue();
        }
        return 0;
    }

}
