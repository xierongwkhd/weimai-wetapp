package com.moke.wp.wx_weipiao.config.map;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.config.exception.QQMapException;
import com.moke.wp.wx_weipiao.config.util.Constant;
import com.moke.wp.wx_weipiao.config.util.HttpClientUtil;
import com.moke.wp.wx_weipiao.entity.Cinema;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

public class QQMapUtil {

    public static Cinema addrToLocat(Cinema cinema){
        Map<String,String> map = new HashMap<>();
        map.put("key", Constant.QQ_MAP_KEY);
        map.put("address",cinema.getAddr());
        JSONObject object = JSONObject.parseObject(HttpClientUtil.doGet(Constant.QQ_MAP_TO,map));
        try {
            if(!object.getString("status").equals("0"))
                throw new QQMapException("QQ_MAP错误");
        } catch (QQMapException e) {
            e.printStackTrace();
        }
        JSONObject result = object.getJSONObject("result");


        String[] res = new String[3];
        JSONObject tmp = result.getJSONObject("address_components");
        res[0] = "";
        if(!cinema.getAddr().contains(tmp.getString("province")))
            res[0] += tmp.getString("province");
        if(!cinema.getAddr().contains(tmp.getString("city")))
            res[0] += tmp.getString("city");
        res[0] += cinema.getAddr();
        res[1] = result.getJSONObject("location").getString("lat");
        res[2] = result.getJSONObject("location").getString("lng");
        cinema.setAddr(res[0]);
        cinema.setLatitude(new BigDecimal(res[1]));
        cinema.setLongitude(new BigDecimal(res[2]));
        return cinema;
    }
}
