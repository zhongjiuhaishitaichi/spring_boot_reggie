package com.reggie.dto;


import com.reggie.pojo.Setmeal;
import com.reggie.pojo.SetmealDish;
import lombok.Data;

import java.util.List;

@Data
public class SetmealDto extends Setmeal {

    private List<SetmealDish> setmealDishes;

    private String categoryName;
}
