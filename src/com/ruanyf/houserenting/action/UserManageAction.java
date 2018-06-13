package com.ruanyf.houserenting.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.ruanyf.houserenting.entity.PageBean;
import com.ruanyf.houserenting.entity.User;
import com.ruanyf.houserenting.service.UserService;

/**
 * 用户管理相关Action类
 * 
 * @author Feng
 */
@SuppressWarnings("serial")
public class UserManageAction extends ActionSupport implements ModelDriven<User> {

    // 模型驱动使用的对象
    private User user = new User();

    // 使用模型驱动通过get方法接收页面提交的参数
    @Override
    public User getModel() {
        return user;
    }

    // 定义业务层类对象
    private UserService userService;

    // Spring通过set方法自动注入业务层类对象
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    // 注入分页查询参数
    private int currentPage = 1;    // 默认页码
    private int pageSize = 5;   // 默认每页显示5条记录

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    /**
     * 用户注册Action执行的方法
     */
    public String reg() {
        // 调用业务层的类执行保存方法
        userService.save(user);
        // TODO 判断是否注册成功
        addActionMessage("用户 " + user.getUsername() + " 注册成功");
        ActionContext.getContext().getSession().put("user", user);

        return SUCCESS;
    }

    /**
     * 用户登录Action执行的方法
     */
    public String login() {
        // 调用业务层的类执行登录方法,返回用户对象
        User existUser = userService.login(user);
        if (existUser == null) {
            // 没有找到用户
            addActionError("该用户不存在!");
        } else if (existUser.getPassword().equals(user.getPassword())) {
            // 密码正确,登录成功,将用户存入Session
            ActionContext.getContext().getSession().put("user", existUser);
            addActionMessage("登录成功");
        } else {
            // 找到用户但密码错误
            addActionError("密码错误!");
        }

        return SUCCESS;
    }

    /**
     * 退出登录的方法
     */
    public String logout() {
        ActionContext.getContext().getSession().clear(); // 清空session
        addActionMessage("已退出登录");

        return SUCCESS;
    }

    /**
     * （管理）查询的方法
     */
    public String findAll() {
        PageBean<User> pageBean = userService.findByPage(currentPage, pageSize);
        // 将返回的PageBean存入值栈
        ActionContext.getContext().getValueStack().push(pageBean);
        if (pageBean.getCurrentPage() == 1) {
            addActionMessage("当前共有 " + pageBean.getTotalCount() + " 条记录");
        }
        return "findAll";
    }

    /**
     * （管理）查询最后一页的方法
     */
    private String findLastPage() {
        PageBean<User> pageBean = userService.findLastPage(pageSize);
        // 将返回的PageBean存入值栈
        ActionContext.getContext().getValueStack().push(pageBean);
        if (pageBean.getCurrentPage() == 1) {
            this.addActionMessage("当前共有 " + pageBean.getTotalCount() + " 条记录");
        }
        return "findAll";
    }

    /**
     * （管理）保存的方法
     */
    public String save() {
        // 调用业务层的类执行保存分类方法
        userService.save(user);
        // TODO 判断是否成功
        this.addActionMessage("用户 " + user.getUsername() + " 添加成功");
        return findLastPage();
    }

    /**
     * （管理）删除的方法
     */
    public String delete() {
        user = userService.findById(user.getId());
        userService.delete(user);
        // TODO 判断是否成功
        this.addActionMessage("用户  " + user.getUsername() + " 删除成功");
        return findAll();
    }

    /**
     * （管理）进入编辑界面的方法
     */
    public String editUI() {
        user = userService.findById(user.getId());
        return "editUI";
    }

    /**
     * （管理）修改的方法
     */
    public String update() {
        userService.update(user);
        // TODO 判断是否成功
        this.addActionMessage("用户 " + user.getUsername() + " 修改成功");
        return findAll();
    }

    /**
     * 封禁用户
     */
    public String ban(){
        User user2Do = userService.findById(user.getId());
        user2Do.setEnabled(false);
        userService.update(user2Do);
        addActionMessage("用户 " + user2Do.getUsername() + " 封禁成功");
        return findAll();
    }
    
    /**
     * 封禁用户
     */
    public String unban(){
        User user2Do = userService.findById(user.getId());
        user2Do.setEnabled(true);
        userService.update(user2Do);
        addActionMessage("用户 " + user2Do.getUsername() + " 解封成功");
        return findAll();
    }

    /**
     * 设为管理员
     */
    public String grantAdmin(){
        User user2Do = userService.findById(user.getId());
        user2Do.setAdmin(true);
        userService.update(user2Do);
        addActionMessage("已将 " + user2Do.getUsername() + " 设为管理员");
        return findAll();
    }
    
    /**
     * 取消管理员
     */
    public String cancelAdmin(){
        User user2Do = userService.findById(user.getId());
        user2Do.setAdmin(false);
        userService.update(user2Do);
        addActionMessage("已解除 " + user2Do.getUsername() + " 的管理员权限");
        return findAll();
    }
}
