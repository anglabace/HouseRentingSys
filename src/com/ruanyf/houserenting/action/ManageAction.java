package com.ruanyf.houserenting.action;

import java.util.List;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.ruanyf.houserenting.entity.House;
import com.ruanyf.houserenting.entity.User;
import com.ruanyf.houserenting.service.HouseService;
import com.ruanyf.houserenting.service.UserService;

/**
 * 后台管理相关Action类
 * 
 * @author Feng
 */
@SuppressWarnings("serial")
public class ManageAction extends ActionSupport implements ModelDriven<User> {

    // 模型驱动使用的对象
    private User user = new User();
    
    // 使用模型驱动通过get方法接收页面提交的参数
    @Override
    public User getModel() {
        return user;
    }

    /*
     * 定义业务层类对象 Spring通过set方法自动注入业务层类对象
     */
    private UserService userService;
    private HouseService houseService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setHouseService(HouseService houseService) {
        this.houseService = houseService;
    }
    
    /**
     * 默认执行的方法：加载仪表盘
     */
    @Override
    public String execute() {
        int userCount = userService.getCount();
        int houseCount = houseService.getCount();
        int houseVisitCount = houseService.getVisitCount();
        
        ActionContext.getContext().getValueStack().set("userCount", userCount);
        ActionContext.getContext().getValueStack().set("houseCount", houseCount);
        ActionContext.getContext().getValueStack().set("houseVisitCount", houseVisitCount);
        
        List<User> userList = userService.findAll();
        List<House> hotList = houseService.getHotList();
        List<House> latestList = houseService.getLatestList();

        ActionContext.getContext().getValueStack().set("userList", userList);
        ActionContext.getContext().getValueStack().set("hotList", hotList);
        ActionContext.getContext().getValueStack().set("latestList", latestList);

        return SUCCESS;
    }


    /**
     * （验证）用户未登录时执行的方法
     */
    public String notLogin() {
        addActionError("用户未登录");
        return ERROR;
    }

    /**
     * （验证）用户权限不足时执行的方法
     */
    public String notAdmin() {
        addActionError("权限不足，请登录管理员账户");
        return ERROR;
    }

}
