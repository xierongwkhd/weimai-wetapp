package com.moke.wp.wx_weimai.controller.admin;

import com.moke.wp.wx_weimai.entity.Cinema;
import com.moke.wp.wx_weimai.entity.Hall;
import com.moke.wp.wx_weimai.entity.Movie;
import com.moke.wp.wx_weimai.entity.Times;
import com.moke.wp.wx_weimai.service.*;
import com.moke.wp.wx_weimai.config.util.PageBean;
import com.moke.wp.wx_weimai.config.util.Result;
import com.moke.wp.wx_weimai.entity.Vo.AdminOptions;
import com.moke.wp.wx_weimai.entity.Vo.MovieSchedule;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/admin/schedule")
@RequiresPermissions("排片管理")
public class Admin_DaysAndTimesController {

    @Autowired
    private DaysService daysService;
    @Autowired
    private TimesService timesService;
    @Autowired
    private MoviceService moviceService;
    @Autowired
    private CinemaService cinemaService;
    @Autowired
    private HallService hallService;

    @GetMapping("/getMovieSchedule")
    public Result getMovieSchedule(@RequestParam("pageNum") Integer pageNum,
                                   @RequestParam("limit") Integer limit,
                                   @RequestParam("keyword") String keyword,
                                   @RequestParam(value = "cinemaId",required = false) Integer cinemaId){
        PageBean<MovieSchedule> movieSchedulePageBean = daysService.getMovieSchedule(pageNum,limit,keyword,cinemaId);
        return new Result(movieSchedulePageBean);
    }

    @PostMapping("/addScheduleInfo")
    public Result addScheduleInfo(@RequestBody HashMap<String,String> map) throws ParseException {
        Integer movieId = Integer.parseInt(map.get("movieId"));
        Integer cinemaId = Integer.parseInt(map.get("cinemaId"));
        Integer hallId = Integer.parseInt(map.get("hallId"));
        SimpleDateFormat sdf1 = new SimpleDateFormat( "yyyy-MM-dd" );
        Date showDate = sdf1.parse(map.get("showDate"));
        SimpleDateFormat sdf2 = new SimpleDateFormat( "yyyy-MM-dd HH:mm" );
        Date showTime = sdf2.parse(map.get("showDate") + " " + map.get("showTime"));
        BigDecimal price = new BigDecimal(map.get("price"));
        Times times = daysService.addScheduleInfo(movieId,cinemaId,showDate,hallId,showTime,price);
        if(times==null)
            return new Result(Result.ERROR,"无法添加排片");
        return new Result(times);
    }

    @PostMapping("/deleteMovieSchedule")
    public Result deleteMovieSchedule(@RequestBody HashMap<String,Integer> map){
        Integer timesId = map.get("timesId");
        Integer daysId = map.get("daysId");
        timesService.deleteMovieSchedule(timesId,daysId);
        return new Result(timesId);
    }

    @GetMapping("/getOptions")
    public Result getOptions(){
        List<Movie> movieList = moviceService.getAllMovie();
        List<Cinema> cinemaList = cinemaService.getAllCinema();
        AdminOptions options = new AdminOptions();
        options.setCinemas(cinemaList);
        options.setMovies(movieList);
        return new Result(options);
    }

    @GetMapping("/getHallByCinema")
    public Result getHallByCinema(@RequestParam("cinemaId") Integer cinemaId){
        List<Hall> halls = hallService.getHallByCinema(cinemaId);
        return new Result(halls);
    }

}
