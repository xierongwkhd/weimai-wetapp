package com.moke.wp.wx_weimai.controller;

import com.moke.wp.wx_weimai.config.util.SignUtil;
import com.moke.wp.wx_weimai.service.AiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
public class AiController {

    @Autowired
    private AiService aiService;

    @GetMapping("/ai")
    public String doGet(String signature,String timestamp,String nonce,String echostr){
        if(SignUtil.checkSignature(signature,timestamp,nonce)){
            return echostr;
        }
        return null;
    }

    @PostMapping("/ai")
    public String doPost(@RequestBody HashMap<String,Object> map){
        /*
            在收到微信服务器的请求之后，我们需要做如下几件事！
            1、解析微信发送的请求数据
            2、发送请求给图灵的接口，获取返回值，并解析提取回复内容
            3、将回复内容和第一步解析到的消息发送人封装成JSON格式，再返回给微信服务器
         */
        return aiService.process(map);
    }
}
