package com.example.twitterapp.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

public class LoggingInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //This basically intercept with all the request and log it to the console
        // FIrst get all cookies
        // log session id;
        // log request path

        String sessionId = null;

        if(null != request.getCookies()){
            for(Cookie cookie: request.getCookies()){
                if(cookie.getName().equals("JSESSIONID")){
                    sessionId = cookie.getValue();
                }
            }
        }

        System.out.println("Session: " + sessionId + " at" + new Date()+ " for" + request.getRequestURI());

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("Go through postHandler without oing anything");
    }
}
