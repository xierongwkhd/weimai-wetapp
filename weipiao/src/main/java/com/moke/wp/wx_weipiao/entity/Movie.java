package com.moke.wp.wx_weipiao.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Document(indexName = "movie",type = "movie",replicas = 0)
@TableName("t_movie")
public class Movie extends Model<Movie> {
    private Integer id;

    @Field(type = FieldType.Text, searchAnalyzer = "ik_max_word", analyzer = "ik_smart")
    private String nm;

    private String enm;

    @Field(type = FieldType.Text, searchAnalyzer = "ik_max_word", analyzer = "ik_smart")
    private String cat;

    @Field(type = FieldType.Text, searchAnalyzer = "ik_max_word", analyzer = "ik_smart")
    private String dir;

    private String img;

    private String version;

    @Field(type = FieldType.Text, searchAnalyzer = "ik_max_word", analyzer = "ik_smart")
    private String dra;

    private Double sc;

    private Integer snum;

    @Field(type = FieldType.Text, searchAnalyzer = "ik_max_word", analyzer = "ik_smart")
    private String star;

    private String src;

    private String language;

    private Integer dur;

    private Boolean globalreleased;

    private Long wish;

    private Integer watched;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date rt;

    private Integer showst;

    private String videoImg;

    private String videoName;

    private String videoUrl;

    private String photos;

    @TableField(exist = false)
    private String[] photosList;

    @TableField(exist = false)
    private List<Days> movieDays;

    public String[] getPhotosList() {
        return photosList;
    }

    public void setPhotosList(String[] photosList) {
        this.photosList = photosList;
    }

    public List<Days> getMovieDays() {
        return movieDays;
    }

    public void setMovieDays(List<Days> movieDays) {
        this.movieDays = movieDays;
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

    public String getEnm() {
        return enm;
    }

    public void setEnm(String enm) {
        this.enm = enm == null ? null : enm.trim();
    }

    public String getCat() {
        return cat;
    }

    public void setCat(String cat) {
        this.cat = cat == null ? null : cat.trim();
    }

    public String getDir() {
        return dir;
    }

    public void setDir(String dir) {
        this.dir = dir == null ? null : dir.trim();
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img == null ? null : img.trim();
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version == null ? null : version.trim();
    }

    public String getDra() {
        return dra;
    }

    public void setDra(String dra) {
        this.dra = dra == null ? null : dra.trim();
    }

    public Double getSc() {
        return sc;
    }

    public void setSc(Double sc) {
        this.sc = sc;
    }

    public Integer getSnum() {
        return snum;
    }

    public void setSnum(Integer snum) {
        this.snum = snum;
    }

    public String getStar() {
        return star;
    }

    public void setStar(String star) {
        this.star = star == null ? null : star.trim();
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src == null ? null : src.trim();
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language == null ? null : language.trim();
    }

    public Integer getDur() {
        return dur;
    }

    public void setDur(Integer dur) {
        this.dur = dur;
    }

    public Boolean getGlobalreleased() {
        return globalreleased;
    }

    public void setGlobalreleased(Boolean globalreleased) {
        this.globalreleased = globalreleased;
    }

    public Long getWish() {
        return wish;
    }

    public void setWish(Long wish) {
        this.wish = wish;
    }

    public Integer getWatched() {
        return watched;
    }

    public void setWatched(Integer watched) {
        this.watched = watched;
    }

    public Date getRt() {
        return rt;
    }

    public void setRt(Date rt) {
        this.rt = rt;
    }

    public Integer getShowst() {
        return showst;
    }

    public void setShowst(Integer showst) {
        this.showst = showst;
    }

    public String getVideoImg() {
        return videoImg;
    }

    public void setVideoImg(String videoImg) {
        this.videoImg = videoImg == null ? null : videoImg.trim();
    }

    public String getVideoName() {
        return videoName;
    }

    public void setVideoName(String videoName) {
        this.videoName = videoName == null ? null : videoName.trim();
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl == null ? null : videoUrl.trim();
    }

    public String getPhotos() {
        return photos;
    }

    public void setPhotos(String photos) {
        this.photos = photos == null ? null : photos.trim();
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }
}