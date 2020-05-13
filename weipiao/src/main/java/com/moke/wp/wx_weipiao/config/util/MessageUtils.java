package com.moke.wp.wx_weipiao.config.util;
/**
 * 封装微信消息类型，有一个解析微信发过的xml消息的工具
 */



import org.springframework.stereotype.Component;



/**
 * <p>Company: B505信息技术研究所 </p>
 * @Description: 封装微信消息类型，有一个解析xml格式的工具
 * @Create Date: 2017年10月11日上午11:28:48
 * @Version: V1.00
 * @Author: 来日可期
 */
@Component
public class MessageUtils {

    /**
     * 请求消息类型：文本
     */
    public final static String REQ_MESSAGE_TYPE_TEXT = "text";

    /**
     * 请求消息类型：图片
     */
    public final static String REQ_MESSAGE_TYPE_IMAGE="image";

    /**
     * 请求消息类型：语音
     */
    public final static String REQ_MESSAGE_TYPE_VOICE="voice";

    /**
     * 请求消息类型：视频
     */
    public final static String REQ_MESSAGE_TYPE_VIDEO="video";

    /**
     * 请求消息类型：链接
     */
    public final static String REQ_MESSAGE_TYPE_LINK = "link";

    /**
     * 请求消息类型：地理位置
     */
    public  final static String REQ_MESSAGE_TYPE_LOCATION="location";

    /**
     * 请求消息类型：小视频
     */
    public final static String REQ_MESSAGE_TYPE_SHORTVIDEO="shortvideo";

    /**
     *请求消息类型：事件推送
     */
    public final static String REQ_MESSAGE_TYPE_EVENT = "event";

    /**
     * 返回消息类型：文本
     */
    public final static String RESP_MESSAGE_TYPE_TEXT = "text";

    /**
     * 消息返回类型：图片
     */
    public final static String RESP_MESSAGE_TYPE_IMAGE="image";

    /**
     * 消息返回类型:语音
     */
    public final static String RESP_MESSAGE_TYPE_VOICE = "voice";

    /**
     * 消息返回类型：音乐
     */
    public final static String RESP_MESSAGE_TYPE_MUSIC = "music";

    /**
     * 消息返回类型：图文
     */
    public final  static String RESP_MESSAGE_TYPE_NEWS = "news";

    /**
     * 消息返回类型：视频
     */
    public final static String RESP_MESSAGE_TYPE_VIDEO="video";

    /**
     * 事件类型:订阅
     */
    public final static String EVENT_TYPE_SUBSCRIBE = "user_enter_tempsession";

    /**
     * 事件类型：取消订阅
     */
    public final static String EVENT_TYPE_UNSUBSCRIBE = "unsubscribe";

    /**
     * 事件类型：scan(关注用户扫描带参二维码)
     */
    public final static String EVENT_TYPE_SCAN = "scan";

    /**
     * 事件类型：location(上报地理位置)
     */
    public final static String EVENT_TYPE_LOCATION = "location";

    /**
     * 事件类型：CLICK(点击菜单拉取消息)
     */
    public final static String EVENT_TYPE_CLICK ="CLICK";

    /**
     * 事件类型：VIEW(自定义菜单URl视图)
     */
    public final static String EVENT_TYPE_VIEW ="VIEW";

    /**
     * 事件类型：TEMPLATESENDJOBFINISH(模板消息送达情况提醒)
     */
    public final static String EVENT_TYPE_TEMPLATESENDJOBFINISH="TEMPLATESENDJOBFINISH";


}
