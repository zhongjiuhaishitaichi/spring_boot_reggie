package com.reggie.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.reggie.pojo.User;

public interface UserService extends IService<User> {
    //发送邮件
    void sendMsg(String to,String subject,String text);

    User getUser(Long userId);
}
