package com.reggie.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.reggie.common.BaseContext;
import com.reggie.common.CustomException;
import com.reggie.common.R;
import com.reggie.pojo.ShoppingCart;
import com.reggie.pojo.User;
import com.reggie.service.ShoppingCartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 依然可以使用HttpServletRequest得到session得到用户信息
 * 购物车
 */
@Slf4j
@RestController
@RequestMapping("/shoppingCart")
public class ShoppingCartController {

    @Autowired
    private ShoppingCartService shoppingCartService;

    /**
     * 添加购物车
     *
     * @param shoppingCart
     * @return
     */
    @PostMapping("/add")
    public R<ShoppingCart> add(@RequestBody ShoppingCart shoppingCart) {
        log.info("购物车数据:{}", shoppingCart);

        //设置用户id，指定当前是哪个用户的购物车数据
        Long currentId = BaseContext.getCurrentId();
        shoppingCart.setUserId(currentId);

        Long dishId = shoppingCart.getDishId();

        LambdaQueryWrapper<ShoppingCart> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ShoppingCart::getUserId, currentId);

        if (dishId != null) {
            //添加到购物车的是菜品
            queryWrapper.eq(ShoppingCart::getDishId, dishId);

        } else {
            //添加到购物车的是套餐
            queryWrapper.eq(ShoppingCart::getSetmealId, shoppingCart.getSetmealId());
        }

        //查询当前菜品或者套餐是否在购物车中
        //SQL:select * from shopping_cart where user_id = ? and dish_id/setmeal_id = ?
        ShoppingCart cartServiceOne = shoppingCartService.getOne(queryWrapper);

        if (cartServiceOne != null) {
            //如果已经存在，就在原来数量基础上加一
            Integer number = cartServiceOne.getNumber();
            cartServiceOne.setNumber(number + 1);
            shoppingCartService.updateById(cartServiceOne);
        } else {
            //如果不存在，则添加到购物车，数量默认就是一
            shoppingCart.setNumber(1);
            shoppingCart.setCreateTime(LocalDateTime.now());
            shoppingCartService.save(shoppingCart);
            cartServiceOne = shoppingCart;
        }

        return R.success(cartServiceOne);
    }

    /**
     * 菜品和套餐分别判断  先-1 在判断
     *
     * @param shoppingCart
     * @return
     */
    @PostMapping("/sub")
    public R<ShoppingCart> reduce(@RequestBody ShoppingCart shoppingCart) {
        Long currentId = BaseContext.getCurrentId();
        LambdaQueryWrapper<ShoppingCart> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        //当是菜品的时候
        Long dishId = shoppingCart.getDishId();
        if (dishId != null) {
            lambdaQueryWrapper.eq(ShoppingCart::getUserId, currentId);
            lambdaQueryWrapper.eq(ShoppingCart::getDishId, dishId);
            ShoppingCart shoppingCartOne = shoppingCartService.getOne(lambdaQueryWrapper);
            shoppingCartOne.setNumber(shoppingCartOne.getNumber() - 1);
            Integer lastNumber = shoppingCartOne.getNumber();
            if (lastNumber > 0) {
                shoppingCartService.updateById(shoppingCartOne);
            } else if (lastNumber == 0) {
                shoppingCartService.removeById(shoppingCartOne.getId());
            } else if (lastNumber < 0) {
                throw new CustomException("操作异常,尝试刷新");
            }
            return R.success(shoppingCartOne);
        }
        //套餐的时候
        Long setmealId = shoppingCart.getSetmealId();
        if (setmealId != null) {
            lambdaQueryWrapper.eq(ShoppingCart::getSetmealId, shoppingCart.getSetmealId());
            lambdaQueryWrapper.eq(ShoppingCart::getUserId, currentId);
            ShoppingCart shoppingCartTwo = shoppingCartService.getOne(lambdaQueryWrapper);
            shoppingCartTwo.setNumber(shoppingCartTwo.getNumber() - 1);
            Integer twoLastNumber = shoppingCartTwo.getNumber();
            if (twoLastNumber > 0) {
                shoppingCartService.updateById(shoppingCartTwo);
            } else if (twoLastNumber == 0) {
                shoppingCartService.removeById(shoppingCartTwo.getId());
            } else if (twoLastNumber < 0) {
                throw new CustomException("操作异常,尝试刷新");
            }
            return R.success(shoppingCartTwo);
        }
        return R.error("未知错误");
    }


    /**
     * 查看购物车
     *
     * @return
     */
    @GetMapping("/list")
    public R<List<ShoppingCart>> list() {
        log.info("查看购物车...");

        LambdaQueryWrapper<ShoppingCart> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ShoppingCart::getUserId, BaseContext.getCurrentId());
        queryWrapper.orderByAsc(ShoppingCart::getCreateTime);

        List<ShoppingCart> list = shoppingCartService.list(queryWrapper);

        return R.success(list);
    }

    /**
     * 清空购物车
     *
     * @return
     */
    @DeleteMapping("/clean")
    public R<String> clean(HttpServletRequest servletRequest) {
        Long user = (Long) servletRequest.getSession().getAttribute("user");
        shoppingCartService.clean(user);
        return R.success("清空购物车成功");
    }
}