package com.ruanyf.houserenting.dao;

import java.util.List;

/**
 * 基本DAO接口
 * 
 * @author Feng
 */
public interface BaseDao<T> {

    /**
     * 获取总记录数
     * 
     * @return 总记录数
     */
    public int getCount();

    /**
     * 查找所有记录
     * 
     * @return 所有对象的列表
     */
    public List<T> findAll();

    /**
     * 按分页查找记录的方法
     * 
     * @param begin 开始索引
     * @param pageSize 分页大小
     * @return 记录列表
     */
    public List<T> findByPage(int begin, int pageSize);
    
    /**
     * 按顺序分页查找
     * @param begin 开始索引
     * @param pageSize 分页大小
     * @param orderPropertyName 按照此字段排序
     * @return 记录列表
     */
    public List<T> findByPage(int begin, int pageSize, String orderPropertyName);

    /**
     * 按主键ID查找记录
     * 
     * @param id 主键
     * @return 查询到的记录对象
     */
    public T findById(int id);

    /**
     * 保存对象
     * 
     * @param object 对象
     */
    public void save(T object);

    /**
     * 修改记录
     * 
     * @param object 要修改的对象
     */
    public void update(T object);

    /**
     * 删除记录
     * 
     * @param object 要删除的对象
     */
    public void delete(T object);

}
