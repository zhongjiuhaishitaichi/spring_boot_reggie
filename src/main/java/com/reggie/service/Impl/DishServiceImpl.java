package com.reggie.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.reggie.common.CustomException;
import com.reggie.dao.DishFlavorMapper;
import com.reggie.dao.DishMapper;
import com.reggie.dao.SetmealDishMapper;
import com.reggie.dto.DishDto;
import com.reggie.pojo.*;
import com.reggie.service.CategoryService;
import com.reggie.service.DishFlavorService;
import com.reggie.service.DishService;
import com.reggie.service.SetmealDishService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service("DishService")
public class DishServiceImpl extends ServiceImpl<DishMapper, Dish> implements DishService {

    private DishFlavorService dishFlavorService;
    private CategoryService categoryService;
    @Autowired
    private DishFlavorMapper dishFlavorMapper;
    @Autowired
    private DishMapper dishMapper;
    @Autowired
    private SetmealDishService setmealDishService;

    @Autowired
    @Lazy
    public void setDishFlavorService(DishFlavorService dishFlavorService) {
        this.dishFlavorService = dishFlavorService;
    }

    @Autowired
    @Lazy
    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    //新增菜品以及口味
    @Override
    @Transactional    //保存菜品的同时保存口味
    public void saveWithFlavor(DishDto dishDto) {
        //保存菜品的基本信息
        this.save(dishDto);
        //菜品id
        Long dishId = dishDto.getId();
        //口味
        List<DishFlavor> flavors = dishDto.getFlavors();
        //把每一个口味都设置上菜品Id
        for (DishFlavor dishFlavor : flavors) {
            dishFlavor.setDishId(dishId);
        }

        //保存菜品口味数据到菜品口味表 dish_flavor
        dishFlavorService.saveBatch(flavors);
    }

    /**
     * 这个分页查询在菜品类别上有问题  要传回去汉字 不能是id
     * 学习使用新特性
     *
     * @param page
     * @param pageSize
     * @param name
     * @return
     */

    @Override
    public Page<DishDto> getPage(int page, int pageSize, String name) {
        Page<Dish> iPage = new Page<>(page, pageSize);
        Page<DishDto> dishDtoPage = new Page<>();
        LambdaQueryWrapper<Dish> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.like(name != null, Dish::getName, name);
        //排序
        queryWrapper.orderByDesc(Dish::getUpdateTime);
        this.page(iPage, queryWrapper);
        BeanUtils.copyProperties(iPage, dishDtoPage, "records");
        List<Dish> records = iPage.getRecords();

        List<DishDto> list = records.stream().map((item) -> {
            DishDto dishDto = new DishDto();
            BeanUtils.copyProperties(item, dishDto);
            Long categoryId = item.getCategoryId(); //分类id
            Category category = categoryService.getById(categoryId);
            String categoryName = category.getName();
            dishDto.setCategoryName(categoryName);
            return dishDto;
        }).collect(Collectors.toList());

        dishDtoPage.setRecords(list);
        return dishDtoPage;
    }

    @Override
    public DishDto getByIdWithFlavor(Long id) {
        Dish dish = this.getById(id);
        LambdaQueryWrapper<DishFlavor> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(DishFlavor::getDishId, dish.getId());
        List<DishFlavor> dishFlavors = dishFlavorMapper.selectList(queryWrapper);
        DishDto dishDto = new DishDto();
        BeanUtils.copyProperties(dish, dishDto);
        dishDto.setFlavors(dishFlavors);
        return dishDto;
    }

    @Override
    @Transactional
    public void updateWithFlavor(DishDto dishDto) {
        //更新菜品表
        this.updateById(dishDto);
        //清理口味数据  再添加新的口味数据
        LambdaQueryWrapper<DishFlavor> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(DishFlavor::getDishId, dishDto.getId());
        dishFlavorService.remove(queryWrapper);
        //  dishFlavorService.saveBatch(dishDto.getFlavors()); //这里只保存了口味  dishFlavor的菜品id和name没有保存
        for (DishFlavor dishFlavor : dishDto.getFlavors()) {
            dishFlavor.setDishId(dishDto.getId());
            dishFlavorMapper.insert(dishFlavor);
        }

    }

    @Override
    public void updateStatusByIds(Integer status, Long[] ids) {
        dishMapper.updateStatusByIds(status, ids);
    }

    @Override
    public void removeByIds(Long[] ids) {
        for (Long id : ids) {
            LambdaQueryWrapper<SetmealDish> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(SetmealDish::getDishId, id);
            long count = setmealDishService.count(queryWrapper);
            if (count > 0) {
                //已关联
                Dish dish = dishMapper.selectById(id);
                throw new CustomException("当前菜品" + dish.getName() + "已关联套餐,无法删除!");
            } else if (isSale(id)==1) {
                throw new CustomException("当前菜品正在销售,无法删除!");
            } else {
                dishMapper.deleteById(id);
            }
        }
    }

    public int isSale(Long id) {
        Dish dish = dishMapper.selectById(id);
        return dish.getStatus();
    }
}
