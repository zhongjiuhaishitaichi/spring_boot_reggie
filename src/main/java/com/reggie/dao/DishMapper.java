package com.reggie.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.reggie.pojo.Dish;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface DishMapper extends BaseMapper<Dish> {

    void updateStatusByIds(Integer status, Long[] ids);
}
