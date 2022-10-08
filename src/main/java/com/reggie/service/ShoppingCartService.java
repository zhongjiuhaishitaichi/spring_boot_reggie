package com.reggie.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.reggie.pojo.ShoppingCart;

public interface ShoppingCartService extends IService<ShoppingCart> {

    void clean(Long userId);
}
