package com.ruanyf.houserenting.service.impl;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.ruanyf.houserenting.dao.HouseDao;
import com.ruanyf.houserenting.entity.House;
import com.ruanyf.houserenting.entity.PageBean;
import com.ruanyf.houserenting.service.HouseService;

/**
 * 房源管理业务层实现类
 * 
 * @author Feng
 */
@Transactional
public class HouseServiceImpl implements HouseService {

    private HouseDao houseDao;

    public void setHouseDao(HouseDao houseDao) {
        this.houseDao = houseDao;
    }

    /**
     * 业务层保存题目的方法
     * 
     * @param question
     */
    public void save(House question) {
        houseDao.save(question);
    }

    /**
     * 业务层查询所有的方法
     */
    @Override
    public List<House> findAll() {
        return houseDao.findAll();
    }

    /**
     * 按页码查询
     * 
     * @param currentPage
     */
    @Override
    public PageBean<House> findByPage(int currentPage, int pageSize) {

        int totalCount = houseDao.getCount(); // 获取总记录数
        int totalPage = (int) Math.ceil((double) totalCount / pageSize); // 计算总页数

        // 获取每页显示的数据
        int begin = (currentPage - 1) * pageSize;
        List<House> list = houseDao.findByPage(begin, pageSize);

        return new PageBean<House>(currentPage, pageSize, totalPage, totalCount, list);
    }

    /**
     * 业务层查询最后一页
     */
    @Override
    public PageBean<House> findLastPage(int pageSize) {

        int totalCount = houseDao.getCount(); // 获取总记录数
        int totalPage = (int) Math.ceil((double) totalCount / pageSize); // 计算总页数

        // 获取每页显示的数据
        int begin = (totalPage - 1) * pageSize;
        List<House> list = houseDao.findByPage(begin, pageSize);

        return new PageBean<House>(totalPage, pageSize, totalPage, totalCount, list);
    }

    /**
     * 业务层按ID查询的方法
     */
    @Override
    public House findById(int id) {
        return houseDao.findById(id);
    }

    /**
     * 业务层删除分类的方法
     * 
     * @param question
     */
    @Override
    public void delete(House question) {
        houseDao.delete(question);
    }

    /**
     * 业务层修改分类的方法
     * 
     * @param question
     */
    @Override
    public void update(House question) {
        houseDao.update(question);
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.ruanyf.houserenting.service.HouseService#getHotList()
     */
    @Override
    public List<House> getHotList() {
        // return houseDao.findByPage(0, 20, "visitCount");
        return houseDao.findByPageExceptWithdraw(0, 20, "visitCount");
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.ruanyf.houserenting.service.HouseService#getLatestList()
     */
    @Override
    public List<House> getLatestList() {
        // return houseDao.findByPage(0, 20);
        return houseDao.findByPageExceptWithdraw(0, 20, "id");
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.ruanyf.houserenting.service.HouseService#getCount()
     */
    @Override
    public int getCount() {
        return houseDao.getCount();
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.ruanyf.houserenting.service.HouseService#getVisitCount()
     */
    @Override
    public int getVisitCount() {
        return houseDao.getVisitCount();
    }

}
