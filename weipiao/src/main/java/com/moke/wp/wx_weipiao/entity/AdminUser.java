package com.moke.wp.wx_weipiao.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

@TableName("t_admin_user")
public class AdminUser extends Model<AdminUser> {
    private Integer id;

    private String avatar;

    private String name;

    private String username;

    private String password;

    private Integer cineamId;

    @TableField(exist = false)
    private String cinemaNm;

    @TableField(exist = false)
    private Integer roleId;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getCinemaNm() {
        return cinemaNm;
    }

    public void setCinemaNm(String cinemaNm) {
        this.cinemaNm = cinemaNm;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar == null ? null : avatar.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Integer getCineamId() {
        return cineamId;
    }

    public void setCineamId(Integer cineamId) {
        this.cineamId = cineamId;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }
}