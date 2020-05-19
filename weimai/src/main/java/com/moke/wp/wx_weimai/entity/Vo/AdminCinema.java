package com.moke.wp.wx_weimai.entity.Vo;

import com.moke.wp.wx_weimai.entity.Cinema;

public class AdminCinema extends Cinema {
    private String brandName;

    public AdminCinema(Cinema cinema){
        this.setId(cinema.getId());
        this.setNm(cinema.getNm());
        this.setAddr(cinema.getAddr());
        this.setEndorse(cinema.getEndorse());
        this.setAllowrefund(cinema.getAllowrefund());
        this.setBrandId(cinema.getBrandId());
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
}
