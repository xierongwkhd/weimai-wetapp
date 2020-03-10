package com.moke.wp.wx_weipiao.entity.Vo;

import com.moke.wp.wx_weipiao.entity.Days;
import com.moke.wp.wx_weipiao.entity.Times;

import java.text.SimpleDateFormat;

public class MovieSchedule extends Times{
    private String movieNm;
    private String cinemaNm;
    private String hallNm;
    private Days days;
    private String time;

    public MovieSchedule(Times times){
        this.setId(times.getId());
        this.setDaysId(times.getDaysId());
        this.setPrice(times.getPrice());
        this.setHallId(times.getHallId());
        this.setStartTime(times.getStartTime());
        SimpleDateFormat format = new SimpleDateFormat("HH:mm");
        this.time = format.format(times.getStartTime());
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getMovieNm() {
        return movieNm;
    }

    public void setMovieNm(String movieNm) {
        this.movieNm = movieNm;
    }

    public String getCinemaNm() {
        return cinemaNm;
    }

    public void setCinemaNm(String cinemaNm) {
        this.cinemaNm = cinemaNm;
    }

    public String getHallNm() {
        return hallNm;
    }

    public void setHallNm(String hallNm) {
        this.hallNm = hallNm;
    }

    public Days getDays() {
        return days;
    }

    public void setDays(Days days) {
        this.days = days;
    }
}
