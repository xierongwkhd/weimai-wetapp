package com.moke.wp.wx_weipiao.controller;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.entity.Vo.SelectCity;
import com.moke.wp.wx_weipiao.config.es.MovieRepository;
import com.moke.wp.wx_weipiao.config.util.PageBean;
import com.moke.wp.wx_weipiao.config.util.Result;
import com.moke.wp.wx_weipiao.entity.*;
import com.moke.wp.wx_weipiao.entity.Vo.CinemaVo;
import com.moke.wp.wx_weipiao.entity.Vo.MoviePhoto;
import com.moke.wp.wx_weipiao.entity.Vo.SearchRes;
import com.moke.wp.wx_weipiao.mapper.HallTypeMapper;
import com.moke.wp.wx_weipiao.service.BannerService;
import com.moke.wp.wx_weipiao.service.CinemaService;
import com.moke.wp.wx_weipiao.service.MoviceService;
import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.elasticsearch.common.geo.GeoDistance;
import org.elasticsearch.common.unit.DistanceUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/home")
public class HomeController {
    private final static Logger logger = LoggerFactory.getLogger(UserController .class);

    @Autowired
    private MoviceService moviceService;
    @Autowired
    private BannerService bannerService;
    @Autowired
    private MovieRepository movieRepository;
    @Autowired
    private CinemaService cinemaService;
    @Autowired
    private HallTypeMapper hallTypeMapper;

    //获取首页电影热映列表
    @GetMapping("/getMovieList")
    public Result getMovieList(@RequestParam("pageNum") Integer pageNum,
                               @RequestParam("limit") Integer limit,
                               @RequestParam(value = "addr",required = false) String addr){
        PageBean<Movie> pageBean = moviceService.getList(pageNum,limit,addr);
        return new Result(JSONObject.toJSON(pageBean));
    }

    //获取首页电影待映列表
    @GetMapping("/getMovieWait")
    public Result getMovieWait(@RequestParam("pageNum") Integer pageNum,
                               @RequestParam("limit") Integer limit){
        PageBean<Movie> pageBean = moviceService.getWait(pageNum,limit);
        return new Result(JSONObject.toJSON(pageBean));
    }

    //获取首页电影待映列表(近期受欢迎)
    @GetMapping("/getMoviePop")
    public Result getMoviePop(){
        List<Movie> list = moviceService.getMoviePop();
        return new Result(JSONObject.toJSON(list));
    }

    //电影详情
    @GetMapping("/getMovieById/{id}")
    public Result getMoviePop(@PathVariable("id") Integer id){
        MoviePhoto moviePhoto  = moviceService.getMovieById(id);
        if(moviePhoto==null)
            return new Result(Result.ERROR,"未找到");
        return new Result(moviePhoto);
    }

    //轮播图
    @GetMapping("/getBannerList")
    public Result getBannerList(){
        List<Banner> list = bannerService.getBannerList();
        return new Result(list);
    }

    //更新想看人数
    @PostMapping("/updateWish")
    public Result updateWish(@RequestParam("movieId") Integer movieId){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated())
            return new Result(Result.NOAUTHC,"未登录");
        User user = (User)subject.getPrincipal();
        moviceService.updateWish(user.getId(),movieId);
        return new Result(Result.SUCCESS,"成功");
    }

    //判断是否想看
    @GetMapping("/getIsWish")
    public Result getIsWish(@RequestParam("movieId") Integer movieId){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated())
            return new Result(Result.NOAUTHC,"未登录");
        User user = (User)subject.getPrincipal();
        MovieWish movieWish = moviceService.getIsWish(user.getId(),movieId);
        if(movieWish==null)
            return new Result(false);
        else
            return new Result(true);
    }

    //获取同类型的电影列表
    @GetMapping("/getLikeMovieList")
    public Result getLikeMovieList(@RequestParam("movieId") Integer movieId,
                                   @RequestParam("cat") String cat){
        Subject subject = SecurityUtils.getSubject();
        User user = (User)subject.getPrincipal();
        if(user == null) {
            List<Movie> movies = moviceService.getLikeMovieList(movieId, cat, 3);
            return new Result(movies);
        }else {
            Set<Movie> movies = moviceService.userBasedRecommender(movieId,cat,user.getId(), 4);
            return new Result(movies);
        }
    }


    @PostMapping("/search")
    public Result search(@RequestParam("keyword") String keyword,
                         @RequestParam("stype") Integer stype,
                         @RequestParam("selectCity") String selectCity){
        JSONObject object = JSONObject.parseObject(selectCity);
        SelectCity cityInfo = object.toJavaObject(SelectCity.class);
        SearchRes searchRes = new SearchRes();
        if(stype == -1){
            List<Movie> movies = movieRepository.findByNmLikeOrDirLikeOrCatLikeOrDraLikeOrStarContains(keyword,keyword,keyword,keyword,keyword);
            List<CinemaVo> cinemas = searchCinema(keyword,cityInfo);
            searchRes.setMovies(movies);
            searchRes.setCinemaVos(cinemas);
        }else if(stype == 2){
            List<CinemaVo> cinemas = searchCinema(keyword,cityInfo);
            searchRes.setCinemaVos(cinemas);
        }
        return new Result(searchRes);
    }

    private List<CinemaVo> searchCinema(String keyword,SelectCity cityInfo){
        Page<Cinema> page =  cinemaService.findPage(keyword,
                cityInfo.getLatitude().doubleValue(),
                cityInfo.getLongitude().doubleValue(),
                PageRequest.of(0, 50));
        List<Cinema> cinemas = page.getContent();
        cinemas.forEach(emp->{
            double distance = GeoDistance.ARC.calculate(
                    cityInfo.getLatitude().doubleValue(),
                    cityInfo.getLongitude().doubleValue(),
                    emp.getLocation().getLat(),emp.getLocation().getLon(),
                    DistanceUnit.KILOMETERS);
            emp.setDistance(new BigDecimal(distance).setScale(1,BigDecimal.ROUND_HALF_UP));
        });
        List<CinemaVo> cinemaVoList = new ArrayList<CinemaVo>();
        for(Cinema cinema : cinemas){
            CinemaVo cinemaVo = new CinemaVo();
            cinemaVo.setCinema(cinema);
            cinemaVo.setHallTypeList(hallTypeMapper.getHallTypeByCinemaId(cinema.getId()));
            cinemaVoList.add(cinemaVo);
        }
        return  cinemaVoList;
    }
}
