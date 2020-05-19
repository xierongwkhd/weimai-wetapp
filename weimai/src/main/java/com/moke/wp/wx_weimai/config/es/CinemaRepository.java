package com.moke.wp.wx_weimai.config.es;

import com.moke.wp.wx_weimai.entity.Cinema;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface CinemaRepository extends ElasticsearchRepository<Cinema,Integer> {


}
