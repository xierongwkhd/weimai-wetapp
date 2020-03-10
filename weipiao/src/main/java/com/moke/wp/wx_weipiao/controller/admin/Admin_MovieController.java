package com.moke.wp.wx_weipiao.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.config.util.PageBean;
import com.moke.wp.wx_weipiao.config.util.Result;
import com.moke.wp.wx_weipiao.entity.Movie;
import com.moke.wp.wx_weipiao.entity.Vo.MoviePhoto;
import com.moke.wp.wx_weipiao.service.FileService;
import com.moke.wp.wx_weipiao.service.MoviceService;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/movie")
public class Admin_MovieController {
    private final static Logger logger = LoggerFactory.getLogger(Admin_MovieController.class);

    @Autowired
    private MoviceService moviceService;
    @Autowired
    private FileService fileService;

    @PostMapping("/addMoive")
    @RequiresPermissions("电影管理")
    public Result addMovie(@RequestBody String movie){
        String s = StringEscapeUtils.unescapeJava(movie);
//        JSONObject object = JSONObject.fromObject(s);
//        Movie movie1 = (Movie) JSONObject.toBean(object.getJSONObject("movie"),Movie.class);
        Movie movie1 = JSONObject.parseObject(s).getJSONObject("movie").toJavaObject(Movie.class);
        StringBuffer stringBuffer = new StringBuffer();
        for(String ss : movie1.getPhotosList()){
            stringBuffer.append(ss+",");
        }
        movie1.setPhotos(stringBuffer.substring(0,stringBuffer.length()-1));
        //修改
        if(movie1.getId()!=null){
            moviceService.update(movie1);
        }else{
            //添加
            Movie mv = moviceService.getMovieByName(movie1.getNm());
            if(mv!=null)
                return new Result(Result.ERROR,"该电影已存在");
            moviceService.insertMovie(movie1);
        }
        return new Result(movie);
    }

    @PostMapping("/deleteMovie")
    @RequiresPermissions("电影管理")
    public Result deleteMovie(@RequestBody HashMap<String, String> map){
        Integer movieId = Integer.parseInt(map.get("movieId"));
        moviceService.deleteById(movieId);
        return new Result(movieId);
    }

    @GetMapping("/getMovies")
    @RequiresPermissions("电影管理")
    public Result getMovies(@RequestParam("pageNum") Integer pageNum,
                           @RequestParam("limit") Integer limit,
                           @RequestParam(value = "keyword",required = false) String keyword){
        PageBean<Movie> moviePageBean = moviceService.getMovies(pageNum,limit,keyword);
        return new Result(moviePageBean);
    }

    @PostMapping("/upLoadFile")
    @RequiresPermissions("上传文件")
    public Result upLoadFile(@RequestParam(value = "img",required = false) MultipartFile img,
                             @RequestParam(value = "videoImg",required = false) MultipartFile videoImg,
                             @RequestParam(value = "video",required = false) MultipartFile video){
        Map<String,String> res = new HashMap<>();
        if(img!=null){
            String fileNameImg = fileService.storeFile(img);
            res.put("img",fileNameImg);
        }
        if(videoImg!=null){
            String fileNameVideoImg = fileService.storeFile(videoImg);
            res.put("videoImg",fileNameVideoImg);
        }
        if(video!=null){
            String fileNameVideo = fileService.storeFile(video);
            res.put("video",fileNameVideo);
        }
        return new Result(res);
    }
}
