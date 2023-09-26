
package org.momento.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@Controller
public class CookieController {

	@GetMapping("/cookie")
	@ResponseBody
	public String getCookie(HttpServletRequest request) {
		// JSESSIONID 쿠키 가져오기
		Cookie[] cookies = request.getCookies();

		String jsessionId = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("JSESSIONID".equals(cookie.getName())) {
					jsessionId = cookie.getValue();
					break;
				}
			}
		}
		if (jsessionId != null) {
			return jsessionId;
		} else {
			return "092A53AB5EA0FB4AB64F214F64366CA4";
		}
	}
}
