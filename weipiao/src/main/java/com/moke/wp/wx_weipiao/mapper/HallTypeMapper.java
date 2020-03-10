package com.moke.wp.wx_weipiao.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.moke.wp.wx_weipiao.entity.HallType;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HallTypeMapper extends BaseMapper<HallType> {

    @Select("select distinct * from t_hall_type where id in (select hall_type_id from t_hall where cinema_id=#{id})")
    List<HallType> getHallTypeByCinemaId(Integer id);

    @Select("select * from t_hall_type")
    List<HallType> getAll();
}
