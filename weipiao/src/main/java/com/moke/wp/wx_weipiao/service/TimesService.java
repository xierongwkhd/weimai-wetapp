package com.moke.wp.wx_weipiao.service;

import com.moke.wp.wx_weipiao.entity.Times;
import com.moke.wp.wx_weipiao.mapper.DaysMapper;
import com.moke.wp.wx_weipiao.mapper.TimesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TimesService {
    @Autowired
    private TimesMapper timesMapper;
    @Autowired
    private DaysMapper daysMapper;

    public void deleteMovieSchedule(Integer timesId,Integer daysId) {
        timesMapper.deleteById(timesId);
        if(daysMapper.isHashTimes(daysId)==0){
            daysMapper.deleteById(daysId);
        }
    }
}
