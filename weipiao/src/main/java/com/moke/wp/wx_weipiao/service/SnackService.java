package com.moke.wp.wx_weipiao.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.moke.wp.wx_weipiao.config.util.PageBean;
import com.moke.wp.wx_weipiao.entity.Snack;
import com.moke.wp.wx_weipiao.entity.User;
import com.moke.wp.wx_weipiao.mapper.CinemaMapper;
import com.moke.wp.wx_weipiao.mapper.SnackMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SnackService {

    @Autowired
    private SnackMapper snackMapper;
    @Autowired
    private CinemaMapper cinemaMapper;

    public List<Snack> getSnacks(Integer cinemaId) {
        return snackMapper.selectByCinemaId(cinemaId);
    }

    public PageBean<Snack> getSnack(Integer pageNum, Integer limit, String keyword, Integer cinemaId) {
        PageHelper.startPage(pageNum,limit);
        List<Snack> snackList = snackMapper.getSnack(keyword,cinemaId);
        PageBean<Snack> page = new PageBean<>();
        PageInfo pageInfo = new PageInfo(snackList);
        page.setPc(pageInfo.getPageNum());
        page.setTr(pageInfo.getPages());
        page.setPs(pageInfo.getPageSize());
        for(Snack snack : snackList){
            snack.setCinemaNm(cinemaMapper.selectById(snack.getCinemaId()).getNm());
        }
        page.setBeanList(snackList);
        return page;
    }

    public void update(Snack snack1) {
        snackMapper.updateById(snack1);
    }

    public Snack getSnackByName(String firstTitle) {
        return snackMapper.getSnackByName(firstTitle);
    }

    public void insertSnack(Snack snack1) {
        snackMapper.insert(snack1);
    }

    public void deleteSnack(Integer snackId) {
        snackMapper.deleteById(snackId);
    }
}
