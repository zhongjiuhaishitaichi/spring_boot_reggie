package com.reggie.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.reggie.dao.AddressBookMapper;
import com.reggie.pojo.AddressBook;
import com.reggie.service.AddressBookService;
import org.springframework.stereotype.Service;

@Service
public class AddressBookBookServiceImpl extends ServiceImpl<AddressBookMapper, AddressBook> implements AddressBookService {
}
