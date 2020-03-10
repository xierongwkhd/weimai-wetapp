package com.moke.wp.wx_weipiao.config.shiro;

import org.apache.shiro.authc.pam.AtLeastOneSuccessfulStrategy;
import org.apache.shiro.authc.pam.ModularRealmAuthenticator;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.session.SessionListener;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.apache.shiro.mgt.SecurityManager;
import org.springframework.context.annotation.DependsOn;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.web.servlet.HandlerExceptionResolver;

import javax.servlet.Filter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;

@Configuration
public class ShiroConfig {

    @Bean
    public DefaultWebSecurityManager securityManager(WxRealm wxRealm,AdminRealm adminRealm,
                                                     ModularRealmAuthenticator modularRealmAuthenticator,
                                                     DefaultWebSessionManager sessionManager) {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setSessionManager(sessionManager);
        securityManager.setAuthenticator(modularRealmAuthenticator);
        List<Realm> list = new ArrayList<Realm>();
        list.add(wxRealm);
        list.add(adminRealm);
        securityManager.setRealms(list);
        return securityManager;
    }

    @Bean
    public AdminRealm adminRealm(){
        AdminRealm adminRealm = new AdminRealm();
        //账号密码登录使用realm
        return adminRealm;
    }

    @Bean
    public WxRealm wxCodeRealm(){
        WxRealm wxRealm = new WxRealm();
        //小程序使用openid登录使用的realm
        return wxRealm;
    }
    /**
     * 系统自带的Realm管理，主要针对多realm
     * */
    @Bean
    public ModularRealmAuthenticator modularRealmAuthenticator() {
        MyModularRealmAuthenticator modularRealmAuthenticator = new MyModularRealmAuthenticator();
        //只要有一个成功就视为登录成功
        modularRealmAuthenticator.setAuthenticationStrategy(new AtLeastOneSuccessfulStrategy());
        return modularRealmAuthenticator;
    }

    //开启注解支持
    @Bean
    public DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator(){
        DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
        advisorAutoProxyCreator.setProxyTargetClass(true);
        return advisorAutoProxyCreator;
    }
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager){
        AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
        authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
        return authorizationAttributeSourceAdvisor;
    }

    /**
     * session 管理对象
     *
     * @return DefaultWebSessionManager
     */
    @Bean
    public DefaultWebSessionManager sessionManager() {
        //重写DefaultWebSessionManager    @chenkang
        MiniSessionManager sessionManager = new MiniSessionManager();
        sessionManager.setGlobalSessionTimeout(3600000L);
        return sessionManager;
    }

    @Bean
    public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
        ShiroFilterFactoryBean bean=new ShiroFilterFactoryBean();
        bean.setSecurityManager(securityManager);
        //配置登录的url和登录成功的url以及验证失败的url
        bean.setLoginUrl("/user/login");
        //自定义过滤器
        LinkedHashMap<String, Filter> map = new LinkedHashMap<>();
        map.put("authc", new MyFormAuthenticationFilter());
        bean.setFilters(map);
        //配置访问权限
        LinkedHashMap<String, String> filterChainDefinitionMap=new LinkedHashMap<>();
        filterChainDefinitionMap.put("/user/isAuth","authc");
        filterChainDefinitionMap.put("/user/wxLogin", "anon");
        filterChainDefinitionMap.put("/admin/*","authc");
        filterChainDefinitionMap.put("/admin/user/login","anon");

        filterChainDefinitionMap.put("/home/updateWish","authc");
        filterChainDefinitionMap.put("/home/getIsWish","authc");
        filterChainDefinitionMap.put("/Comment/getIsComment","authc");
        filterChainDefinitionMap.put("/Comment/addComment","authc");
        filterChainDefinitionMap.put("/Comment/upApprove","authc");
        filterChainDefinitionMap.put("/order/*","authc");

        bean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return bean;
    }
}
