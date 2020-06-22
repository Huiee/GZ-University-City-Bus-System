package net.huiee;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;


@SpringBootApplication
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class,args);
    }
// extends WebMvcConfigurationSupport
//    @Override
//    protected void addResourceHandlers(ResourceHandlerRegistry registry) {
//        //registry.addResourceHandler("/static/**").addResourceLocations(ResourceUtils.CLASSPATH_URL_PREFIX + "/static/");
//        registry.addResourceHandler("/static/**").addResourceLocations(     "classpath:/static/");
//        super.addResourceHandlers(registry);
//    }

}
