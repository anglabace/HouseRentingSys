package com.ruanyf.houserenting.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.ruanyf.houserenting.entity.PageBean;
import com.ruanyf.houserenting.entity.House;
import com.ruanyf.houserenting.service.HouseService;

/**
 * 房源相关Action类
 * 
 * @author Feng
 */
@SuppressWarnings("serial")
public class HouseManageAction extends ActionSupport implements ModelDriven<House> {

    // 使用模型驱动接收参数
    private House house = new House();

    @Override
    public House getModel() {
        return house;
    }

    // 注入业务层类对象
    private HouseService houseService;

    public void setHouseService(HouseService houseService) {
        this.houseService = houseService;
    }

    // 注入分页查询参数
    private int currentPage = 1; // 默认页码
    private int pageSize = 5; // 默认每页显示5条记录

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    /**
     * 查询的方法
     */
    public String findAll() {
        PageBean<House> pageBean = houseService.findByPage(currentPage, pageSize);
        // 将返回的PageBean存入值栈
        ActionContext.getContext().getValueStack().push(pageBean);
        if (pageBean.getCurrentPage() == 1) {
            this.addActionMessage("当前共有 " + pageBean.getTotalCount() + " 条记录");
        }
        return "findAll";
    }

    /**
     * 查询最后一页的方法
     */
    public String findLastPage() {
        PageBean<House> pageBean = houseService.findLastPage(pageSize);
        // 将返回的PageBean存入值栈
        ActionContext.getContext().getValueStack().push(pageBean);
        if (pageBean.getCurrentPage() == 1) {
            this.addActionMessage("当前共有 " + pageBean.getTotalCount() + " 条记录");
        }
        return "findAll";
    }
    
    /**
     * 下架
     */
    public String withdraw(){
        House house2Do = houseService.findById(house.getId());
        house2Do.setStatus(0);
        houseService.update(house2Do);
        addActionMessage("已将该房源下架");
        return findAll();
    }
    
    /**
     * 重新上架
     */
    public String withdrawRecovery(){
        House house2Do = houseService.findById(house.getId());
        house2Do.setStatus(1);
        houseService.update(house2Do);
        addActionMessage("已将该房源重新上架");
        return findAll();
    }

}
