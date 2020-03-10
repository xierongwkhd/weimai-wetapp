package com.moke.wp.wx_weipiao.service;

import com.moke.wp.wx_weipiao.entity.HallType;
import com.moke.wp.wx_weipiao.mapper.HallTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HallTypeService {
    @Autowired
    private HallTypeMapper hallTypeMapper;

    public List<HallType> getHallTypes() {
        return hallTypeMapper.getAll();
    }
}
