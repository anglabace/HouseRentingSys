package com.ruanyf.houserenting.action;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.ruanyf.houserenting.entity.User;
import com.ruanyf.houserenting.service.UserService;
import com.ruanyf.houserenting.util.EncryptionUtils;

/**
 * 用户相关Action类
 * 
 * @author Feng
 */
@SuppressWarnings("serial")
public class UserAction extends ActionSupport implements ModelDriven<User> {

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

    /**
     * AJAX验证用户是否存在
     */
    public String checkUserExist() {
        HttpServletResponse resp = ServletActionContext.getResponse();
        
        String respStr;
        if(userService.isExist(user)){
            respStr = "exist";
        } else {
            respStr = "usable";
        }
        
        try {
            resp.getWriter().print(respStr);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    
        return NONE;
    }

    /**
     * 用户注册Action执行的方法
     */
    public String reg() {
        if(userService.isExist(user)){
            addActionError("该用户已存在，请换一个用户名重试");
        } else {
            
            User regUser = new User();
            regUser.setUsername(user.getUsername());
            // 密码SHA-1加密
            regUser.setPassword(EncryptionUtils.getSHA1(user.getPassword()));
            regUser.setEnabled(true);
            
            // 调用业务层的类执行保存方法
            userService.save(regUser);
    
            // TODO 判断是否注册成功
            addActionMessage("用户 " + regUser.getUsername() + " 注册成功");
            ActionContext.getContext().getSession().put("user", regUser);
        }
    
        return SUCCESS;
    }

    /**
     * 用户登录Action执行的方法
     */
    public String login() {
        // 密码SHA-1加密
        user.setPassword(EncryptionUtils.getSHA1(user.getPassword()));

        // 调用业务层的类执行登录方法,返回用户对象
        User fullUser = userService.login(user);

        if (fullUser == null) {
            // 没有找到用户
            addActionError("该用户不存在!");
        } else if (fullUser.getPassword().equals(user.getPassword())) {
            // 密码正确
            if(fullUser.isEnabled()){
                // 用户可用,将用户存入Session
                ActionContext.getContext().getSession().put("user", fullUser);
                addActionMessage("登录成功");
            } else {
                addActionError("该用户已被封禁，如有疑问请联系管理员。");
            }
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
     * 查看（编辑）用户资料
     */
    public String profile() {
        Map<String, Object> session = ActionContext.getContext().getSession();
        
        // 获取最新资料
        User fullUser = userService.findById(((User) session.get("user")).getId());
        
        ActionContext.getContext().getSession().put("user", fullUser);

        return "profile";
    }

    /**
     * 修改用户资料
     */
    public String update() {
        // 获取完整的用户
        User fullUser = userService.findById(user.getId());
        
        // 仅更新修改部分
        fullUser.setRealname(user.getRealname());
        fullUser.setGender(user.getGender());
        fullUser.setPhone(user.getPhone());
        fullUser.setEmail(user.getEmail());
        
        // TODO 图片上传

        userService.update(fullUser);
        
        // TODO 判断是否成功
        this.addActionMessage("个人资料修改成功");
        return profile();
    }



}
