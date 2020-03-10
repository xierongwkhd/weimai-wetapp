package com.moke.wp.wx_weipiao.entity.Vo;

import com.moke.wp.wx_weipiao.entity.Comment;

public class AdminComment extends Comment {
    private String userName;
    private String movieName;

    public AdminComment(Comment comment){
        this.setApprove(comment.getApprove());
        this.setCalcTime(comment.getCalcTime());
        this.setContent(comment.getContent());
        this.setMovieId(comment.getMovieId());
        this.setId(comment.getId());
        this.setSc(comment.getSc());
        this.setUserId(comment.getUserId());
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }
}
