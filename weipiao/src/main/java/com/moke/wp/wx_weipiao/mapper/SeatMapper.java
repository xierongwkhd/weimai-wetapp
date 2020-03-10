package com.moke.wp.wx_weipiao.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.moke.wp.wx_weipiao.entity.Seat;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.text.MessageFormat;
import java.util.List;
import java.util.Map;

@Repository
public interface SeatMapper extends BaseMapper<Seat> {
    @Select("select * from t_seat where hall_id=#{hallId}")
    List<Seat> getSeatByHallId(Integer hallId);

}
