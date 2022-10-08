package com.reggie.service.Impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.reggie.dao.OrderDetailMapper;
import com.reggie.pojo.OrderDetail;
import com.reggie.service.OrderDetailService;
import org.springframework.stereotype.Service;

@Service
public class OrderDetailServiceImpl extends ServiceImpl<OrderDetailMapper, OrderDetail> implements OrderDetailService {

}