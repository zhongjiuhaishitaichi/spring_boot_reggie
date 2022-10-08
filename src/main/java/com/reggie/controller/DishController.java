package com.reggie.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.reggie.common.R;
import com.reggie.dto.DishDto;
import com.reggie.pojo.Category;
import com.reggie.pojo.Dish;
import com.reggie.pojo.DishFlavor;
import com.reggie.service.CategoryService;
import com.reggie.service.DishFlavorService;
import com.reggie.service.DishService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/dish")
public class DishController {
    private final DishService dishService;
    private final DishFlavorService dishFlavorService;
    @Autowired
    private CategoryService categoryService;

    public DishController(DishService dishService, DishFlavorService dishFlavorService) {
        this.dishService = dishService;
        this.dishFlavorService = dishFlavorService;
    }

    @PostMapping
    public R<String> save(@RequestBody DishDto dishDto) {
        dishService.saveWithFlavor(dishDto);
        return R.success("新增菜品成功.");
    }

    @GetMapping("/page")
    public R<Page> list(int page, int pageSize, String name) {
        Page<DishDto> dishDtoPage = dishService.getPage(page, pageSize, name);
        return R.success(dishDtoPage);
    }
    @GetMapping("/{id}")
    public R<DishDto> editFood(@PathVariable Long id){
        DishDto dishDto = dishService.getByIdWithFlavor(id);
        return  R.success(dishDto);
    }
    @PutMapping
    public R<String> update(@RequestBody DishDto dishDto) {
        dishService.updateWithFlavor(dishDto);
        return R.success("新增菜品成功.");
    }
    @PostMapping("/status/{status}")
    public R<String> updateStatus(@PathVariable Integer status,Long[] ids){
        dishService.updateStatusByIds(status,ids);
        return R.success("状态修改成功.");
    }
    @DeleteMapping
    public R<String> delete(Long[] ids){
        dishService.removeByIds(ids);
        return R.success("删除成功");
    }
  /*  @GetMapping("/list")
    public R<List<Dish>> list(Dish dish){
        LambdaQueryWrapper<Dish> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(dish.getCategoryId()!=null,Dish::getCategoryId,dish.getCategoryId());
        //查询状态是1的
        queryWrapper.eq(Dish::getStatus,1);
        queryWrapper.orderByAsc(Dish::getSort).orderByAsc(Dish::getUpdateTime);
        List<Dish> list = dishService.list(queryWrapper);
        return R.success(list);
    }*/
  @GetMapping("/list")
  public R<List<DishDto>> list(Dish dish){
      LambdaQueryWrapper<Dish> queryWrapper = new LambdaQueryWrapper<>();
      queryWrapper.eq(dish.getCategoryId()!=null,Dish::getCategoryId,dish.getCategoryId());
      //查询状态是1的
      queryWrapper.eq(Dish::getStatus,1);
      queryWrapper.orderByAsc(Dish::getSort).orderByAsc(Dish::getUpdateTime);
      List<Dish> list = dishService.list(queryWrapper);
      List<DishDto> dishDtoList = list.stream().map((item) -> {
          DishDto dishDto = new DishDto();
          BeanUtils.copyProperties(item, dishDto);
          Long categoryId = item.getCategoryId(); //分类id
          Category category = categoryService.getById(categoryId);
          if(category!=null){
              String categoryName = category.getName();
              dishDto.setCategoryName(categoryName);
          }
          //当前菜品id
          Long dishId = item.getId();
          LambdaQueryWrapper<DishFlavor> lambdaQueryWrapper = new LambdaQueryWrapper<>();
          lambdaQueryWrapper.eq(DishFlavor::getDishId,dishId);
          List<DishFlavor> dishFlavorList = dishFlavorService.list(lambdaQueryWrapper);
          dishDto.setFlavors(dishFlavorList);
          return dishDto;
      }).collect(Collectors.toList());

      return R.success(dishDtoList);
  }
}
