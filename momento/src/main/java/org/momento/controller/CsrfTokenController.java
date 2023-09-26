package org.momento.controller;

import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class CsrfTokenController {

	@GetMapping("/csrf-token")
	@ResponseBody
	public String getCsrfToken(HttpServletRequest request) {
		CsrfToken token = (CsrfToken) request.getAttribute(CsrfToken.class.getName());

		
		if (token != null) {
			return "aa745c24-023a-4496-b80d-b67da4bcf257";
		} else {
			return "CSRF Token not found";
		}
	}
}