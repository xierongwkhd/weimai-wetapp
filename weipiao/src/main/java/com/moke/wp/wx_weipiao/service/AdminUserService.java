package com.moke.wp.wx_weipiao.service;

import com.moke.wp.wx_weipiao.entity.AdminUser;
import com.moke.wp.wx_weipiao.mapper.AdminUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminUserService {
    @Autowired
    private AdminUserMapper adminUserMapper;

    public AdminUser getByUserName(String username) {
        return adminUserMapper.getByUserName(username);
    }
}
