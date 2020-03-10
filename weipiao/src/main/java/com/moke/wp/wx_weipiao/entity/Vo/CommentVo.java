package com.moke.wp.wx_weipiao.entity.Vo;

import com.moke.wp.wx_weipiao.entity.Comment;

public class CommentVo extends Comment {
    private String userNickname;
    private String userAvatarUrl;
    private Double sorce;
    private Boolean hasApprove;

    public CommentVo(Comment comment){
        this.setApprove(comment.getApprove());
        this.setCalcTime(comment.getCalcTime());
        this.setContent(comment.getContent());
        this.setMovieId(comment.getMovieId());
        this.setId(comment.getId());
        this.setSc(comment.getSc());
        this.setUserId(comment.getUserId());
    }

    public Boolean getHasApprove() {
        return hasApprove;
    }

    public void setHasApprove(Boolean hasApprove) {
        this.hasApprove = hasApprove;
    }

    public String getUserNickname() {
        return userNickname;
    }

    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }

    public String getUserAvatarUrl() {
        return userAvatarUrl;
    }

    public void setUserAvatarUrl(String userAvatarUrl) {
        this.userAvatarUrl = userAvatarUrl;
    }

    public Double getSorce() {
        return sorce;
    }

    public void setSorce(Double sorce) {
        this.sorce = sorce;
    }
}
