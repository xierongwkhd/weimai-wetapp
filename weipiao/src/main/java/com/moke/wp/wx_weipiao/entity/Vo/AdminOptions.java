package com.moke.wp.wx_weipiao.entity.Vo;

import com.moke.wp.wx_weipiao.entity.Cinema;
import com.moke.wp.wx_weipiao.entity.HallType;
import com.moke.wp.wx_weipiao.entity.Movie;

import java.util.List;

public class AdminOptions {
    private List<HallType> hallTypes;
    private List<Cinema> cinemas;
    private List<Movie> movies;

    public List<Movie> getMovies() {
        return movies;
    }

    public void setMovies(List<Movie> movies) {
        this.movies = movies;
    }

    public List<HallType> getHallTypes() {
        return hallTypes;
    }

    public void setHallTypes(List<HallType> hallTypes) {
        this.hallTypes = hallTypes;
    }

    public List<Cinema> getCinemas() {
        return cinemas;
    }

    public void setCinemas(List<Cinema> cinemas) {
        this.cinemas = cinemas;
    }
}
