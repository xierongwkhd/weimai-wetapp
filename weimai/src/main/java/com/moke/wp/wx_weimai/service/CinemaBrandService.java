package com.moke.wp.wx_weimai.service;

import com.moke.wp.wx_weimai.entity.CinemaBrand;
import com.moke.wp.wx_weimai.mapper.CinemaBrandMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CinemaBrandService {

    @Autowired
    private CinemaBrandMapper cinemaBrandMapper;


    public List<CinemaBrand> getBrandList() {
        return cinemaBrandMapper.getAll();
    }

    public Integer insert(String newBrand) {
        CinemaBrand cinemaBrand = new CinemaBrand();
        cinemaBrand.setBrand(newBrand);
        cinemaBrandMapper.insert(cinemaBrand);
        return cinemaBrand.getId();
    }
}
