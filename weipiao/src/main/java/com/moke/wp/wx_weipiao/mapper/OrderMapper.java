package com.moke.wp.wx_weipiao.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.moke.wp.wx_weipiao.entity.Order;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface OrderMapper extends BaseMapper<Order> {
    @Select("select * from t_order where item_type='电影票' and order_uid=#{userId} order by create_time desc")
    List<Order> getMovieOrderByUser(Integer userId);

    @Select("select * from t_order where item_type='电影票' and relate_id=#{timesId} and `describe` like '%${startTime}%'")
    List<Order> getByTimesId(Integer timesId, String startTime);

    @Select("select * from t_order where item_type='小吃' and order_uid=#{userId} order by create_time desc")
    List<Order> getSnackOrderByUser(Integer userId);

    @Select("<script>" +
            "select * from t_order where 1=1 " +
            "<if test='keyword != null '>" +
            "and order_id like '%${keyword}%' " +
            "</if>" +
            "<if test='cinemaId!=null'>" +
            "and ((item_type='小吃' and relate_id=#{cinemaId})" +
            "or" +
            "(item_type='电影票' and relate_id in " +
            "(select id from t_times where days_id in " +
            "(select id from t_days where cinema_id=#{cinemaId}))))" +
            "</if>" +
            "</script>")
    List<Order> getOrders(String keyword, Integer cinemaId);
}
