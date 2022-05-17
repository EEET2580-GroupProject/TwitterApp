package com.example.twitterapp.conifg;

import com.example.twitterapp.convert.StringToEnum;
import com.example.twitterapp.interceptor.LoggingInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.format.FormatterRegistry;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.servlet.config.annotation.AsyncSupportConfigurer;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.util.concurrent.ThreadPoolExecutor;

@Configuration
@ComponentScan(basePackages = "com.example.twitterapp")
public class ApplicationConfig extends WebMvcConfigurationSupport {
    @Override
    protected void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("css/**", "images/**")          // tell it where to look for resources
                .addResourceLocations("classpath:/static/css/", "classpath:/static/images/");  // pick up static file

    }

    @Bean
    public InternalResourceViewResolver jspViewResolver(){
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/jsp/");     // find the jsp file(View)
        viewResolver.setSuffix(".jsp");
        viewResolver.setViewClass(JstlView.class);      // To appropriately render your jsp file
        return viewResolver;
    }

    @Override
    protected void addFormatters(FormatterRegistry registry){
        registry.addConverter(new StringToEnum());
    }


    ///Below codes enables async
    @Override
    protected void configureAsyncSupport(AsyncSupportConfigurer configurer) {
        configurer.setTaskExecutor(mvcTaskExecutor());
        configurer.setDefaultTimeout(90000);
    }

    @Bean
    public AsyncTaskExecutor mvcTaskExecutor(){
        ThreadPoolTaskExecutor threadPoolTaskExecutor =new ThreadPoolTaskExecutor();
        threadPoolTaskExecutor.setThreadNamePrefix("Thread-");
        return threadPoolTaskExecutor;
    }

    @Override
    protected void addInterceptors(InterceptorRegistry registry){
        // /* means it apply to all url pattern: /login /register /home. Use specific url pattern to target a particular url pattern
        // Use this to call API
        registry.addInterceptor(new LoggingInterceptor()).addPathPatterns("/*");
    }
}