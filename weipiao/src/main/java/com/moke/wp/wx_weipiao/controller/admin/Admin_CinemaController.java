package com.moke.wp.wx_weipiao.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.config.map.QQMapUtil;
import com.moke.wp.wx_weipiao.config.util.PageBean;
import com.moke.wp.wx_weipiao.config.util.Result;
import com.moke.wp.wx_weipiao.entity.Cinema;
import com.moke.wp.wx_weipiao.entity.CinemaBrand;
import com.moke.wp.wx_weipiao.entity.Vo.AdminCinema;
import com.moke.wp.wx_weipiao.service.CinemaBrandService;
import com.moke.wp.wx_weipiao.service.CinemaService;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/admin/cinema")
@RequiresPermissions("影院管理")
public class Admin_CinemaController {
    private final static Logger logger = LoggerFactory.getLogger(Admin_CinemaController.class);

    @Autowired
    private CinemaService cinemaService;
    @Autowired
    private CinemaBrandService cinemaBrandService;

    //获取电影院列表
    @GetMapping("/getCinemas")
    public Result getCinemas(@RequestParam("pageNum") Integer pageNum,
                             @RequestParam("limit") Integer limit,
                             @RequestParam(value = "keyword",required = false) String keyword){
        PageBean<AdminCinema> adimCinemaPageBean = cinemaService.getCinema(pageNum,limit,keyword);
        return new Result(adimCinemaPageBean);
    }

    //获取影院品牌列表
    @GetMapping("/getBrandList")
    public Result getBrandList(){
        List<CinemaBrand> brandList = cinemaBrandService.getBrandList();
        return new Result(brandList);
    }

    //更新/添加影院
    @PostMapping("/addCinema")
    public Result addCinema(@RequestBody String cinema){
        String s = StringEscapeUtils.unescapeJava(cinema);
        //JSONObject object = JSONObject.fromObject(s);
        //Cinema cinema1 = (Cinema) JSONObject.toBean(object.getJSONObject("cinema"),Cinema.class);
        Cinema cinema1 = JSONObject.parseObject(s).getJSONObject("cinema").toJavaObject(Cinema.class);
        //修改
        if(cinema1.getId()!=null){
            cinemaService.update(cinema1);
        }else{
            //添加
            Cinema cm = cinemaService.getCinemaByName(cinema1.getNm());
            if(cm!=null)
                return new Result(Result.ERROR,"该电影已存在");
            cinema1 = QQMapUtil.addrToLocat(cinema1);
            cinemaService.insertCinema(cinema1);
        }
        return new Result(cinema1);
    }

    //删除影院
    @PostMapping("/deleteCinema")
    public Result deleteCinema(@RequestBody HashMap<String,Integer> map){
        Integer cinemaId = map.get("cinemaId");
        cinemaService.deleteById(cinemaId);
        return new Result(cinemaId);
    }

    //增加影院品牌
    @PostMapping("/addCinemaBrand")
    public Result addCinemaBrand(@RequestBody HashMap<String,String> map){
        String newBrand = map.get("newBrand");
        Integer newBrandId = cinemaBrandService.insert(newBrand);
        return new Result(newBrandId);
    }
}
