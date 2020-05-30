package com.moke.wp.wx_weimai;

import com.moke.wp.wx_weimai.config.es.CinemaRepository;
import com.moke.wp.wx_weimai.config.es.MovieRepository;
import com.moke.wp.wx_weimai.entity.Cinema;
import com.moke.wp.wx_weimai.entity.Movie;
import com.moke.wp.wx_weimai.mapper.*;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;
import org.springframework.test.context.ContextConfiguration;

import java.util.List;

@SpringBootTest
class WxWeimaiApplicationTests {

    @Autowired
    private MovieRepository movieRepository;
    @Autowired
    private CinemaRepository cinemaRepository;
    @Autowired
    private MovieMapper movieMapper;
    @Autowired
    private CinemaMapper cinemaMapper;
    @Autowired
    private SeatMapper seatMapper;
    @Autowired
    private DaysMapper daysMapper;
    @Autowired
    private TimesMapper timesMapper;

    @Test
    void contextLoads() {
        List<Movie> movieList = movieMapper.selectAll();
        for(Movie movie : movieList) {
            movieRepository.index(movie);
        }

        List<Cinema> cinemaList = cinemaMapper.selectAll();
        for(Cinema cinema : cinemaList) {
            cinema.setLocation(new GeoPoint(cinema.getLatitude().doubleValue(), cinema.getLongitude().doubleValue()));
            cinemaRepository.index(cinema);
        }
    }


}
