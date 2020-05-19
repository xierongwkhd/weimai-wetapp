package com.moke.wp.wx_weimai.mapper;

import com.moke.wp.wx_weimai.entity.MovieWish;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface MovieWishMapper {
    @Select("select * from t_movie_wish where user_id=#{userId} and movie_id=#{movieId}")
    MovieWish getByUserAndMovie(Integer userId, Integer movieId);

    @Delete("delete from t_movie_wish where id=#{id}")
    void deletById(Integer id);

    @Insert("insert into t_movie_wish (user_id,movie_id) values (#{userId},#{movieId})")
    void addWish(Integer userId, Integer movieId);
}
