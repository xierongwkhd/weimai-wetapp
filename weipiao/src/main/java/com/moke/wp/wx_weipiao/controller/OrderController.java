package com.moke.wp.wx_weipiao.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.config.util.Result;
import com.moke.wp.wx_weipiao.entity.Order;
import com.moke.wp.wx_weipiao.entity.Seat;
import com.moke.wp.wx_weipiao.entity.User;
import com.moke.wp.wx_weipiao.entity.Vo.OrderItem;
import com.moke.wp.wx_weipiao.service.OrderService;
import com.moke.wp.wx_weipiao.service.SeatService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private SeatService seatService;

    @PostMapping("/addOrder")
    public Result addOrder(@RequestParam("itemId") Integer itemId,
                           @RequestParam("itemType") String itemType,
                           @RequestParam("relateId") Integer relateId,
                           @RequestParam("orderId") String orderId,
                           @RequestParam("price") Double price,
                           @RequestParam("seat") String seat){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated())
            return new Result(Result.NOAUTHC,"未登录");
        User user = (User)subject.getPrincipal();
        Order order = new Order();
        order.setItemId(itemId);
        order.setItemType(itemType);
        order.setRelateId(relateId);
        order.setOrderId(orderId);
        order.setPrice(new BigDecimal(price));
        order.setOrderUid(user.getId());
        order.setCreateTime(new Date());
        OrderItem orderItem = orderService.addOrder(order,seat);
        return new Result(orderItem);
    }

    @GetMapping("/getMovieOrder")
    public Result getMovieOrder(){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated())
            return new Result(Result.NOAUTHC,"未登录");
        User user = (User)subject.getPrincipal();
        List<OrderItem> orderList = orderService.getMovieOrderByUser(user.getId());
        return new Result(orderList);
    }

    @GetMapping("/getSnackOrder")
    public Result getSnackOrder(){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated())
            return new Result(Result.NOAUTHC,"未登录");
        User user = (User)subject.getPrincipal();
        List<OrderItem> orderList = orderService.getSnackOrderByUser(user.getId());
        return new Result(orderList);
    }
}
