package com.reggie.filter;

import com.alibaba.fastjson.JSON;
import com.reggie.common.BaseContext;
import com.reggie.common.R;
import com.reggie.pojo.Employee;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.AntPathMatcher;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 过滤器
 * 检查用户是否已经完成登录
 */
@WebFilter(filterName = "loginCheckFilter", urlPatterns = "/*")
@Slf4j
public class LoginCheckFilter implements Filter {
    //路径匹配器, 支持通配符
    public static final AntPathMatcher PATH_MATCHER = new AntPathMatcher();

    @Value("${excludePath}")
    String excludePath;


    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        //1.本次请求的URI
        String requestURI = request.getRequestURI();
        log.info("拦截请求: {}", request.getRequestURI());
        //定义不需要处理的路径
        String[] urls = excludePath.split(",");
        //2.判断本次请求是否需要处理
        boolean check = check(urls, requestURI);
        //3.不处理直接放行
        if (check) {
            filterChain.doFilter(request, response);
        } else {//4. 剩下的需要处理的请求 就要判断用户是否已经登录了
            Long employeeId = (Long) request.getSession().getAttribute("employee");
            if (employeeId != null) {
                BaseContext.setCurrentId(employeeId);
                filterChain.doFilter(request, response);
            } else {
                Long userId = (Long) request.getSession().getAttribute("user");
                if (userId != null) {
                    BaseContext.setCurrentId(userId);
                    filterChain.doFilter(request, response);
                } else { //5.未登录的情况  通过输出流的方式向客户端页面响应数据
                    response.getWriter().write(JSON.toJSONString(R.error("NOTLOGIN")));
                }
            }

        }
    }

    /**
     * 检查本次需不需要放行
     *
     * @param urls
     * @param requestURI
     * @return
     */
    public boolean check(String[] urls, String requestURI) {
        for (String url : urls) {
            boolean match = PATH_MATCHER.match(url, requestURI);
            if (match) {
                return true;
            }
        }
        return false;
    }
}

