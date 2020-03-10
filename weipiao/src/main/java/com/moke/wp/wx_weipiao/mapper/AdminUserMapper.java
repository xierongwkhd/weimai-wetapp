package com.moke.wp.wx_weipiao.mapper;

import com.moke.wp.wx_weipiao.entity.AdminUser;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminUserMapper {

    @Select("select * from t_admin_user where username=#{username}")
    AdminUser getByUserName(String username);
}
