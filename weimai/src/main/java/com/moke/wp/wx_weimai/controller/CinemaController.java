package com.moke.wp.wx_weimai.controller;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weimai.entity.Cinema;
import com.moke.wp.wx_weimai.entity.Vo.CinemaFilter;
import com.moke.wp.wx_weimai.entity.Vo.CinemaVo;
import com.moke.wp.wx_weimai.entity.Vo.SelectCity;
import com.moke.wp.wx_weimai.service.CinemaService;
import com.moke.wp.wx_weimai.config.util.PageBean;
import com.moke.wp.wx_weimai.config.util.Result;
import com.moke.wp.wx_weimai.entity.Movie;
import com.moke.wp.wx_weimai.entity.Seat;
import com.moke.wp.wx_weimai.entity.Snack;
import com.moke.wp.wx_weimai.entity.Vo.CinemaDetail;
import com.moke.wp.wx_weimai.service.MoviceService;
import com.moke.wp.wx_weimai.service.SeatService;
import com.moke.wp.wx_weimai.service.SnackService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cinema")
public class CinemaController {
    private final static Logger logger = LoggerFactory.getLogger(CinemaController.class);

    @Autowired
    private CinemaService cinemaService;
    @Autowired
    private MoviceService moviceService;
    @Autowired
    private SeatService seatService;
    @Autowired
    private SnackService snackService;

    //获取影厅座位
    @GetMapping("/getSeatByHallId/{hallId}")
    public Result getSeatByHallId(@PathVariable("hallId") Integer hallId,
                                  @RequestParam("timesId") Integer timesId){
        List<Seat> seats = seatService.getSeatByHallId(hallId,timesId);
        return new Result(seats);
    }

    //获取电影院详情
    @GetMapping("/getCinema/{id}")
    public Result getCinema(@PathVariable("id") Integer cinemaId,
                            @RequestParam(value = "movieId",required = false) Integer movieId){
        CinemaDetail cinemaDetail = new CinemaDetail();
        //获取影院详情
        Cinema cinema = cinemaService.getCinemaById(cinemaId);
        cinemaDetail.setCinema(cinema);
        //获取影院当日的电影列表
        List<Movie> movieList = moviceService.getDaysByCinemaIdAndMovieId(cinemaId,movieId);
        cinemaDetail.setMovies(movieList);
        //获取小吃列表
        List<Snack> snackList = snackService.getSnacks(cinemaId);
        cinemaDetail.setSnacks(snackList);
        return new Result(cinemaDetail);
    }


    //获取指定日期的电影院列表(修改增加过滤条件)
    @PostMapping("/getCinemas")
    public Result getCinemas(@RequestParam(value = "movieId",required = false) Integer movieId,
                             @RequestParam(value = "dateTime",required = false) String date,
                             @RequestParam("pageNum") Integer pageNum,
                             @RequestParam("limit") Integer limit,
                             @RequestParam("selectCity") String selectCity,
                             @RequestParam(value = "brandId",required = false) Integer brandId,
                             @RequestParam(value = "serviceId",required = false) Integer serviceId,
                             @RequestParam(value = "hallType",required = false) Integer hallType,
                             @RequestParam(value = "selectRegion",required = false) String selectRegion
                             ){
        JSONObject object = JSONObject.parseObject(selectCity);
        SelectCity cityInfo = object.toJavaObject(SelectCity.class);
        PageBean<CinemaVo> cinemaVoPage =
                cinemaService.getCinemas(movieId,date,pageNum,limit,cityInfo,brandId,serviceId,hallType,selectRegion);
        return new Result(JSONObject.toJSON(cinemaVoPage));
    }

    //获取影院过滤条件列表
    @PostMapping("/getFilters")
    public Result getfilters(@RequestBody SelectCity selectCity) {
        CinemaFilter cinemaFilter = cinemaService.getfilters(selectCity);
        return new Result(JSONObject.toJSON(cinemaFilter));
    }

}
