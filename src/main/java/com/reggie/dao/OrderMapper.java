package com.reggie.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.reggie.pojo.Orders;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper extends BaseMapper<Orders> {

}