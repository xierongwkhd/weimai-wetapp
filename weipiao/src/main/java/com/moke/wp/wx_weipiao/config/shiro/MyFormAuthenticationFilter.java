package com.moke.wp.wx_weipiao.config.shiro;

import com.alibaba.fastjson.JSONObject;
import com.moke.wp.wx_weipiao.config.util.Result;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;


public class MyFormAuthenticationFilter extends FormAuthenticationFilter {

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        httpServletResponse.setStatus(200);
        httpServletResponse.setContentType("application/json;charset=utf-8");

        PrintWriter out = httpServletResponse.getWriter();
        out.println(JSONObject.toJSON(new Result(Result.NOAUTHC,"未登录")));
        out.flush();
        out.close();
        return false;
    }
}
