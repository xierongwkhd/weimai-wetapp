package com.moke.wp.wx_weimai.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.moke.wp.wx_weimai.entity.Comment;
import com.moke.wp.wx_weimai.mapper.CommentMapper;
import com.moke.wp.wx_weimai.config.util.PageBean;
import com.moke.wp.wx_weimai.entity.CommentApprove;
import com.moke.wp.wx_weimai.entity.Vo.AdminComment;
import com.moke.wp.wx_weimai.entity.Vo.CommentVo;
import com.moke.wp.wx_weimai.entity.Movie;
import com.moke.wp.wx_weimai.entity.User;
import com.moke.wp.wx_weimai.mapper.CommentApproveMapper;
import com.moke.wp.wx_weimai.mapper.MovieMapper;
import com.moke.wp.wx_weimai.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommentSerice {
    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private MovieMapper movieMapper;
    @Autowired
    private CommentApproveMapper commentApproveMapper;

    public PageBean<CommentVo> getComment(Integer movieId,Integer pageNum,Integer limit,User user1) {
        PageHelper.startPage(pageNum,limit);
        List<Comment> list = commentMapper.getComment(movieId);
        PageInfo pageInfo = new PageInfo(list);
        PageBean<CommentVo> page = new PageBean<CommentVo>();
        page.setPc(pageInfo.getPageNum());
        page.setPs(pageInfo.getSize());
        page.setTr(pageInfo.getPages());
        List<CommentVo> commentVos = new ArrayList<CommentVo>();
        for(Comment comment : list){
            User user = userMapper.selectById(comment.getUserId());
            CommentVo commentVo = new CommentVo(comment);
            commentVo.setUserNickname(user.getNickName());
            commentVo.setUserAvatarUrl(user.getAvatarUrl());
            commentVo.setSorce(commentVo.getSc().doubleValue());
            if(user1!=null)
                commentVo.setHasApprove(commentApproveMapper.getByTwoId(comment.getId(),user1.getId())!=null);
            commentVos.add(commentVo);
        }
        page.setBeanList(commentVos);
        return page;
    }

    public List<CommentVo> getHotComment(Integer movieId, User user1) {
        List<Comment> commentList = commentMapper.getHotComment(movieId);
        List<CommentVo> commentVos = new ArrayList<CommentVo>();
        for(Comment comment : commentList){
            User user = userMapper.selectById(comment.getUserId());
            CommentVo commentVo = new CommentVo(comment);
            commentVo.setUserNickname(user.getNickName());
            commentVo.setUserAvatarUrl(user.getAvatarUrl());
            commentVo.setSorce(commentVo.getSc().doubleValue());
            if(user1!=null)
                commentVo.setHasApprove(commentApproveMapper.getByTwoId(comment.getId(),user1.getId())!=null);
            commentVos.add(commentVo);
        }
        return commentVos;
    }

    @Transactional
    public void addComment(Integer userId, Integer movieId, Integer sc, String content) {
        commentMapper.addComment(userId,movieId,sc,content);
        Movie movie = movieMapper.getMovieById(movieId);
        movie.setSc((movie.getSnum()*movie.getSc()+sc)/(movie.getSnum()+1));
        movie.setSnum(movie.getSnum()+1);
        movieMapper.updateById(movie);
    }

    public Comment getIsComment(Integer userId, Integer movieId) {
        return commentMapper.getIsComment(userId,movieId);
    }

    public void updateComment(Integer userId, Integer movieId, Integer sc, String content) {
        commentMapper.updateComment(userId,movieId,sc,content);
    }

    public PageBean<AdminComment> getComments(Integer pageNum, Integer limit, String keyword) {
        PageHelper.startPage(pageNum,limit);
        List<Comment> list = commentMapper.getComments(keyword);
        PageInfo pageInfo = new PageInfo(list);
        PageBean<AdminComment> page = new PageBean<AdminComment>();
        page.setPc(pageInfo.getPageNum());
        page.setPs(pageInfo.getSize());
        page.setTr(pageInfo.getPages());
        List<AdminComment> adminComments = new ArrayList<AdminComment>();
        for(Comment comment : list){
            AdminComment adminComment = new AdminComment(comment);
            adminComment.setUserName(userMapper.selectById(comment.getUserId()).getNickName());
            adminComment.setMovieName(movieMapper.getMovieById(comment.getMovieId()).getNm());
            adminComments.add(adminComment);
        }
        page.setBeanList(adminComments);
        return page;
    }

    public void deleteById(Integer commentId) {
        commentMapper.deleteById(commentId);
    }

    public void upApprove(Integer commentId, Integer userId) {
        CommentApprove approve = commentApproveMapper.getByTwoId(commentId,userId);
        if(approve==null){
            CommentApprove commentApprove = new CommentApprove();
            commentApprove.setCommentId(commentId);
            commentApprove.setUserId(userId);
            commentApproveMapper.insert(commentApprove);
            commentMapper.upApproveById(commentId,1);
        }else{
            commentApproveMapper.deleteByTwoId(commentId,userId);
            commentMapper.upApproveById(commentId,-1);
        }
    }
}
