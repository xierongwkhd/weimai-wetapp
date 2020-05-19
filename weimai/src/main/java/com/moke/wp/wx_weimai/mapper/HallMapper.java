package com.moke.wp.wx_weimai.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.moke.wp.wx_weimai.entity.Hall;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HallMapper extends BaseMapper<Hall> {

    @Select("<script>" +
            "select * from t_hall where 1=1 " +
            "<if test='cinemaId!=null'>" +
            "and cinema_id=#{cinemaId}" +
            "</if>" +
            "<if test='keyword!=null'>" +
            "and ( cinema_id in " +
            "(select id from t_cinema where nm like '%${keyword}%')" +
            "or hall_type_id in " +
            "(select id from t_hall_type where hallType like '%${keyword}%'))" +
            "</if>" +
            "</script>")
    List<Hall> getHalls(String keyword, Integer cinemaId);

    @Select("select * from t_hall where cinema_id=#{cinemaId}")
    List<Hall> getHallByCinema(Integer cinemaId);
}
