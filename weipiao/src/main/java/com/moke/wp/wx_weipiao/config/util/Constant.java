package com.moke.wp.wx_weipiao.config.util;

import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public interface Constant {

    /*
    * 微信相关
     */
    // 请求的网址
    public static final String WX_LOGIN_URL = "https://api.weixin.qq.com/sns/jscode2session";
    // 你的appid
    public static final String WX_LOGIN_APPID = "wxb367811c1b81b819";
    // 你的密匙
    public static final String WX_LOGIN_SECRET = "bd42568e3d7337a3328c952f3c01635f";
    // 固定参数
    public static final String WX_LOGIN_GRANT_TYPE = "authorization_code";

    /*
    * 腾讯地图
     */
    //key
    public static  final String  QQ_MAP_KEY = "XXOBZ-PKQWU-26BVI-4RPT3-LV5HQ-OIBQF";
    //计算坐标距离
    public static final String QQ_MAP_DISTANCE = "https://apis.map.qq.com/ws/distance/v1/?parameters";
    //搜索城市id
    public static final String QQ_MAP_SEARCH = "https://apis.map.qq.com/ws/district/v1/search";
    //获取行政划分
    public static final String QQ_MAP_DISTRICT = "https://apis.map.qq.com/ws/district/v1/getchildren";
    //地址转坐标
    public static final String QQ_MAP_TO = "https://apis.map.qq.com/ws/geocoder/v1/";

}
