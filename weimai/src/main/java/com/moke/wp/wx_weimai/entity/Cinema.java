package com.moke.wp.wx_weimai.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import org.springframework.data.elasticsearch.annotations.*;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;

import java.io.Serializable;
import java.math.BigDecimal;

@Document(indexName = "cinema",type = "cinema",replicas = 0)
@TableName("t_cinema")
public class Cinema extends Model<Cinema> {
    private Integer id;

    @Field(type = FieldType.Text, searchAnalyzer = "ik_max_word", analyzer = "ik_smart")
    private String nm;

    private Integer brandId;

    @Field(type = FieldType.Text, searchAnalyzer = "ik_max_word", analyzer = "ik_smart")
    private String addr;

    private BigDecimal latitude;

    private BigDecimal longitude;

    private Boolean endorse;

    private Boolean allowrefund;

    @GeoPointField
    @TableField(exist = false)
    private GeoPoint location;

    @TableField(exist = false)
    private BigDecimal distance;

    public GeoPoint getLocation() {
        return location;
    }

    public void setLocation(GeoPoint location) {
        this.location = location;
    }

    public BigDecimal getDistance() {
        return distance;
    }

    public void setDistance(BigDecimal distance) {
        this.distance = distance;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNm() {
        return nm;
    }

    public void setNm(String nm) {
        this.nm = nm == null ? null : nm.trim();
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr == null ? null : addr.trim();
    }

    public BigDecimal getLatitude() {
        return latitude;
    }

    public void setLatitude(BigDecimal latitude) {
        this.latitude = latitude;
    }

    public BigDecimal getLongitude() {
        return longitude;
    }

    public void setLongitude(BigDecimal longitude) {
        this.longitude = longitude;
    }

    public Boolean getEndorse() {
        return endorse;
    }

    public void setEndorse(Boolean endorse) {
        this.endorse = endorse;
    }

    public Boolean getAllowrefund() {
        return allowrefund;
    }

    public void setAllowrefund(Boolean allowrefund) {
        this.allowrefund = allowrefund;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }
}