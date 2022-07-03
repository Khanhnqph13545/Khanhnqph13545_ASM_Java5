package sof3021.intercreptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class ErrorIntercreptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		if (ex instanceof NullPointerException) {
			ex.printStackTrace();
		}else if (ex instanceof NumberFormatException) {
			//
		}
	}
	
}
