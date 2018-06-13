package com.ruanyf.houserenting.dao;

import com.ruanyf.houserenting.entity.User;

/**
 * 用户DAO接口
 * 
 * @author Feng
 */
public interface UserDao extends BaseDao<User> {

    /**
     * 根据用户名查找用户
     * 
     * @param user 用户对象（设置了用户名）
     * @return 查找到的用户实例
     */
    User findByUsername(User user);

}
