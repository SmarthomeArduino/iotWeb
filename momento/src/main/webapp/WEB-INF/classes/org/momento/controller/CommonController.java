package org.momento.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.momento.domain.MemberVO;
import org.momento.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

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

	@GetMapping("/customLogout")
	public void logoutGET() {

		log.info("로그아웃 접속");
	}

	@PostMapping("/customLogout")
	public void logoutPost() {

		log.info("로그아웃 [POST] 실행");
	}

	@GetMapping("/")
	public String mainGET() {
		return "redirect:/customLogin";
	}

	@Autowired
	private MemberMapper memberMapper;

	@PostMapping(value = "/member/all")
	public void signupPOST(MemberVO memberVO) {

	log.info(memberVO);
	
	}


}
