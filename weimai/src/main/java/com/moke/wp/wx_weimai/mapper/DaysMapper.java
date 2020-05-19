package com.moke.wp.wx_weimai.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.moke.wp.wx_weimai.entity.Days;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DaysMapper extends BaseMapper<Days> {

    @Select("select * from t_days where cinema_id=#{cinemaId} and movie_id=#{movieId} and to_days(day)>=to_days(now()) order by day asc")
    List<Days> getDaysByCinemaIdAndMovieId(Integer cinemaId, Integer movieId);

    @Update("update t_days set day=DATE_ADD(day,INTERVAL 1 DAY)")
    void updateDay();

    @Select("select count(*) from t_times where days_id in (select id from t_days where id=#{daysId})")
    int isHashTimes(Integer daysId);
}
