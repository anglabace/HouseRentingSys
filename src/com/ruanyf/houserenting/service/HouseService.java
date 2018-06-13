package com.ruanyf.houserenting.service;

import java.util.List;

import com.ruanyf.houserenting.entity.House;
import com.ruanyf.houserenting.entity.PageBean;

/**
 * 房源相关业务层接口
 * 
 * @author Feng
 */
public interface HouseService {

    /**
     * 保存
     * 
     * @param house
     */
    void save(House house);

    /**
     * 查找所有
     * 
     * @return
     */
    public List<House> findAll();

    /**
     * 按页码查询
     * 
     * @param currentPage
     * @param pageSize
     * @return
     */
    public PageBean<House> findByPage(int currentPage, int pageSize);

    /**
     * 按页码查询最后一页
     * 
     * @param pageSize
     * @return
     */
    public PageBean<House> findLastPage(int pageSize);

    /**
     * 按ID查询
     * 
     * @param id
     * @return
     */
    public House findById(int id);

    /**
     * 删除
     * 
     * @param house
     */
    public void delete(House house);

    /**
     * 修改
     * 
     * @param house
     */
    public void update(House house);

    /**
     * 获取热门列表
     * 
     * @return
     */
    List<House> getHotList();

    /**
     * 获取最新列表
     * 
     * @return
     */
    List<House> getLatestList();

    /**
     * 获取房源总数
     * 
     * @return 房源数
     */
    int getCount();

    /**
     * 获得所有房源访问量
     * @return 所有房源访问量
     */
    int getVisitCount();

}
