package com.moke.wp.wx_weimai.controller.admin;

import com.moke.wp.wx_weimai.config.shiro.AdminToken;
import com.moke.wp.wx_weimai.entity.AdminUser;
import com.moke.wp.wx_weimai.service.UserService;
import com.moke.wp.wx_weimai.config.util.PageBean;
import com.moke.wp.wx_weimai.config.util.Result;
import com.moke.wp.wx_weimai.entity.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
@RequestMapping("/admin/user")
public class Admin_UserController {
    @Autowired
    private UserService userService;

    //后台登录
    @PostMapping("/login")
    public Result login(@RequestBody HashMap<String, String> map){
        String username = map.get("username");
        String password = map.get("password");
        Subject subject = SecurityUtils.getSubject();
        AdminToken usernamePasswordToken = new AdminToken();
        usernamePasswordToken.setUsername(username);
        usernamePasswordToken.setPassword(password.toCharArray());
        try {
            subject.login(usernamePasswordToken);
        }catch (Exception e){
            return new Result(Result.NOAUTHC,"用户名或密码错误");
        }
        AdminUser adminUser = (AdminUser) subject.getPrincipal();
        return new Result(adminUser);
    }

    //获取用户列表
    @GetMapping("/getUsers")
    @RequiresPermissions("用户管理")
    public Result getUsers(@RequestParam("pageNum") Integer pageNum,
                           @RequestParam("limit") Integer limit,
                           @RequestParam(value = "keyword",required = false) String keyword){
        PageBean<User> userPageBean = userService.getUsers(pageNum,limit,keyword);
        return new Result(userPageBean);
    }

    //禁用用户
    @PostMapping("/banUser")
    @RequiresPermissions("用户管理")
    public Result banUser(@RequestBody HashMap<String,Integer> map){
        Integer userId = map.get("userId");
        userService.banUser(userId);
        return new Result(userId);
    }
}
