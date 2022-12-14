package com.reggie.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.reggie.common.CustomException;
import com.reggie.dao.CategoryMapper;
import com.reggie.dao.SetmealMapper;
import com.reggie.dto.SetmealDto;
import com.reggie.pojo.Category;
import com.reggie.pojo.Setmeal;
import com.reggie.pojo.SetmealDish;
import com.reggie.service.SetmealDishService;
import com.reggie.service.SetmealService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SetmealServiceImpl extends ServiceImpl<SetmealMapper, Setmeal> implements SetmealService {
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private SetmealDishService setmealDishService;
    @Autowired
    private SetmealMapper setmealMapper;

    @Override
    public Page<SetmealDto> getPage(int page, int pageSize, String name) {
        Page<Setmeal> iPage = new Page<>(page, pageSize);
        Page<SetmealDto> setmealDtoPage = new Page<>();
        LambdaQueryWrapper<Setmeal> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.like(name != null, Setmeal::getName, name);
        queryWrapper.orderByDesc(Setmeal::getUpdateTime);
        this.page(iPage, queryWrapper);
        BeanUtils.copyProperties(iPage, setmealDtoPage, "records");
        List<Setmeal> records = iPage.getRecords();
        List<SetmealDto> list = records.stream().map((item) -> {
            SetmealDto setmealDto = new SetmealDto();
            BeanUtils.copyProperties(item, setmealDto);
            Category category = categoryMapper.selectById(item.getCategoryId());
            setmealDto.setCategoryName(category.getName());
            return setmealDto;
        }).collect(Collectors.toList());

        setmealDtoPage.setRecords(list);
        return setmealDtoPage;
    }


    @Override
    @Transactional
    public void saveWithDish(SetmealDto setmealDto) {

        //?????????????????????getCategoryName()
    /*    Long categoryId = categoryMapper.getCategoryId(setmealDto.getCategoryName());
        setmealDto.setCategoryId(categoryId);*/
        //1.???????????????????????????
        this.save(setmealDto);
        //2.?????????????????????
        List<SetmealDish> dishList = setmealDto.getSetmealDishes();
        //????????????id
        dishList.stream().map((item)->{
            item.setSetmealId(setmealDto.getId());
            return item;
        }).collect(Collectors.toList());

        setmealDishService.saveBatch(dishList);
    }

    @Override
    public void updateStatusByIds(Integer status, Long[] ids) {
        setmealMapper.updateStatusByIds(status, ids);
    }

    @Override
    @Transactional
    public void removeWithDish(List<Long> ids) {
      //??????
        LambdaQueryWrapper<Setmeal> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(Setmeal::getId,ids);
        queryWrapper.eq(Setmeal::getStatus,1);
        long count = this.count(queryWrapper);
        if (count>0){
            throw new CustomException("????????????????????????.????????????..");
        }
        //????????????
        this.removeByIds(ids);
        //???????????????SetmealDish????????????
        LambdaQueryWrapper<SetmealDish> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.in(SetmealDish::getSetmealId,ids);
        setmealDishService.remove(lambdaQueryWrapper);
    }
    /**
     * ?????????????????????????????????id????????????
     * @return
     */
    @Override
    public SetmealDto getData(Long id) {
        Setmeal setmeal = this.getById(id);
        SetmealDto setmealDto = new SetmealDto();
        LambdaQueryWrapper<SetmealDish> queryWrapper = new LambdaQueryWrapper();
        //????????????????????????setmealdish
        queryWrapper.eq(id!=null,SetmealDish::getSetmealId,id);

        if (setmeal != null){
            BeanUtils.copyProperties(setmeal,setmealDto);
            List<SetmealDish> list = setmealDishService.list(queryWrapper);
            setmealDto.setSetmealDishes(list);
            return setmealDto;
        }
        return null;
    }

}
