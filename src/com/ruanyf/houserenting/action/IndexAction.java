package com.ruanyf.houserenting.action;

import java.util.List;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.ruanyf.houserenting.entity.House;
import com.ruanyf.houserenting.service.HouseService;
import com.ruanyf.houserenting.service.UserService;

/**
 * 首页相关Action
 * 
 * @author Feng
 */
@SuppressWarnings("serial")
public class IndexAction extends ActionSupport {

    @SuppressWarnings("unused")
    private UserService userService;
    private HouseService houseService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setHouseService(HouseService houseService) {
        this.houseService = houseService;
    }

    /**
     * 默认执行的方法：加载首页元素
     */
    @Override
    public String execute() {
        List<House> hotList = houseService.getHotList();
        List<House> latestList = houseService.getLatestList();

        ActionContext.getContext().getValueStack().set("hotList", hotList);
        ActionContext.getContext().getValueStack().set("latestList", latestList);
        
        return SUCCESS;
    }

}
