package com.moke.wp.wx_weimai.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.moke.wp.wx_weimai.entity.Days;
import com.moke.wp.wx_weimai.entity.Times;
import com.moke.wp.wx_weimai.entity.Vo.MovieSchedule;
import com.moke.wp.wx_weimai.mapper.CinemaMapper;
import com.moke.wp.wx_weimai.mapper.DaysMapper;
import com.moke.wp.wx_weimai.mapper.TimesMapper;
import com.moke.wp.wx_weimai.config.util.PageBean;
import com.moke.wp.wx_weimai.mapper.MovieMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class DaysService {

    @Autowired
    private DaysMapper daysMapper;
    @Autowired
    private TimesMapper timesMapper;
    @Autowired
    private CinemaMapper cinemaMapper;
    @Autowired
    private MovieMapper movieMapper;

    public PageBean<MovieSchedule> getMovieSchedule(Integer pageNum, Integer limit, String keyword, Integer cinemaId) {
        PageHelper.startPage(pageNum,limit);
        List<Times> times = timesMapper.getAll(keyword,cinemaId);
        List<MovieSchedule> res = new ArrayList<>();
        for(Times t : times){
            MovieSchedule schedule = new MovieSchedule(t);
            schedule.setHallNm(t.getHallId()+"号厅");
            Days days = daysMapper.selectById(t.getDaysId());
            schedule.setDays(days);
            schedule.setCinemaNm(cinemaMapper.selectById(days.getCinemaId()).getNm());
            schedule.setMovieNm(movieMapper.selectById(days.getMovieId()).getNm());
            res.add(schedule);
        }
        PageInfo pageInfo = new PageInfo(times);
        PageBean<MovieSchedule> page = new PageBean<>();
        page.setBeanList(res);
        page.setTr(pageInfo.getPages());
        page.setPs(pageInfo.getPageSize());
        page.setPc(pageInfo.getPageNum());
        return page;
    }

    @Transactional
    public Times addScheduleInfo(Integer movieId, Integer cinemaId, Date showDate, Integer hallId, Date showTime, BigDecimal price) {
        //检查t_days
        Days days = new Days();
        days.setMovieId(movieId);
        days.setCinemaId(cinemaId);
        days.setDay(showDate);
        Days daysIn = daysMapper.selectOne(days);
        Integer daysId = 0;
        if(daysIn==null) {
            daysMapper.insert(days);
            daysId = days.getId();
        }else
            daysId = daysIn.getId();
        //插入times
        Times times = new Times();
        times.setDaysId(daysId);
        times.setHallId(hallId);
        times.setStartTime(showTime);
        times.setPrice(price);
        Times timesIn = timesMapper.selectOne(times);
        if(timesIn==null)
            timesMapper.insert(times);
        else
            return null;
        return times;
    }
}
