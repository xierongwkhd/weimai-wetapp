package com.moke.wp.wx_weipiao.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

@TableName("t_hall")
public class Hall extends Model<Hall> {
    private Integer id;

    private Integer cinemaId;

    private Integer hallTypeId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(Integer cinemaId) {
        this.cinemaId = cinemaId;
    }

    public Integer getHallTypeId() {
        return hallTypeId;
    }

    public void setHallTypeId(Integer hallTypeId) {
        this.hallTypeId = hallTypeId;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }
}