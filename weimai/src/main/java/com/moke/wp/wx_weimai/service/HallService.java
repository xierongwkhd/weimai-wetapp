package com.moke.wp.wx_weimai.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.moke.wp.wx_weimai.mapper.CinemaMapper;
import com.moke.wp.wx_weimai.mapper.HallTypeMapper;
import com.moke.wp.wx_weimai.config.util.PageBean;
import com.moke.wp.wx_weimai.entity.Hall;
import com.moke.wp.wx_weimai.entity.Vo.AdminHall;
import com.moke.wp.wx_weimai.mapper.HallMapper;
import com.moke.wp.wx_weimai.mapper.SeatMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HallService {

    @Autowired
    private HallMapper hallMapper;
    @Autowired
    private CinemaMapper cinemaMapper;
    @Autowired
    private HallTypeMapper hallTypeMapper;
    @Autowired
    private SeatMapper seatMapper;

    public PageBean<AdminHall> getHalls(Integer pageNum, Integer limit, String keyword, Integer cinemaId) {
        PageHelper.startPage(pageNum,limit);
        List<Hall> halls = hallMapper.getHalls(keyword,cinemaId);
        List<AdminHall> adminHalls = new ArrayList<>();
        for(Hall hall : halls){
            AdminHall adminHall = new AdminHall(hall);
            adminHall.setCinemaNm(cinemaMapper.selectById(hall.getCinemaId()).getNm());
            adminHall.setHallType(hallTypeMapper.selectById(hall.getHallTypeId()).getHalltype());
            adminHall.setSeats(seatMapper.getSeatByHallId(hall.getId()));
            adminHalls.add(adminHall);
        }
        PageInfo pageInfo = new PageInfo(halls);
        PageBean<AdminHall> page = new PageBean<>();
        page.setTr(pageInfo.getPages());
        page.setPc(pageInfo.getPageNum());
        page.setPs(pageInfo.getPageSize());
        page.setBeanList(adminHalls);
        return page;
    }

    public Hall getHallById(Integer hallId) {
        return hallMapper.selectById(hallId);
    }

    public void updateHall(Hall hall) {
        hallMapper.updateById(hall);
    }

    public void deleteHall(Integer hallId) {
        hallMapper.deleteById(hallId);
    }

    public void insertHall(Hall hall) {
        hallMapper.insert(hall);
    }

    public List<Hall> getHallByCinema(Integer cinemaId) {
        return hallMapper.getHallByCinema(cinemaId);
    }
}
