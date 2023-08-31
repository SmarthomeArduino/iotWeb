package org.momento.controller;

import org.json.JSONObject;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	// Basic Get Mapping

	@GetMapping("/")
	public String mainGET() {
		return "redirect:/customLogin";
	}

	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);

		model.addAttribute("msg", "액세스 디나이");
	}

	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {

		log.info("error: " + error);
		log.info("logout: " + logout);

		if (error != null) {
			model.addAttribute("error", "계정 확인 실패, 재확인 해주세요.");
		}

		if (logout != null) {
			model.addAttribute("logout", "로그아웃");
		}
	}
	
	@PostMapping(value = "/testAjax",  produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<String> toDo() {
		log.info("asd");
		
		String responseData = "Response data"; 
		
		// JSONObject 생성
		JSONObject json = new JSONObject();
		json.put("key", responseData);

		// JSON 문자열로 변환
		String jsonString = json.toString();
		
//		todoMapper.insert(todoVo);
	
		return ResponseEntity.ok(jsonString);
		
	}

	@GetMapping("/customLogout")
	public void logoutGET() {

		log.info("로그아웃 접속");
	}

	// Basic Post Mapping

	@PostMapping("/customLogout")
	public void logoutPost() {

		log.info("로그아웃 [POST] 실행");
	}
	
	

}
