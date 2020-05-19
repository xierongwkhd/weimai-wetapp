package com.moke.wp.wx_weimai.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.moke.wp.wx_weimai.config.util.PageBean;
import com.moke.wp.wx_weimai.entity.User;
import com.moke.wp.wx_weimai.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    public User selectByOpenId(String open_id){
        return userMapper.selectByOpenId(open_id);
    }

    public void updateById(User user) {
        userMapper.updateTimeById(user);
    }

    public void insertUser(User insert_user) {
        userMapper.insertUser(insert_user);
    }


    public PageBean<User> getUsers(Integer pageNum, Integer limit, String keyword) {
        PageHelper.startPage(pageNum,limit);
        List<User> userList = userMapper.getUsers(keyword);
        PageBean<User> page = new PageBean<>();
        PageInfo pageInfo = new PageInfo(userList);
        page.setPc(pageInfo.getPageNum());
        page.setTr(pageInfo.getPages());
        page.setPs(pageInfo.getPageSize());
        page.setBeanList(userList);
        return page;
    }

    public void banUser(Integer userId) {
        User user = userMapper.selectById(userId);
        user.setIsBanned(!user.getIsBanned());
        userMapper.updateById(user);
    }
}
