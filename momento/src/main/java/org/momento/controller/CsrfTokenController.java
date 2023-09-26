package org.momento.controller;

import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

import javax.servlet.http.HttpServletRequest;

@Log4j
@Controller
public class CsrfTokenController {

	@GetMapping("/csrf-token")
	@ResponseBody
	public String getCsrfToken(HttpServletRequest request) {
		CsrfToken token = (CsrfToken) request.getAttribute(CsrfToken.class.getName());
		if (token != null) {
//        	log.info(token.getHeaderName());
//        	log.info(token.getParameterName());
//        	log.info(token.getToken());

			return token.getToken();
		} else {
			return "CSRF Token not found";
		}
	}
}