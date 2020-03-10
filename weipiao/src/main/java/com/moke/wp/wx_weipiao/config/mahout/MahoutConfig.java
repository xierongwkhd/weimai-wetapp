package com.moke.wp.wx_weipiao.config.mahout;

import org.apache.mahout.cf.taste.impl.model.jdbc.MySQLJDBCDataModel;
import org.apache.mahout.cf.taste.model.DataModel;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.annotation.Resource;
import javax.sql.DataSource;

@Configuration
public class MahoutConfig {
//    private DruidDataSource getDataSource(){
//        DruidDataSource dataSource=new DruidDataSource();
//        dataSource.setConnectProperties();
//        dataSource.setServerName("192.168.1.7");
//        dataSource.setUser("xhsit");
//        dataSource.setPassword("sit1818");
//        dataSource.setDatabaseName("mahout");
//        return dataSource;
//    }
    @Resource
    DataSource dataSource;

    @Bean
    public DataModel getMySQLJDBCDataModel(){
        DataModel dataModel=new MySQLJDBCDataModel(dataSource,"t_comment","user_id","movie_id","sc", "calc_time");
        return dataModel;
    }

}
