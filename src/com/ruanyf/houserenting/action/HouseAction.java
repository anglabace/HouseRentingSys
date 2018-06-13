package com.ruanyf.houserenting.action;

import java.io.File;
import java.util.ArrayList;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.ruanyf.houserenting.entity.House;
import com.ruanyf.houserenting.entity.PageBean;
import com.ruanyf.houserenting.entity.User;
import com.ruanyf.houserenting.service.HouseService;

/**
 * 房源相关Action类
 * 
 * @author Feng
 */
@SuppressWarnings("serial")
public class HouseAction extends ActionSupport implements ModelDriven<House> {

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
    private int pageSize = 3; // 默认每页显示3条记录

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    
    /*
     * 文件上传相关，相关字段由struts自动封装
     * （File [表单名]; String [表单名]FileName; String [表单名]ContentType）
     */
    //上传文件存放路径   
    private final static String UPLOADDIR = "/upload";   
    //上传文件集合   
    private File[] file;   
    //上传文件名集合   
    private String[] fileFileName;   
    //上传文件内容类型集合   
    @SuppressWarnings("unused")
    private String[] fileContentType;  

    public void setFile(File[] file) {
        this.file = file;
    }

    public void setFileFileName(String[] fileFileName) {
        this.fileFileName = fileFileName;
    }

    public void setFileContentType(String[] fileContentType) {
        this.fileContentType = fileContentType;
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
     * 发布
     */
    public String publish() {
        house.setStatus(1);
        
        User user = (User) ActionContext.getContext().getSession().get("user");
        house.setPublisher(user);
        
        for(int i = 0; i < file.length; i++){
            if(house.getPictures() == null){
                house.setPictures(new ArrayList<String>());
            }
            uploadFile(i);
            house.getPictures().add(fileFileName[i]);
        }

        // 调用业务层的保存方法
        houseService.save(house);

        // TODO 判断是否成功
        this.addActionMessage("发布成功");

        return show();
    }

    /**
     * 查看详情
     */
    public String show() {
        House house2Show = houseService.findById(house.getId());
        
        // 统计访问量
        house2Show.setVisitCount(house2Show.getVisitCount()+1);
        houseService.update(house2Show);
        
        ActionContext.getContext().getSession().put("house", house2Show);
        return "show";
    }

    /**
     * 删除
     */
    public String delete() {
        house = houseService.findById(house.getId());
        houseService.delete(house);
        // TODO 判断是否成功
        this.addActionMessage("删除成功");
        return "delete";
    }

    /**
     * 进入编辑界面的方法
     */
    public String editUI() {
        house = houseService.findById(house.getId());
        return "editUI";
    }

    /**
     * 修改的方法
     */
    public String update() {
        houseService.update(house);
        // TODO 判断是否成功
        this.addActionMessage("更新成功");
        return findAll();
    }
    
    /**
     * 文件上传
     * @param i 索引
     */
    private void uploadFile(int i) {
        String realpath = ServletActionContext.getServletContext().getRealPath(UPLOADDIR);
        File dir = new File(realpath);

        if (!dir.exists()) {
            dir.mkdirs();
        }

        file[i].renameTo(new File(dir, fileFileName[i]));
    }

}
