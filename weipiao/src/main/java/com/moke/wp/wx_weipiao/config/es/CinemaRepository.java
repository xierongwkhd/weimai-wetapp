package com.moke.wp.wx_weipiao.config.es;

import com.moke.wp.wx_weipiao.entity.Cinema;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface CinemaRepository extends ElasticsearchRepository<Cinema,Integer> {


}
