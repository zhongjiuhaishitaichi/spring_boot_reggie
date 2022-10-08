package com.reggie.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.reggie.pojo.Category;
import com.reggie.pojo.Employee;

public interface CategoryService extends IService<Category> {
    IPage<Category> getPage(int page, int pageSize);

    void remove(Long id);

    String getCategoryName(Long categoryId);
}
