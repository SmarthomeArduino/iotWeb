package org.momento.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@Controller
public class memberController {

	@GetMapping("/all")
	public void doAll() {

		log.info("사용자 [all] 로딩");
	}

	@GetMapping("/user")
	public void doUser() {

		log.info("사용자 [User] 로딩");
	}

	@GetMapping("/admin")
	public void doAdmin() {

		log.info("사용자 [Admin] 로딩");
	}

	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	@GetMapping("/annoUser")
	public void doUser2() {

		log.info("사용자 [Admin] 부가 접속");
	}

	@Secured({ "ROLE_ADMIN" })
	@GetMapping("/annoAdmin")
	public void doAdmin2() {

		log.info("사용자 [Admin] 부가 접속");
	}

	@GetMapping("/member_w_01")
	public void signupGET() {

		log.info("회원가입 접속");
	}
}
