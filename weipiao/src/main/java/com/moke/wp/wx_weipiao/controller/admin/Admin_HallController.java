package com.moke.wp.wx_weipiao.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.config.util.PageBean;
import com.moke.wp.wx_weipiao.config.util.Result;
import com.moke.wp.wx_weipiao.entity.Cinema;
import com.moke.wp.wx_weipiao.entity.Hall;
import com.moke.wp.wx_weipiao.entity.HallType;
import com.moke.wp.wx_weipiao.entity.Seat;
import com.moke.wp.wx_weipiao.entity.Vo.AdminHall;
import com.moke.wp.wx_weipiao.entity.Vo.AdminOptions;
import com.moke.wp.wx_weipiao.service.CinemaService;
import com.moke.wp.wx_weipiao.service.HallService;
import com.moke.wp.wx_weipiao.service.HallTypeService;
import com.moke.wp.wx_weipiao.service.SeatService;
import net.sf.json.JSONArray;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/admin/hall")
@RequiresPermissions("影厅管理")
public class Admin_HallController {

    @Autowired
    private HallService hallService;
    @Autowired
    private HallTypeService hallTypeService;
    @Autowired
    private CinemaService cinemaService;
    @Autowired
    private SeatService seatService;

    //获取影厅列表
    @GetMapping("/getHalls")
    public Result getHalls(@RequestParam("pageNum") Integer pageNum,
                           @RequestParam("limit") Integer limit,
                           @RequestParam(value = "keyword",required = false) String keyword,
                           @RequestParam(value = "cinemaId",required = false) Integer cinemaId){
        PageBean<AdminHall> adminHallPageBean = hallService.getHalls(pageNum,limit,keyword,cinemaId);
        return new Result(adminHallPageBean);
    }

    //更新影厅
    @PostMapping("/updateHall")
    public Result updateHall(@RequestBody HashMap<String,Integer> map){
        Integer hallId = map.get("hallId");
        Integer cinemaId = map.get("cinemaId");
        Integer hallTypeId = map.get("hallTypeId");
        Hall hall = hallService.getHallById(hallId);
        if(hall==null)
            return new Result(Result.ERROR,"影厅不存在");
        if(hall.getCinemaId()==cinemaId && hall.getHallTypeId()==hallTypeId)
            return new Result(hall);
        hall.setCinemaId(cinemaId);
        hall.setHallTypeId(hallTypeId);
        hallService.updateHall(hall);
        return new Result(hall);
    }

    //添加影厅
    @PostMapping("/addHall")
    public Result addHall(@RequestBody HashMap<String,Integer> map){
        Integer cinemaId = map.get("cinemaId");
        Integer hallTypeId = map.get("halltypeId");
        Hall hall = new Hall();
        hall.setCinemaId(cinemaId);
        hall.setHallTypeId(hallTypeId);
        hallService.insertHall(hall);
        return new Result(hall);
    }

    //删除影厅
    @PostMapping("/deleteHall")
    public Result deleteHall(@RequestBody HashMap<String,Integer> map){
        Integer hallId = map.get("hallId");
        hallService.deleteHall(hallId);
        return new Result(hallId);
    }
    //获取影院列表
    @GetMapping("/getOptions")
    public Result getCinema(){
        List<HallType> res1 = hallTypeService.getHallTypes();
        List<Cinema> res2 = cinemaService.getAllCinema();
        AdminOptions adminOptions = new AdminOptions();
        adminOptions.setHallTypes(res1);
        adminOptions.setCinemas(res2);
        return new Result(adminOptions);
    }

    //获取影厅座位
    @GetMapping("/getSeatByHallId")
    public Result getSeatByHallId(@RequestParam("hallId") Integer hallId){
        List<Seat> seats = seatService.getSeats(hallId);
        return new Result(seats);
    }

    //修改座位信息
    @PostMapping("/commitSeat")
    public Result commitSeat(@RequestBody HashMap<String,String> map){
        Integer hallId = Integer.parseInt(map.get("hallId"));
        String newSeat = map.get("newSeat");
        String changeSeat = map.get("changeSeat");
        List<Seat> newSeatList = JSONObject.parseArray(newSeat, Seat.class);
        List<Seat> changeSeatList = JSONObject.parseArray(changeSeat, Seat.class);
        seatService.commitSeat(hallId,newSeatList,changeSeatList);
        return new Result(true);
    }

}
