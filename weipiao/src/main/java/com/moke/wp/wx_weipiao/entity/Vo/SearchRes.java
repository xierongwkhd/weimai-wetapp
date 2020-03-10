package com.moke.wp.wx_weipiao.entity.Vo;

import com.moke.wp.wx_weipiao.entity.Movie;
import com.moke.wp.wx_weipiao.entity.Vo.CinemaVo;

import java.util.List;

public class SearchRes {
    private List<Movie> movies;
    private List<CinemaVo> cinemaVos;

    public List<Movie> getMovies() {
        return movies;
    }

    public void setMovies(List<Movie> movies) {
        this.movies = movies;
    }

    public List<CinemaVo> getCinemaVos() {
        return cinemaVos;
    }

    public void setCinemaVos(List<CinemaVo> cinemaVos) {
        this.cinemaVos = cinemaVos;
    }
}
