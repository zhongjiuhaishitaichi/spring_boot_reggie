package com.reggie.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.reggie.common.CustomException;
import com.reggie.dao.CategoryMapper;
import com.reggie.pojo.Category;
import com.reggie.pojo.Dish;
import com.reggie.pojo.Setmeal;
import com.reggie.service.CategoryService;
import com.reggie.service.DishService;
import com.reggie.service.SetmealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

@Service("CategoryService")
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {

    private CategoryMapper categoryMapper;

    private DishService dishService;

    private SetmealService setmealService;

    @Autowired
    @Lazy
    public void setCategoryMapper(CategoryMapper categoryMapper) {
        this.categoryMapper = categoryMapper;
    }

    @Autowired
    @Lazy
    public void setDishService(DishService dishService) {
        this.dishService = dishService;
    }

    @Autowired
    @Lazy
    public void setSetmealService(SetmealService setmealService) {
        this.setmealService = setmealService;
    }

    @Override
    public IPage<Category> getPage(int page, int pageSize) {
        Page<Category> iPage = new Page<>(page, pageSize);
        LambdaQueryWrapper<Category> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(Category::getSort);//升序
        categoryMapper.selectPage(iPage, wrapper);
        return iPage;
    }

    /**
     * 删除菜品分类 但是要判断是否有关联的套餐或者菜品
     * 看看能不能查出来count就行了
     *
     * @param id
     */
    @Override
    public void remove(Long id) {
        //1.查询当前分类是否关联菜品  否则抛出异常
        LambdaQueryWrapper<Dish> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Dish::getCategoryId, id);
        long count = dishService.count(queryWrapper);
        if (count > 0) {
            //已经关联
            throw new CustomException("当前分类下已关联菜品,无法删除!");
        }
        //2.查询当前分类是否关联套餐
        LambdaQueryWrapper<Setmeal> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(Setmeal::getCategoryId, id);
        long num = setmealService.count(lambdaQueryWrapper);
        if (num > 0) {
            //已关联
            throw new CustomException("当前分类下已关联套餐,无法删除!");
        }
        //3.两个都没有关联 正常删除
        categoryMapper.deleteById(id);
    }

    @Override
    public String getCategoryName(Long categoryId) {
        Category category = categoryMapper.selectById(categoryId);
        return category.getName();
    }
}
