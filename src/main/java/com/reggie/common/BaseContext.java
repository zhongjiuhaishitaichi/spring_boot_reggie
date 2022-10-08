package com.reggie.common;

/**
 * 作用域是一个单独的线程
 * 基于ThreadLocal 封装工具类
 * 用于 用户保存和获得用户信息
 */
public class BaseContext {
    private static ThreadLocal<Long> threadLocal =new ThreadLocal<>();

    public static void setCurrentId(Long id){
        threadLocal.set(id);
    }
    public static Long getCurrentId(){
         return threadLocal.get();
    }
}
