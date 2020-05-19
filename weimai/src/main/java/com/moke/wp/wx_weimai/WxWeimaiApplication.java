package com.moke.wp.wx_weimai;

import com.moke.wp.wx_weimai.config.util.FileProperties;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@MapperScan("com.moke.wp.wx_weimai.mapper")
@EnableScheduling
@EnableConfigurationProperties({
        FileProperties.class
})
public class WxWeimaiApplication {

    public static void main(String[] args){
        System.setProperty("es.set.netty.runtime.available.processors","false");
        SpringApplication.run(WxWeimaiApplication.class, args);
    }

}
