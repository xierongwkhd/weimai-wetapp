package com.moke.wp.wx_weipiao;

import com.moke.wp.wx_weimai.config.es.CinemaRepository;
import com.moke.wp.wx_weimai.config.es.MovieRepository;
import com.moke.wp.wx_weimai.mapper.*;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class WxWeipiaoApplicationTests {

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

    }


}
