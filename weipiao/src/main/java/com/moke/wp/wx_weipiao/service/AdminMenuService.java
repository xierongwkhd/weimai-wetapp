package com.moke.wp.wx_weipiao.service;

import com.moke.wp.wx_weipiao.entity.AdminMenu;
import com.moke.wp.wx_weipiao.mapper.AdminMenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminMenuService {
    @Autowired
    private AdminMenuMapper adminMenuMapper;

    public List<String> selectPermissionByUserId(Integer userId) {
        return adminMenuMapper.selectPermissionByUserId(userId);
    }
}
