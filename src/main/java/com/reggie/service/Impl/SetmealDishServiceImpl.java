package com.reggie.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.reggie.dao.SetmealDishMapper;
import com.reggie.pojo.SetmealDish;
import com.reggie.service.SetmealDishService;
import org.springframework.stereotype.Service;

@Service
public class SetmealDishServiceImpl extends ServiceImpl<SetmealDishMapper,SetmealDish> implements SetmealDishService {
}
