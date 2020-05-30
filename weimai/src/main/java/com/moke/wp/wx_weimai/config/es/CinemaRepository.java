package com.moke.wp.wx_weimai.config.es;

import com.moke.wp.wx_weimai.entity.Cinema;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

public interface CinemaRepository extends ElasticsearchRepository<Cinema,Integer> {


}
