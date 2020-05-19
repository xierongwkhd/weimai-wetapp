package com.moke.wp.wx_weimai.config.shiro;

import com.moke.wp.wx_weimai.entity.User;
import com.moke.wp.wx_weimai.mapper.UserMapper;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;

class WxRealm extends AuthenticatingRealm {
    @Autowired
    private UserMapper userMapper;

    /**
     * 鉴权   openid 判断是否用户是否已经绑定微信
     * @param token
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        WxToken wxToken = (WxToken) token;
        String open_id = wxToken.getOpenId();
        //sysUserDao.getbyWxaOpenId 根据openid查询是否有已绑定的userid,有就时已绑定
        User user = userMapper.selectByOpenId(open_id);
        if (user != null) {
            user.setLastLogin(new Date());
            userMapper.updateById(user);
        } else {
            user = wxToken.getUser();
            userMapper.insertUser(user);
        }
        AuthenticationInfo authcInfo = new SimpleAuthenticationInfo(user, "ok", this.getClass().getSimpleName());
        return authcInfo;
    }

    @Override
    public boolean supports(AuthenticationToken authenticationToken) {
        //设置此Realm支持的Token
        return authenticationToken != null && (authenticationToken instanceof WxToken );
    }
}
