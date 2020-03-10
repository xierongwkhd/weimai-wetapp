package com.moke.wp.wx_weipiao.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

@TableName("t_hall_type")
public class HallType extends Model<HallType> {
    private Integer id;

    private String halltype;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getHalltype() {
        return halltype;
    }

    public void setHalltype(String halltype) {
        this.halltype = halltype == null ? null : halltype.trim();
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }
}