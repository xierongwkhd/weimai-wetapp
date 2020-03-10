package com.moke.wp.wx_weipiao.config.shiro;

import com.moke.wp.wx_weipiao.config.exception.QQMapException;
import com.moke.wp.wx_weipiao.config.util.Result;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class ExceptionHandle {
    @ResponseBody
    @ExceptionHandler(UnauthorizedException.class)
    public Result handleShiroException(Exception ex) {
        return new Result(Result.ERROR,"无权限");
    }

    @ResponseBody
    @ExceptionHandler(AuthorizationException.class)
    public Result AuthorizationException(Exception ex) {
        return new Result(Result.ERROR,"权限认证失败");
    }
    @ResponseBody
    @ExceptionHandler(QQMapException.class)
    public Result QQMapException(Exception ex) {
        return new Result(Result.ERROR,"腾讯地图异常");
    }

}
