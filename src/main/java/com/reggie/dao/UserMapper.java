package com.reggie.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.reggie.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

@Mapper
public interface UserMapper extends BaseMapper<User> {
    @Select("select * from user where phone=#{email}")
    User getUserByEmail(String email);

    @Select("select name from user where id=#{userId}")
    User getUser(Long userId);
}
