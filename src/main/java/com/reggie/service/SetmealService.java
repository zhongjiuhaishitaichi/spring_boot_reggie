package com.reggie.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.reggie.dto.SetmealDto;
import com.reggie.pojo.Setmeal;

import java.util.List;

public interface SetmealService extends IService<Setmeal> {
    Page<SetmealDto> getPage(int page, int pageSize, String name);
    //新增套餐同时保存具体的菜品信息
    void saveWithDish(SetmealDto setmealDto);

    void updateStatusByIds(Integer status, Long[] ids);
    void removeWithDish(List<Long> ids);
    /**
     * 回显套餐数据：根据套餐id查询套餐
     * @return
     */
    SetmealDto getData(Long id);

}
