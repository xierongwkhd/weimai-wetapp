package com.moke.wp.wx_weipiao.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.moke.wp.wx_weipiao.entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper extends BaseMapper<User> {

    @Select("select * from department where id=#{id}")
    public String getDeptById(Integer id);

    @Select("select * from t_user where open_id=#{open_id}")
    User selectByOpenId(String open_id);

    @Update("update t_user set last_login=#{lastLogin} where id=#{id}")
    void updateTimeById(User user);

    @Insert("insert into t_user (avatar_url,nick_name,gender,open_id,last_login)value(#{avatarUrl},#{nickName},#{gender},#{openId},#{lastLogin})")
    void insertUser(User insert_user);

    @Select("select * from t_user where id=#{userId}")
    User selectById(Integer userId);

    @Select("select * from t_user where nick_name like '%${keyword}%' or gender like '%${keyword}%'")
    List<User> getUsers(String keyword);
}
