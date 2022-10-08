package com.reggie.service.Impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.reggie.dao.EmployeeMapper;
import com.reggie.pojo.Employee;
import com.reggie.service.EmployeeService;
import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiceImpl extends ServiceImpl<EmployeeMapper, Employee> implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public IPage<Employee> getPage(int page, int pageSize, String name) {
        LambdaQueryWrapper<Employee> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.like(Strings.isNotEmpty(name), Employee::getName, name);
        lambdaQueryWrapper.orderByDesc(Employee::getUpdateTime);
        IPage<Employee> IPage = new Page<>(page, pageSize);
        employeeMapper.selectPage(IPage, lambdaQueryWrapper);
        return IPage;
    }
}
