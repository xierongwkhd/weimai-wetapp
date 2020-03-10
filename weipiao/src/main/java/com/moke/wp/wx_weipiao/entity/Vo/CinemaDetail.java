package com.moke.wp.wx_weipiao.entity.Vo;

import com.moke.wp.wx_weipiao.entity.Cinema;
import com.moke.wp.wx_weipiao.entity.Movie;
import com.moke.wp.wx_weipiao.entity.Snack;

import java.util.List;

public class CinemaDetail {
    private Cinema cinema;
    private List<Movie> movies;
    private List<Snack> snacks;

    public List<Snack> getSnacks() {
        return snacks;
    }

    public void setSnacks(List<Snack> snacks) {
        this.snacks = snacks;
    }

    public Cinema getCinema() {
        return cinema;
    }

    public void setCinema(Cinema cinema) {
        this.cinema = cinema;
    }

    public List<Movie> getMovies() {
        return movies;
    }

    public void setMovies(List<Movie> movies) {
        this.movies = movies;
    }
}
