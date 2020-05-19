package com.moke.wp.wx_weimai.config.util;

import java.io.Serializable;

public class Result implements Serializable{

    private static final long serialVersionUID = -4800793124936904868L;
    public static final int SUCCESS=200;
    public static final int ERROR=201;
    public static final int NOAUTHC=202;

    /**
     * 返回是否成功的状态,200表示成功,
     * 201或其他值 表示失败
     */
    private int state;
    /**
     * 成功时候,返回的JSON数据
     */
    private Object data;
    /**
     * 是错误时候的错误消息
     */
    private String message;


    public Result() {
    }


    public Result(int state,String message) {
        this.state = state;
        this.message = message;
    }

    public Result(Throwable e){
        state = ERROR;
        data=null;
        message=e.getMessage();
    }

    public Result(Object data){
        state = SUCCESS;
        this.data=data;
        message="";
    }

    public int getState() {
        return state;
    }


    public void setState(int state) {
        this.state = state;
    }


    public Object getData() {
        return data;
    }


    public void setData(Object data) {
        this.data = data;
    }


    public String getMessage() {
        return message;
    }


    public void setMessage(String message) {
        this.message = message;
    }


    @Override
    public String toString() {
        return "JsonResult [state=" + state + ", data=" + data + ", message=" + message + "]";
    }

}
