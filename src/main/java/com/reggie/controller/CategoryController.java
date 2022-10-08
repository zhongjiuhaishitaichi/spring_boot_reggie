package com.reggie.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.reggie.common.R;
import com.reggie.pojo.Category;
import com.reggie.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/category")
@Slf4j
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    /**
     * 新增分类
     *
     * @param category
     * @return
     */
    @PostMapping
    public R<String> save(@RequestBody Category category) {
        categoryService.save(category);
        return R.success("新增分类成功.");
    }

    @GetMapping("/page")
    public R<IPage<Category>> getPage(int page, int pageSize) {
        IPage<Category> iPage = categoryService.getPage(page, pageSize);
        if (page > iPage.getPages()) {
            iPage = categoryService.getPage((int) iPage.getPages(), pageSize);
        }
        return R.success(iPage);
    }

    @DeleteMapping
    //地址栏拼接
    public R<String> delete(Long id) {
       // categoryService.removeById(id);
        categoryService.remove(id);
        return R.success("删除成功.");
    }
    /**
     * 根据id修改分类信息
     * @param category
     * @return
     */
    @PutMapping
    public R<String> update(@RequestBody Category category){
        log.info("修改分类信息：{}",category);

        categoryService.updateById(category);

        return R.success("修改分类信息成功");
    }

    /**
     * 根据条件查询分类数据
     * 前端不会写
     * @param category
     * @return
     */
    @GetMapping("/list")
    public R<List<Category>> list(Category category){
        LambdaQueryWrapper<Category> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        //不为空的时候才查找
        lambdaQueryWrapper.eq(category.getType()!=null,Category::getType,category.getType());
        lambdaQueryWrapper.orderByAsc(Category::getSort).orderByDesc(Category::getUpdateTime);
        List<Category> list = categoryService.list(lambdaQueryWrapper);
        return R.success(list);
    }
}
