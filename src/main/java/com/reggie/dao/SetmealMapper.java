package com.reggie.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.reggie.pojo.Setmeal;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

@Mapper
public interface SetmealMapper  extends BaseMapper<Setmeal> {


    void updateStatusByIds(Integer status, Long[] ids);
}
