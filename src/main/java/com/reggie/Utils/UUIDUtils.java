package com.reggie.Utils;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.UUID;

@Slf4j
public class UUIDUtils {
        public static final Logger logger = LoggerFactory.getLogger(UUIDUtils.class);

        public static String getUUID(){
            return UUID.randomUUID().toString().replace("-","");
        }

        public static void main(String[] args) {

            System.out.println(getUUID());
            logger.debug("test");
        }
    }
