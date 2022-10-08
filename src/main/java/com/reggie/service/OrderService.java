package com.reggie.service;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.reggie.dto.OrdersDto;
import com.reggie.pojo.Orders;

public interface OrderService extends IService<Orders> {

    /**
     * 用户下单
     * @param orders
     */
    public void submit(Orders orders);

    Page<OrdersDto> getPage(int page, int pageSize);
}
