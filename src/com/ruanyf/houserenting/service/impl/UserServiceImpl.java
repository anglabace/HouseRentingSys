package com.ruanyf.houserenting.service.impl;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.ruanyf.houserenting.dao.UserDao;
import com.ruanyf.houserenting.entity.PageBean;
import com.ruanyf.houserenting.entity.User;
import com.ruanyf.houserenting.service.UserService;

/**
 * 用户管理业务层实现类
 * @author Feng
 */
@Transactional
public class UserServiceImpl implements UserService {
	
	// 定义DAO类对象
	private UserDao userDao;
	// Spring通过set方法自动注入DAO类对象
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	/**
	 * 注册用户的方法
	 */
	@Override
	public void save(User user) {
		// 调用DAO执行保存方法
		userDao.save(user);
	}

	/**
	 * 业务层用户登录的方法
	 */
	@Override
	public User login(User user) {
		// 调用DAO执行登录方法,返回用户对象
		return userDao.findByUsername(user);
	}

	/**
	 * 按页码查询
	 * @param currentPage
	 */
	@Override
	public PageBean<User> findByPage(int currentPage, int pageSize) {
		PageBean<User> pageBean = new PageBean<User>();
		
		int totalCount = userDao.getCount();	// 获取总记录数
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);	// 计算总页数
		// 获取每页显示的数据
		int begin = (currentPage - 1) * pageSize;
		List<User> list = userDao.findByPage(begin, pageSize);
		
		// 封装数据到分页对象
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalCount(totalCount);
		pageBean.setTotalPage(totalPage);
		pageBean.setList(list);

		return pageBean;
	}

	/**
	 * 业务层查询最后一页
	 */
	@Override
	public PageBean<User> findLastPage(int pageSize) {
		
		int totalCount = userDao.getCount();	// 获取总记录数
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);	// 计算总页数
		
		// 获取每页显示的数据 
		int begin = (totalPage - 1) * pageSize;
		List<User> list = userDao.findByPage(begin, pageSize);

		return new PageBean<User>(totalPage, pageSize, totalPage, totalCount, list);
	}

	/**
	 * 业务层按ID查询的方法
	 */
	@Override
	public User findById(int uid) {
		return userDao.findById(uid);
	}

	/**
	 * 业务层删除的方法
	 * @param category
	 */
	@Override
	public void delete(User user) {
		userDao.delete(user);
	}

	/**
	 * 业务层修改的方法
	 * @param category
	 */
	@Override
	public void update(User user) {
		userDao.update(user);
	}

    /* (non-Javadoc)
     * @see com.ruanyf.houserenting.service.UserService#getCount()
     */
    @Override
    public int getCount() {
        return userDao.getCount();
    }

    /* (non-Javadoc)
     * @see com.ruanyf.houserenting.service.UserService#isExist(java.lang.String)
     */
    @Override
    public boolean isExist(User user) {
        return userDao.findByUsername(user) != null;
    }

    /* (non-Javadoc)
     * @see com.ruanyf.houserenting.service.UserService#findAll()
     */
    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

}
