package sof3021.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import sof3021.intercreptors.AdminIntercreptor;
import sof3021.intercreptors.LoginIntercreptor;

@Configuration
public class IntercreptorConfig implements WebMvcConfigurer {
	@Autowired
	LoginIntercreptor lgintercreptor;
	@Autowired
	AdminIntercreptor adminIntercreptor;
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(lgintercreptor).addPathPatterns("/admin/**","/user/**");
		registry.addInterceptor(adminIntercreptor).addPathPatterns("/admin/**");
	}
	
	

}
