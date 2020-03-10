package com.moke.wp.wx_weipiao;

import com.moke.wp.wx_weipiao.config.util.FileProperties;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@MapperScan("com.moke.wp.wx_weipiao.mapper")
@EnableScheduling
@EnableConfigurationProperties({
        FileProperties.class
})
public class WxWeipiaoApplication {

    public static void main(String[] args){
        System.setProperty("es.set.netty.runtime.available.processors","false");
        SpringApplication.run(WxWeipiaoApplication.class, args);
    }

}
