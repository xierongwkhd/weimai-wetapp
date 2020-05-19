package com.moke.wp.wx_weimai.mapper;

import com.moke.wp.wx_weimai.entity.AdminRole;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdminRoleMapper {


    @Select("select * from t_admin_role where id in (select role_id from t_admin_user_role where admin_user_id=#{userId})")
    AdminRole getByUserId(Integer userId);

    @Select("select * from t_admin_role")
    List<AdminRole> getRoles();

    @Insert("insert into t_admin_user_role (admin_user_id,role_id) values(#{id},#{roleId})")
    void insertInfo(Integer id, Integer roleId);
}
