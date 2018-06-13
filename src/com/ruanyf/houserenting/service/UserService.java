package com.ruanyf.houserenting.service;

import java.util.List;

import com.ruanyf.houserenting.entity.PageBean;
import com.ruanyf.houserenting.entity.User;

/**
 * 用户管理业务层接口
 * 
 * @author Feng
 */
public interface UserService {

    /**
     * @param user
     */
    void save(User user);

    /**
     * 用户登录
     * 
     * @param user 包含登陆信息的用户对象
     * @return 完整的用户对象
     */
    User login(User user);

    /**
     * 按页码查询
     * 
     * @param currentPage
     * @param pageSize
     * @return
     */
    public PageBean<User> findByPage(int currentPage, int pageSize);

    /**
     * @param pageSize
     * @return
     */
    PageBean<User> findLastPage(int pageSize);

    /**
     * 根据ID查找
     * 
     * @param id
     * @return 查找到的实例
     */
    User findById(int id);

    /**
     * 根据用户名查找用户是否存在
     * 
     * @param user 用户名
     * @return true:若用户存在
     */
    boolean isExist(User user);

    /**
     * @param user
     */
    void delete(User user);

    /**
     * @param user
     */
    void update(User user);

    /**
     * 获取用户总数
     * 
     * @return 用户总数
     */
    int getCount();

    /**
     * 获取所有用户
     * @return
     */
    List<User> findAll();

}
