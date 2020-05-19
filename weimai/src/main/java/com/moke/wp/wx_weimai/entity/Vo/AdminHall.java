package com.moke.wp.wx_weimai.entity.Vo;


import com.moke.wp.wx_weimai.entity.Seat;
import com.moke.wp.wx_weimai.entity.Hall;

import java.util.List;

public class AdminHall extends Hall {
    private String cinemaNm;
    private String hallType;
    private List<Seat> seats;

    public AdminHall(Hall hall){
        this.setId(hall.getId());
        this.setCinemaId(hall.getCinemaId());
        this.setHallTypeId(hall.getHallTypeId());
    }

    public String getCinemaNm() {
        return cinemaNm;
    }

    public void setCinemaNm(String cinemaNm) {
        this.cinemaNm = cinemaNm;
    }

    public String getHallType() {
        return hallType;
    }

    public void setHallType(String hallType) {
        this.hallType = hallType;
    }

    public List<Seat> getSeats() {
        return seats;
    }

    public void setSeats(List<Seat> seats) {
        this.seats = seats;
    }
}
