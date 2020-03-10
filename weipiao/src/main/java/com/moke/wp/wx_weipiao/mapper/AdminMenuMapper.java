package com.moke.wp.wx_weipiao.mapper;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdminMenuMapper {

    @Select("<script>" +
            "select permission from t_admin_menu where id in " +
            "(select menu_id from t_admin_role_menu where role_id in " +
            "(select role_id from t_admin_user_role where admin_user_id=#{userId}))" +
            "</script>")
    List<String> selectPermissionByUserId(Integer userId);
}
