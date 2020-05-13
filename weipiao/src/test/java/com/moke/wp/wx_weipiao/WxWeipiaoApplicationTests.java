package com.moke.wp.wx_weipiao;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.config.es.CinemaRepository;
import com.moke.wp.wx_weipiao.config.es.MovieRepository;
import com.moke.wp.wx_weipiao.config.util.Constant;
import com.moke.wp.wx_weipiao.config.util.HttpClientUtil;
import com.moke.wp.wx_weipiao.entity.Cinema;
import com.moke.wp.wx_weipiao.entity.Movie;
import com.moke.wp.wx_weipiao.entity.Seat;
import com.moke.wp.wx_weipiao.mapper.*;
import com.moke.wp.wx_weipiao.service.AiService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
