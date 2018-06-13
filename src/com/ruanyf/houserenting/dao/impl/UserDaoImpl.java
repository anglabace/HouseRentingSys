package com.ruanyf.houserenting.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.ruanyf.houserenting.dao.UserDao;
import com.ruanyf.houserenting.entity.House;
import com.ruanyf.houserenting.entity.User;

/**
 * 用户DAO实现类
 * 
 * @author Feng
 */
public class UserDaoImpl extends HibernateDaoSupport implements UserDao {
    // DAO类继承HibernateDaoSupport类,并通过Spring注入SessionFactory,即可直接使用Hibernate模板进行对象操作

    /**
     * DAO中保存用户的方法
     */
    @Override
    public void save(User user) {
        getHibernateTemplate().save(user);
    }

    /**
     * DAO中根据用户名查询用户的方法
     */
    @Override
    public User findByUsername(User user) {
        String hql = "from User where username = ?";
        List<?> list = getHibernateTemplate().find(hql, user.getUsername());
        if (list.size() > 0) {
            return (User) list.get(0);
        }
        return null;
    }

    /**
     * 获取总记录数的方法
     * 
     * @return 总记录数
     */
    @SuppressWarnings("unchecked")
    @Override
    public int getCount() {
        String hql = "select count(*) from User";
        List<Long> list = (List<Long>) getHibernateTemplate().find(hql);
        if (list.size() > 0) {
            return list.get(0).intValue();
        }
        return 0;
    }

    @Override
    public List<User> findByPage(int begin, int pageSize) {
        return findByPage(begin, pageSize, "id");
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> findByPage(int begin, int pageSize, String orderPropertyName) {
        DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
        criteria.addOrder(Order.desc(orderPropertyName));
        return (List<User>) getHibernateTemplate().findByCriteria(criteria, begin, pageSize);
    }

    /**
     * 按ID查找记录的方法
     * 
     * @param uid
     * @return 查询到的记录
     */
    @Override
    public User findById(int uid) {
        return getHibernateTemplate().get(User.class, uid);
    }

    /**
     * DAO删除的方法
     */
    @Override
    public void delete(User user) {
        getHibernateTemplate().delete(user);
    }

    /**
     * DAO修改的方法
     */
    @Override
    public void update(User user) {
        getHibernateTemplate().update(user);
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.ruanyf.houserenting.dao.BaseDao#findAll()
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<User> findAll() {
        return (List<User>) getHibernateTemplate().find("from User");
    }

}
