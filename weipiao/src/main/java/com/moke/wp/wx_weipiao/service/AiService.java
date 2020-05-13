package com.moke.wp.wx_weipiao.service;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.config.util.Constant;
import com.moke.wp.wx_weipiao.config.util.HttpClientUtil;
import com.moke.wp.wx_weipiao.config.util.MessageUtils;
import com.moke.wp.wx_weipiao.entity.Vo.TextRespMessage;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author: Yun
 * @Description:
 * @Date: Created in 2017-11-29 14:24
 */
@Service
public class AiService {

    public String process(HashMap<String, Object> map){
        // xml格式的消息数据
        String respXml = null;
        // 默认返回的文本消息内容
        String respContent = "未知的消息类型！";
        try {
            // 发送方帐号
            String fromUserName = map.get("FromUserName").toString();
            // 开发者微信号
            String toUserName = map.get("ToUserName").toString();
            //时间
            String createTime = map.get("CreateTime").toString();
            // 消息类型
            String msgType = map.get("MsgType").toString();
            // 消息内容
            Object info=map.get("Content");

            // 文本消息
            if (info!=null && msgType.equals(MessageUtils.REQ_MESSAGE_TYPE_TEXT)) {
                // 转人工客服
                if(info.toString().equals("人工客服") || info.toString().contains("转人工")) {
                    Map<String,Object> textMessage = new HashMap<>();
                    textMessage.put("CreateTime",Long.parseLong(createTime));
                    textMessage.put("FromUserName",toUserName);
                    textMessage.put("MsgType","transfer_customer_service");
                    textMessage.put("ToUserName",fromUserName);
                    return JSONObject.toJSONString(textMessage);
                }
                //如果用户发送的是文本消息，则调用图灵机器人的接口，获取回复内容并返回给微信服务器
                //respContent=TlRobotService.getTextResponse(fromUserName,info);
                Map<String,Object> tmp = new HashMap<>();
                tmp.put("perception", new Perception(new InputText(info.toString())));

                tmp.put("userInfo",new UserInfo(Constant.REBOOT_KEY,fromUserName));
                respContent = JSONObject.parseObject(HttpClientUtil.doPostJson(Constant.REBOOT_URL, JSONObject.toJSONString(tmp)))
                        .getJSONArray("results").getJSONObject(0).getJSONObject("values").getString("text");
            }
            // 图片消息
            else if (msgType.equals(MessageUtils.REQ_MESSAGE_TYPE_IMAGE)) {
                respContent = "您发送的是图片消息,小麦还不知道怎么回答嘛。。。";
            }
            // 语音消息
            else if (msgType.equals(MessageUtils.REQ_MESSAGE_TYPE_VOICE)) {
                respContent = "您发送的是语音消息,小麦还不知道怎么回答嘛。。。";
            }
            // 视频消息
            else if (msgType.equals(MessageUtils.REQ_MESSAGE_TYPE_VIDEO)) {
                respContent = "您发送的是视频消息,小麦还不知道怎么回答嘛。。。";
            }
            // 视频消息
            else if (msgType.equals(MessageUtils.REQ_MESSAGE_TYPE_SHORTVIDEO)) {
                respContent = "您发送的是小视频消息,小麦还不知道怎么回答嘛。。。";
            }
            // 地理位置消息
            else if (msgType.equals(MessageUtils.REQ_MESSAGE_TYPE_LOCATION)) {
                respContent = "您发送的是地理位置消息,小麦还不知道怎么回答嘛。。。";
            }
            // 链接消息
            else if (msgType.equals(MessageUtils.REQ_MESSAGE_TYPE_LINK)) {
                respContent = "您发送的是链接消息,小麦还不知道怎么回答嘛。。。";
            }
            // 事件推送
            else if (msgType.equals(MessageUtils.REQ_MESSAGE_TYPE_EVENT)) {
                // 事件类型
                String eventType = map.get("Event").toString();
                // 关注
                if (eventType.equals(MessageUtils.EVENT_TYPE_SUBSCRIBE)) {
                    respContent = "客服机器人小麦为您服务。。。。";
                }
                // 取消关注
                else if (eventType.equals(MessageUtils.EVENT_TYPE_UNSUBSCRIBE)) {
                    // TODO 取消订阅后用户不会再收到公众账号发送的消息，因此不需要回复
                }
                // 扫描带参数二维码
                else if (eventType.equals(MessageUtils.EVENT_TYPE_SCAN)) {
                    // TODO 处理扫描带参数二维码事件
                }
                // 上报地理位置
                else if (eventType.equals(MessageUtils.EVENT_TYPE_LOCATION)) {
                    // TODO 处理上报地理位置事件
                }
                // 自定义菜单
                else if (eventType.equals(MessageUtils.EVENT_TYPE_CLICK)) {
                    // TODO 处理菜单点击事件
                }
            }
            // 发送回复消息
            sendMS(respContent,fromUserName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }
    private void sendMS(String rep,String openid) {
        String ac_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+ Constant.WX_LOGIN_APPID+
                "&secret="+Constant.WX_LOGIN_SECRET;
        String access_token = JSONObject.parseObject(HttpClientUtil.doGet(ac_url)).getString("access_token");
        String cu_url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+access_token;

        JSONObject tmp = new JSONObject();
        tmp.put("touser",openid);
        tmp.put("msgtype","text");
        tmp.put("text",new Text(rep));
        HttpClientUtil.doPostJson(cu_url,tmp.toJSONString());
    }

    class Text{
        String content;

        public Text(String content) {
            this.content = content;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }
    }
    //图灵机器人参数1
    class Perception{
        InputText inputText;

        public Perception(InputText inputText) {
            this.inputText = inputText;
        }

        public InputText getInputText() {
            return inputText;
        }

        public void setInputText(InputText inputText) {
            this.inputText = inputText;
        }
    }
    class InputText{
        String text;

        public InputText(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }
    }
    //图灵机器人参数2
    class UserInfo{
        String apiKey;
        String userId;

        public UserInfo(String apiKey, String userId) {
            this.apiKey = apiKey;
            this.userId = userId;
        }

        public String getApiKey() {
            return apiKey;
        }

        public void setApiKey(String apiKey) {
            this.apiKey = apiKey;
        }

        public String getUserId() {
            return userId;
        }

        public void setUserId(String userId) {
            this.userId = userId;
        }
    }
}
