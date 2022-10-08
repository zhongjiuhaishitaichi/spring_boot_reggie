package com.reggie.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.reggie.pojo.Category;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CategoryMapper extends BaseMapper<Category> {

    @Select("select id from category where name=#{name} and type=2")
    Long getCategoryId(@Param("name") String categoryName);
}
