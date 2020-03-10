package com.moke.wp.wx_weipiao.config.shiro;

import com.alibaba.druid.util.StringUtils;
import org.apache.shiro.web.servlet.ShiroHttpServletRequest;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.Serializable;

public class MiniSessionManager extends DefaultWebSessionManager {
    public final static  String token_name="token";

    public final static  String session_id_Source="request_header";

    @Override
    protected Serializable getSessionId(ServletRequest request, ServletResponse response) {
        String token = WebUtils.toHttp(request).getHeader(token_name); //这个修改就是从请求头里来获取
        if(StringUtils.isEmpty(token)){
            //如果没有携带token参数则按照父类的方式在cookie进行获取
            return super.getSessionId(request, response);
        }else{
            //如果请求头中有 token 则其值为sessionId
            request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID_SOURCE,session_id_Source); //session_id  来源
            request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID,token);
            request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID_IS_VALID,Boolean.TRUE);
            return token;
        }
    }
}
