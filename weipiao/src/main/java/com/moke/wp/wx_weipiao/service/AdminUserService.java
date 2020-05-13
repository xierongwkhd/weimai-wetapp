package com.moke.wp.wx_weipiao.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.moke.wp.wx_weipiao.config.util.PageBean;
import com.moke.wp.wx_weipiao.entity.AdminUser;
import com.moke.wp.wx_weipiao.mapper.AdminRoleMapper;
import com.moke.wp.wx_weipiao.mapper.AdminUserMapper;
import com.moke.wp.wx_weipiao.mapper.CinemaMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminUserService {
    @Autowired
    private AdminUserMapper adminUserMapper;
    @Autowired
    private CinemaMapper cinemaMapper;
    @Autowired
    private AdminRoleMapper adminRoleMapper;

    public AdminUser getByUserName(String username) {
        return adminUserMapper.getByUserName(username);
    }

    public PageBean<AdminUser> getAdmins(Integer pageNum, Integer limit, String keyword) {
        PageHelper.startPage(pageNum,limit);
        List<AdminUser> adminUsers = adminUserMapper.getAdminsByKeword(keyword);
        PageInfo<AdminUser> pageInfo = new PageInfo<>(adminUsers);
        for(AdminUser adminUser : adminUsers){
            if(adminUser.getCineamId()!=null)
                adminUser.setCinemaNm(cinemaMapper.selectById(adminUser.getCineamId()).getNm());
            adminUser.setRoleId(adminRoleMapper.getByUserId(adminUser.getId()).getId());
        }
        PageBean<AdminUser> page = new PageBean<>();
        page.setPc(pageInfo.getPageNum());
        page.setPs(pageInfo.getPageSize());
        page.setTr(pageInfo.getPages());
        page.setBeanList(adminUsers);
        return page;
    }

    public void updateInfo(AdminUser user) {
        adminUserMapper.updateById(user);
    }

    public void insertInfo(AdminUser user) {
        adminUserMapper.insert(user);
    }
}
