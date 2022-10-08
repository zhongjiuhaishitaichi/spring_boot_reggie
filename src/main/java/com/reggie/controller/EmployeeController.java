package com.reggie.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.reggie.common.R;
import com.reggie.pojo.Employee;
import com.reggie.service.EmployeeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@RestController
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @PostMapping("/login")       ////前端传的是json过来,用注解接受成实体对象 要求对应
    public R<Employee> login(HttpServletRequest request, @RequestBody Employee employee) {
        //1.明文密码进行md5加密处理
        String password = employee.getPassword();
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        //2.再查数据库
        LambdaQueryWrapper<Employee> wrapper = new LambdaQueryWrapper<>(); //lambda表达式 查询条件
        wrapper.eq(Employee::getUsername, employee.getUsername());
        Employee emp = employeeService.getOne(wrapper); //Unique    getOne查出来唯一一个
        //3.判断查询结果
        if (emp == null) {
            return R.error("登陆失败.信息有误..");
        }
        //4. 密码比对  判断密码对不对
        if (!emp.getPassword().equals(password)) {
            return R.error("登陆失败.信息有误..");
        }
        //5.查看员工的状态
        if (emp.getStatus() == 0) {
            return R.error("账号已禁用.");
        }
        //6. 登录成功  保存到session作用域
        request.getSession().setAttribute("employee", emp.getId());
        return R.success(emp);
    }

    @PostMapping("/logout")
    public R<String> logout(HttpServletRequest request) {
        //1.清理session里面的userId
        request.getSession().removeAttribute("employee");
        return R.success("退出成功.");
    }

    /**
     * 新增员工信息
     *
     * @param employee
     * @return
     */
    @PostMapping
    public R<String> save(HttpServletRequest request, @RequestBody Employee employee) {
        log.info("新增员工信息: {}", employee.toString());
        //设置初始密码123123,需要进行md5加密
        employee.setPassword(DigestUtils.md5DigestAsHex("123123".getBytes()));
  /*      employee.setCreateTime(LocalDateTime.now());
        employee.setUpdateTime(LocalDateTime.now());
        //获得当前用户登录的id
        Long empId = (Long) request.getSession().getAttribute("employee");
        employee.setCreateUser(empId);
        employee.setUpdateUser(empId);*/
        employeeService.save(employee);
        return R.success("新增员工成功.");
    }

    //这里前端的发的请求不是rest风格的(/{page}/{pageSize}/...)
    //使用的是地址栏拼接  所以直接写参数就ok
    @GetMapping("/page")
    public R<IPage<Employee>> page(int page, int pageSize, String name) {
        log.info("page= {} pageSize={} name={}", page, pageSize, name);

        IPage<Employee> iPage = employeeService.getPage(page, pageSize, name);
        if (page > iPage.getPages()) {
            iPage = employeeService.getPage((int) iPage.getPages(), pageSize, name);
        }
        return R.success(iPage);
    }

    /**
     * 通用方法 修改员工信息
     *
     * @param employee
     * @return
     */
    @PutMapping
    public R<String> update(HttpServletRequest request, @RequestBody Employee employee) {
     /*   employee.setUpdateTime(LocalDateTime.now());
        employee.setUpdateUser((Long) request.getSession().getAttribute("employee"));*/
        employeeService.updateById(employee);
        return R.success("员工信息修改成功.");
    }

    @GetMapping("/{id}")
    public R<Employee> getById(@PathVariable Long id) {
        Employee employee = employeeService.getById(id);
        if (employee!=null){
            return R.success(employee);
        }else {
            return R.error("没有查到相关信息.");
        }
    }
}
