package com.moke.wp.wx_weimai.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.moke.wp.wx_weimai.entity.Comment;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentMapper extends BaseMapper<Comment> {
    @Select("select * from t_comment where movie_id=#{movieId} order by calc_time desc")
    List<Comment> getComment(Integer movieId);

    @Select("select * from t_comment where movie_id=#{movieId} order by approve desc")
    List<Comment> getHotComment(Integer movieId);

    @Insert("insert into t_comment (user_id,movie_id,sc,content,approve,calc_time) values (#{userId},#{movieId},#{sc},#{content},0,now())")
    void addComment(Integer userId, Integer movieId, Integer sc, String content);

    @Select("select * from t_comment where user_id=#{userId} and movie_id=#{movieId} limit 1")
    Comment getIsComment(Integer userId, Integer movieId);

    @Update("update t_comment set sc=#{sc},content=#{content},calc_time=now() where user_id=#{userId} and movie_id=#{movieId}")
    void updateComment(Integer userId, Integer movieId, Integer sc, String content);

    @Select("select * from t_comment where content like '%${keyword}%' order by calc_time desc")
    List<Comment> getComments(String keyword);

    @Update("update t_comment set approve = approve+#{num} where id=#{commentId}")
    void upApproveById(Integer commentId,Integer num);
}
