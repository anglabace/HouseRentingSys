package com.ruanyf.houserenting.dao;

import java.util.List;

import com.ruanyf.houserenting.entity.House;

/**
 * 房源DAO接口
 * 
 * @author Feng
 */
public interface HouseDao extends BaseDao<House> {

    /**
     * 获取访问总量
     * @return 所有房源访问总量
     */
    int getVisitCount();

    /**
     * 获取非下架房源
     * @param begin 开始索引
     * @param pageSize 分页大小
     * @param orderPropertyName 按照此字段排序
     * @return 房源列表
     */
    List<House> findByPageExceptWithdraw(int begin, int pageSize, String orderPropertyName);

}
