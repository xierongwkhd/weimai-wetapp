package com.moke.wp.wx_weimai.controller;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weimai.entity.Comment;
import com.moke.wp.wx_weimai.entity.User;
import com.moke.wp.wx_weimai.entity.Vo.CommentMess;
import com.moke.wp.wx_weimai.config.util.PageBean;
import com.moke.wp.wx_weimai.config.util.Result;
import com.moke.wp.wx_weimai.entity.Vo.CommentVo;
import com.moke.wp.wx_weimai.service.CommentSerice;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/Comment")
public class CommentController {
    private final static Logger logger = LoggerFactory.getLogger(CommentController.class);

    @Autowired
    private CommentSerice commentSerice;

    //评论点赞
    @PostMapping("/upApprove")
    public Result upApprove(@RequestParam("commentId") Integer commentId){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated())
            return new Result(Result.NOAUTHC,"未登录");
        User user = (User)subject.getPrincipal();
        commentSerice.upApprove(commentId,user.getId());
        return new Result(Result.SUCCESS,"成功");
    }

    //电影最新评论列表
    @GetMapping("/getComment/{movieId}")
    public Result getComment(@PathVariable("movieId") Integer movieId,
                             @RequestParam("pageNum") Integer pageNum,
                             @RequestParam("limit") Integer limit){
        Subject subject = SecurityUtils.getSubject();
        User user = (User)subject.getPrincipal();
        PageBean<CommentVo> page = commentSerice.getComment(movieId,pageNum,limit,user);
        return new Result(JSONObject.toJSON(page));
    }

    //电影热门评论评论列表
    @GetMapping("/getHotComment/{movieId}")
    public Result getHotComment(@PathVariable("movieId") Integer movieId){
        Subject subject = SecurityUtils.getSubject();
        User user = (User)subject.getPrincipal();
        List<CommentVo> commentVos = commentSerice.getHotComment(movieId,user);
        if(commentVos==null || commentVos.size()==0)
            return new Result(Result.ERROR,"无评论");
        CommentMess commentMess = new CommentMess();
        commentMess.setComList(commentVos.subList(0,commentVos.size()>4? 4:commentVos.size()));
        commentMess.setTotal(commentVos.size());
        return new Result(commentMess);
    }

    //用户写评论
    @PostMapping("/addComment")
    public Result addComment(@RequestParam("movieId") Integer movieId,
                             @RequestParam("sc") Integer sc,
                             @RequestParam("content") String content){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated())
            return new Result(Result.NOAUTHC,"未登录");
        User user = (User)subject.getPrincipal();
        Comment comment = commentSerice.getIsComment(user.getId(),movieId);
        if(comment!=null){
            commentSerice.updateComment(user.getId(),movieId,sc,content);
        }
        commentSerice.addComment(user.getId(),movieId,sc,content);
        return new Result(Result.SUCCESS,"添加成功");
    }

    //判断是否评论过
    @ResponseBody
    @GetMapping("/getIsComment")
    public Result getIsComment(@RequestParam("movieId") Integer movieId){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated())
            return new Result(Result.NOAUTHC,"未登录");
        User user = (User)subject.getPrincipal();
        Comment comment = commentSerice.getIsComment(user.getId(),movieId);
        return new Result(comment);
    }
}
