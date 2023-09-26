package org.momento.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CookieController {
	@GetMapping("/cookie")
	@ResponseBody
	public String getCookie(HttpServletRequest request, HttpServletResponse response) {
		// JSESSIONID 쿠키 가져오기
		Cookie[] cookies = request.getCookies();
		
		String jsessionId = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {

				if ("JSESSIONID".equals(cookie.getName())) {
					log.info(cookie.getName());
					log.info(cookie.getValue());
					jsessionId = cookie.getValue();
					break;
				}
			}
		}

		
		if (jsessionId != null) {
			return jsessionId;
		} else {
			return "A84F694D32404F97F37FCEE2FD96F05D";
		}
	}
}