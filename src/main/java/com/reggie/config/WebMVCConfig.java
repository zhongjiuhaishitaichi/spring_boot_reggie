package com.reggie.config;

import com.reggie.common.JacksonObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@Slf4j
@Configuration
public class WebMVCConfig implements WebMvcConfigurer {

    /**
     * 当boot项目扩展mvc转换器的时候要实现  WebMvcConfigurer 接口 不能用support那个
     * 扩展mvc的转换器
     */

    @Override
    public void extendMessageConverters(List<HttpMessageConverter<?>> converters) {
        //创建消息转换器对象
        MappingJackson2HttpMessageConverter messageConverter = new MappingJackson2HttpMessageConverter();
        //设置对象转换器
        messageConverter.setObjectMapper(new JacksonObjectMapper());
        //把上面jackson转换器追加到mvc转换器中
        //下标设置为0 优先级最高
        converters.add(0, messageConverter);
    }
}
