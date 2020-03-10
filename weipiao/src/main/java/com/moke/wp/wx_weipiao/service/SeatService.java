package com.moke.wp.wx_weipiao.service;

import com.moke.wp.wx_weipiao.entity.Order;
import com.moke.wp.wx_weipiao.entity.Seat;
import com.moke.wp.wx_weipiao.entity.Times;
import com.moke.wp.wx_weipiao.mapper.OrderMapper;
import com.moke.wp.wx_weipiao.mapper.SeatMapper;
import com.moke.wp.wx_weipiao.mapper.TimesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.List;

@Service
public class SeatService {
    @Autowired
    private SeatMapper seatMapper;
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private TimesMapper timesMapper;


    public List<Seat> getSeatByHallId(Integer hallId,Integer timesId) {
        List<Seat> seats = seatMapper.getSeatByHallId(hallId);
        Times times = timesMapper.selectById(timesId);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
        String date = simpleDateFormat.format(times.getStartTime());
        List<Order> orders = orderMapper.getByTimesId(timesId,date);
        String tmp = "";
        for(Order order : orders){
            tmp += order.getDescribe();
        }
        for(Seat seat : seats){
            if(tmp.contains(seat.getyCoord() + "排" + seat.getxCoord() + "座"))
                seat.setStatus("booked");
        }
        return  seats;
    }

    public void update(Seat s) {
        seatMapper.updateById(s);
    }

    public List<Seat> getSeats(Integer hallId) {
        return seatMapper.getSeatByHallId(hallId);
    }

    public void commitSeat(Integer hallId, List<Seat> newSeatList, List<Seat> changeSeatList) {
        //改变座位
        List<Seat> seats = seatMapper.getSeatByHallId(hallId);
        Seat[][] seatInfo = new Seat[15][15];
        for(Seat s : seats) {
            seatInfo[s.getyCoord()][s.getxCoord()] = s;
        }
        for(Seat s : changeSeatList){
            Seat tmp = seatInfo[s.getyCoord()][s.getxCoord()];
            if(tmp.getType().equals("danren")){
                if(seatInfo[s.getyCoord()-1][s.getxCoord()]!=null
                        ||seatInfo[s.getyCoord()][s.getxCoord()-1]!=null
                        ||seatInfo[s.getyCoord()+1][s.getxCoord()]!=null
                        ||seatInfo[s.getyCoord()][s.getxCoord()+1]!=null){
                    tmp.setType("road");
                    seatMapper.updateById(tmp);
                }else{
                    seatMapper.deleteById(tmp);
                }
            }else{
                tmp.setType("danren");
                seatMapper.updateById(tmp);
            }
        }
        //新的座位
        for(Seat s : newSeatList){
            int x = s.getxCoord()+1;
            int y = s.getyCoord()+1;
            if(x-2>=0 && seatInfo[y][x-1]==null && seatInfo[y][x-2]!=null){
                Seat seat = new Seat();
                seat.setType("road");
                seat.setHallId(hallId);
                seat.setxCoord(x-1);
                seat.setyCoord(y);
                seat.setStatus("ok");
                seatMapper.insert(seat);
            }
            if(x+2<15 && seatInfo[y][x+1]==null && seatInfo[y][x+2]!=null){
                Seat seat = new Seat();
                seat.setType("road");
                seat.setHallId(hallId);
                seat.setxCoord(x+1);
                seat.setyCoord(y);
                seat.setStatus("ok");
                seatMapper.insert(seat);
            }
            if(y-2>=0 && seatInfo[y-1][x]==null&& seatInfo[y-2][x]!=null){
                Seat seat = new Seat();
                seat.setType("road");
                seat.setHallId(hallId);
                seat.setxCoord(x);
                seat.setyCoord(y-1);
                seat.setStatus("ok");
                seatMapper.insert(seat);
            }
            if(y+2<15 && seatInfo[y+1][x]==null && seatInfo[y+2][x]!=null){
                Seat seat = new Seat();
                seat.setType("road");
                seat.setHallId(hallId);
                seat.setxCoord(x);
                seat.setyCoord(y+1);
                seat.setStatus("ok");
                seatMapper.insert(seat);
            }
            s.setType("danren");
            s.setHallId(hallId);
            s.setStatus("ok");
            s.setxCoord(x);
            s.setyCoord(y);
            seatMapper.insert(s);
            seatInfo[y][x] = s;
        }
    }
}
