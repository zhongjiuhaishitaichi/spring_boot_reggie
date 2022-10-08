package com.reggie.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.reggie.dto.DishDto;
import com.reggie.pojo.Dish;

import java.util.List;

public interface DishService extends IService<Dish> {
    //新增菜品,同时插入菜品对应的口味, dish ,dish_flavor
    void saveWithFlavor(DishDto dishDto);

    Page<DishDto> getPage(int page, int pageSize, String name);

    DishDto getByIdWithFlavor(Long id);

    void updateWithFlavor(DishDto dishDto);

    void updateStatusByIds(Integer status, Long[] ids);

    void removeByIds(Long[] ids);
}
