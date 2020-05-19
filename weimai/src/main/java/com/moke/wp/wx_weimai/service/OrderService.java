package com.moke.wp.wx_weimai.service;

import com.alibaba.fastjson.JSONArray;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.moke.wp.wx_weimai.entity.*;
import com.moke.wp.wx_weimai.mapper.*;
import com.moke.wp.wx_weimai.config.util.PageBean;
import com.moke.wp.wx_weimai.entity.Vo.OrderItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private SeatMapper seatMapper;
    @Autowired
    private MovieMapper movieMapper;
    @Autowired
    private TimesMapper timesMapper;
    @Autowired
    private CinemaMapper cinemaMapper;
    @Autowired
    private SnackMapper snackMapper;
    @Autowired
    private UserMapper userMapper;

    @Transactional
    public OrderItem addOrder(Order order, String seat) {
        OrderItem orderItem = new OrderItem();
        if(seat.indexOf("排") != -1) {
            JSONArray array = JSONArray.parseArray(seat);
            List<Seat> seatList = array.toJavaList(Seat.class);
            StringBuffer stringBuffer = new StringBuffer();
            int i = 0;
            for (Seat s : seatList) {
                stringBuffer.append(s.getyCoord() + "排" + s.getxCoord() + "座,");
                i++;
            }
            Movie movie = movieMapper.getMovieById(order.getItemId());
            orderItem.setMovieName(movie.getNm());
            orderItem.setMovieImg(movie.getImg());
            movie.setWatched(movie.getWatched()+i);
            movieMapper.updateById(movie);
            orderItem.setOrderId(order.getOrderId());
            orderItem.setOrderPrice(order.getPrice().doubleValue());
            Cinema cinema = timesMapper.getCiemaId(order.getRelateId());
            orderItem.setCinemaId(cinema.getId());
            orderItem.setCinemaName(cinema.getNm());
            orderItem.setSeats(stringBuffer.toString());
            Times times = timesMapper.selectById(order.getRelateId());
            orderItem.setHallId(times.getHallId());
            orderItem.setTime(times.getStartTime());
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
            order.setDescribe(stringBuffer.append(simpleDateFormat.format(times.getStartTime())).toString());
        }else{
            order.setDescribe(seat);
            Cinema cinema = cinemaMapper.selectById(order.getRelateId());
            orderItem.setCinemaId(cinema.getId());
            orderItem.setCinemaName(cinema.getNm());
            Snack snack = snackMapper.selectById(order.getItemId());
            orderItem.setMovieImg(snack.getImageUrl());
            orderItem.setMovieName(snack.getFirstTitle());
            snack.setCurNumber(snack.getCurNumber()+Integer.parseInt(order.getDescribe()));
            snack.setTotalNumber(snack.getTotalNumber()-Integer.parseInt(order.getDescribe()));
            snackMapper.updateById(snack);
            orderItem.setOrderPrice(order.getPrice().doubleValue());
            orderItem.setSeats(order.getDescribe());
        }
        orderItem.setStatus("支付完成");
        orderMapper.insert(order);
        return orderItem;
    }

    public List<OrderItem> getMovieOrderByUser(Integer userId) {
        List<Order> orderList = orderMapper.getMovieOrderByUser(userId);
        List<OrderItem> orderItems = new ArrayList<>();
        for(Order order : orderList){
            OrderItem orderItem = new OrderItem();
            Movie movie = movieMapper.getMovieById(order.getItemId());
            orderItem.setMovieName(movie.getNm());
            orderItem.setMovieImg(movie.getImg());
            orderItem.setOrderId(order.getOrderId());
            orderItem.setStatus("支付完成");
            orderItem.setOrderPrice(order.getPrice().doubleValue());
            Cinema cinema = timesMapper.getCiemaId(order.getRelateId());
            orderItem.setCinemaId(cinema.getId());
            orderItem.setCinemaName(cinema.getNm());
            orderItem.setSeats(order.getDescribe().substring(0,order.getDescribe().lastIndexOf(",")));
            Times times = timesMapper.selectById(order.getRelateId());
            orderItem.setHallId(times.getHallId());
            orderItem.setTime(times.getStartTime());
            orderItems.add(orderItem);
        }
        return orderItems;
    }

    public List<OrderItem> getSnackOrderByUser(Integer userId) {
        List<Order> orderList = orderMapper.getSnackOrderByUser(userId);
        List<OrderItem> orderItems = new ArrayList<>();
        for(Order order : orderList){
            OrderItem orderItem = new OrderItem();
            Cinema cinema = cinemaMapper.selectById(order.getRelateId());
            orderItem.setCinemaId(cinema.getId());
            orderItem.setCinemaName(cinema.getNm());
            Snack snack = snackMapper.selectById(order.getItemId());
            orderItem.setMovieImg(snack.getImageUrl());
            orderItem.setMovieName(snack.getFirstTitle());
            orderItem.setOrderPrice(order.getPrice().doubleValue());
            orderItem.setSeats(order.getDescribe());
            orderItems.add(orderItem);
        }
        return orderItems;
    }

    public PageBean<Order> getOrders(Integer pageNum, Integer limit, String keyword, Integer cinemaId) {
        PageHelper.startPage(pageNum,limit);
        List<Order> orderList = orderMapper.getOrders(keyword,cinemaId);
        PageBean<Order> page = new PageBean<Order>();
        PageInfo pageInfo = new PageInfo(orderList);
        page.setPc(pageInfo.getPageNum());
        page.setTr(pageInfo.getPages());
        page.setPs(pageInfo.getPageSize());
        for(Order order:orderList){
            order.setUserNick(userMapper.selectById(order.getOrderUid()).getNickName());
        }
        page.setBeanList(orderList);
        return page;
    }

    public void deleteOrderById(Integer orderId) {
        orderMapper.deleteById(orderId);
    }
}
