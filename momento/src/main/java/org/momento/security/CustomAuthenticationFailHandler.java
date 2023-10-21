package org.momento.security;

import java.io.IOException;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
 
public class CustomAuthenticationFailHandler implements AuthenticationFailureHandler {
    
    
    @Override
    public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse res, AuthenticationException arg2)
            throws IOException, ServletException {
    	// 로그인 실패 처리
        req.getRequestDispatcher("/customLogin?error=true").forward(req, res);
    }
 
}