package com.reggie.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.reggie.dao.UserMapper;
import com.reggie.pojo.User;
import com.reggie.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    //把yml配置的邮箱号赋值到from
    @Value("${spring.mail.username}")
    private String from;
    //发送邮件需要的对象
    @Autowired
    private JavaMailSender javaMailSender;
    @Autowired
    private UserMapper userMapper;
    //邮件发送人
    @Override
    public void sendMsg(String to, String subject, String text) {
        //发送简单邮件，简单邮件不包括附件等别的
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);
        message.setCc(from);
        //发送邮件
        try {
            javaMailSender.send(message);
            log.info("邮件发送成功,从: "+from+"发给: "+to);
        } catch (MailException e) {
            log.info("信息发送失败.");
            throw new RuntimeException(e);

        }
    }

    @Override
    public User getUser(Long userId) {
        return  userMapper.getUser(userId);
    }
}
