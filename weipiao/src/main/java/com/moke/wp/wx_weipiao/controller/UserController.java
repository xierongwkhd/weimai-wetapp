package com.moke.wp.wx_weipiao.controller;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.config.util.Constant;
import com.moke.wp.wx_weipiao.config.util.HttpClientUtil;
import com.moke.wp.wx_weipiao.config.util.Result;
import com.moke.wp.wx_weipiao.config.shiro.WxToken;
import com.moke.wp.wx_weipiao.entity.User;
import com.moke.wp.wx_weipiao.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    private final static Logger logger = LoggerFactory.getLogger(UserController .class);

    @PostMapping("/wxLogin")
    public Result wxLogin(@RequestParam("code") String code,
                          @RequestParam("nickName") String nickName,
                          @RequestParam("avatarUrl") String avatarUrl,
                          @RequestParam("gender") String gender){
        //发送请求完成登录
        Map<String, String> param = new HashMap<>();
        param.put("appid", Constant.WX_LOGIN_APPID);
        param.put("secret", Constant.WX_LOGIN_SECRET);
        param.put("js_code", code);
        param.put("grant_type", Constant.WX_LOGIN_GRANT_TYPE);
        String wxResult = HttpClientUtil.doGet(Constant.WX_LOGIN_URL, param);
        JSONObject jsonObject = JSONObject.parseObject(wxResult);
        String session_key = jsonObject.get("session_key").toString();
        String open_id = jsonObject.get("openid").toString();

        // 根据返回的user实体类，判断用户是否是新用户，不是的话，更新最新登录时间，是的话，将用户信息存到数据库
        Subject subject = SecurityUtils.getSubject();
        User user = new User();
        user.setAvatarUrl(avatarUrl);
        user.setNickName(nickName);
        if(gender.equals("1"))
            user.setGender("男");
        else
            user.setGender("女");
        user.setLastLogin(new Date());
        user.setOpenId(open_id);
        WxToken wxToken = new WxToken(user);
        subject.login(wxToken);

        // 封装返回小程序
        Map<String, String> result = new HashMap<>();
//        result.put("session_key", session_key);
//        result.put("open_id", open_id);
        result.put("token",subject.getSession().getId().toString());

        return new Result(result);
    }

    @GetMapping("/isAuth")
    public Result isAuth(){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated()){
            return new Result(Result.NOAUTHC,"未登录");
        }
        return new Result();
    }
}
