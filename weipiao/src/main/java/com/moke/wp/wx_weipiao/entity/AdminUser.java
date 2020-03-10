package com.moke.wp.wx_weipiao.entity;

public class AdminUser {
    private Integer id;

    private String avatar;

    private String name;

    private String username;

    private String password;

    private Integer cineamId;

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
}