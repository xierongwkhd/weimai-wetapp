package com.moke.wp.wx_weipiao.entity.Vo;

import java.util.List;

public class CommentMess {
    private List<CommentVo> comList;
    private Integer total;

    public List<CommentVo> getComList() {
        return comList;
    }

    public void setComList(List<CommentVo> comList) {
        this.comList = comList;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }
}
