package com.moke.wp.wx_weimai.config.util;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;
import java.util.List;

public class PageBean<T> implements Serializable {

    private static final long serialVersionUID = 5868659764964018199L;

    private int pc;// 当前页码page code
    //总页数tp：由tr/ps计算可得
    private int tr;// 总记录数total record
    private int ps;// 每页记录数page size
    private List<T> beanList;// 当前页的记录

    public int getPc() {
        return pc;
    }

    public int getTr() {
        return tr;
    }

    public int getPs() {
        return ps;
    }

    public List<T> getBeanList() {
        return beanList;
    }

    public void setPc(int pc) {
        this.pc = pc;
    }

    public void setTr(int tr) {
        this.tr = tr;
    }

    public void setPs(int ps) {
        this.ps = ps;
    }

    public void setBeanList(List<T> beanList) {
        this.beanList = beanList;
    }
}

