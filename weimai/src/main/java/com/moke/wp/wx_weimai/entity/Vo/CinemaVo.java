package com.moke.wp.wx_weimai.entity.Vo;

import com.moke.wp.wx_weimai.entity.Cinema;
import com.moke.wp.wx_weimai.entity.HallType;

import java.util.List;

public class CinemaVo {
    private Cinema cinema;
    private List<HallType> HallTypeList;

    public Cinema getCinema() {
        return cinema;
    }

    public void setCinema(Cinema cinema) {
        this.cinema = cinema;
    }

    public List<HallType> getHallTypeList() {
        return HallTypeList;
    }

    public void setHallTypeList(List<HallType> hallTypeList) {
        HallTypeList = hallTypeList;
    }
}
