package com.reggie.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.reggie.pojo.Employee;
public interface EmployeeService extends IService<Employee> {
    IPage<Employee> getPage(int page, int pageSize, String name);
}
