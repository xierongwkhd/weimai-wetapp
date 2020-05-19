package com.moke.wp.wx_weimai.config.es;

import com.moke.wp.wx_weimai.entity.Movie;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface MovieRepository extends ElasticsearchRepository<Movie,Integer> {

    List<Movie> findByNmLikeOrDirLikeOrCatLikeOrDraLikeOrStarContains(String key1,String key2,String key3,String key4,String key5);
}
