package com.moke.wp.wx_weipiao.config.es;

import com.moke.wp.wx_weipiao.config.redis.RedisConfig;
import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;

@Configuration
@AutoConfigureBefore(RedisConfig.class)
public class ElasticConfig {
    @PostConstruct
    void init() {
        System.setProperty("es.set.netty.runtime.available.processors", "false");
    }
}
