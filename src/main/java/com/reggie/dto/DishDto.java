package com.reggie.dto;


import com.baomidou.mybatisplus.annotation.TableField;
import com.reggie.pojo.Dish;
import com.reggie.pojo.DishFlavor;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class DishDto extends Dish {

    @TableField(exist = false)
    private List<DishFlavor> flavors = new ArrayList<>();

    @TableField(exist = false)
    private String categoryName;

    @TableField(exist = false)
    private Integer copies;
}
