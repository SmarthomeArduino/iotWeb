package org.momento.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.momento.domain.MemberVO;
import org.momento.mapper.MemberMapper;
import org.momento.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@Controller
public class MemberController {

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private PasswordEncoder passwordEncoder;

	// member Get Mappings

	@GetMapping("/home")
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

	@GetMapping("/member_in_03")
	public void findIdGET() {

		log.info("아이디 찾기 접속");
	}

	@GetMapping("/member_in_04")
	public void findPwGET() {
		log.info("비밀번호 찾기 접속");
	}

	@GetMapping("/member_d_01")
	public void dropUserGET(Model model) {
		log.info("회원탈퇴 접속");

	}

	@GetMapping("/member_in_03_proc")
	public void findIdProc() {
		log.info("아이디 Proc");
	}

	@GetMapping("/member_u_01")
	public void userModifyGET(Model model) {
		MemberVO member = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication.getPrincipal() instanceof CustomUser) {
			CustomUser customUser = (CustomUser) authentication.getPrincipal();
			member = customUser.getMember();
			model.addAttribute("member", member);
		}

		log.info("유저정보 수정 - " + member);

	}

	@GetMapping("/member_in_05")
	public void pwResetGET() {
		log.info("비밀번호 변경 접속(get)");

	}

	// member Post Mappings
	@PostMapping("/member_w_01")
	public String signupPOST(MemberVO memberVO) {

		log.info(memberVO);


		// passwordHash 처리
		String hashedPassword = passwordEncoder.encode(memberVO.getUserpw());
		memberVO.setUserpw(hashedPassword);

		log.info(memberVO);
		memberMapper.insert(memberVO);
		memberMapper.authinsert(memberVO.getUserid());

		return "redirect:/customLogin";
	}
	
	@PostMapping("/idDuplCheck")
	public ResponseEntity<Boolean> idDuplCheck(@RequestBody Map<String, String> requestBody) {

		String id = requestBody.get("id");
		MemberVO member = memberMapper.read(id);
		boolean responseMessage = false; // 성공적으로 처리되었다는 메시지
		
		if(member != null) {
			log.info("중복o");
			return ResponseEntity.ok(true);
		}
		log.info("중복x");

	    // 여기서 적절한 로직을 수행한 후 응답을 보낸다고 가정합니다.
	    return ResponseEntity.ok(responseMessage);
	}

	@PostMapping("/findPwProc")
	public String findPwProc(HttpSession session, @RequestParam("findPwId") String id,
			@RequestParam("findPwSelectedNum") String selectedNum, @RequestParam("findPwNum") String pNum,
			@RequestParam("findPwNum2") String pNum2, @RequestParam("findPwQuestions") String question,
			@RequestParam("findPwAnswer") String answer) {

		MemberVO vo = memberMapper.read(id);

		if (vo == null) {
			// 회원정보 조회
			log.info("없는 사용자 아이디");
			return "redirect:/member/member_in_04";
		}
		if (!vo.getPhone().equals(selectedNum + "-" + pNum + "-" + pNum2)) {
			// 전화번호 불일치
			return "redirect:/member/member_in_04";
		}

		switch (question) {

		case "1":
			if (!answer.equals(vo.getQuestion_answer())) {
				log.info("질문 1번 답변 불일치");
				return "redirect:/member/member_in_04";
			}
			break;

		case "2":
			if (!answer.equals(vo.getQuestion_answer())) {
				log.info("질문 2번 답변 불일치");
				return "redirect:/member/member_in_04";
			}
			break;

		case "3":
			if (!answer.equals(vo.getQuestion_answer())) {
				log.info("질문 3번 답변 불일치");
				return "redirect:/member/member_in_04";
			}
			break;

		default:
			break;
		}

		session.setAttribute("findPwId", id);
		return "redirect:/member/member_in_05";
	}

	@PostMapping("/member_in_05")
	public String pwResetPOST(@RequestParam("newPw") String newPw, @RequestParam("findPwId") String originId) {

		log.info("originId: " + originId);
		String hashedPassword = passwordEncoder.encode(newPw);
		memberMapper.updatePw(originId, hashedPassword);

		log.info("newPw: " + hashedPassword);
		log.info("비밀번호 변경 접속(post)");

		return "redirect:/customLogin";
	}

	@PostMapping("/findIdProc")
	public String findIdPOST(@RequestParam("userName") String userName, @RequestParam("phone") String phone,
			RedirectAttributes rttr) {
		log.info(userName);
		String userName1 = userName.replace(",", "");
		String formatPhone = formatPhoneNumber(phone);

		log.info(userName1 + " " + formatPhone);
		List<String> result = memberMapper.findId(userName1, formatPhone);
		log.info(result);
		rttr.addFlashAttribute("userName1", userName1);
		rttr.addFlashAttribute("userid", result);
		return "redirect:/member/member_in_03_proc";
	}

	@PostMapping("/member_d_01")
	public String dropUserPOST(Model model, @RequestParam("userDeletePw") String userDeletePw) {
		log.info("회원탈퇴 POST");
		MemberVO member = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication.getPrincipal() instanceof CustomUser) {
			CustomUser customUser = (CustomUser) authentication.getPrincipal();
			member = customUser.getMember();
			model.addAttribute("member", member);
		}
		if (passwordEncoder.matches(userDeletePw, member.getUserpw())) {
			// 기존 패스워드와 일치
			log.info("일치");
			memberMapper.deleteUser(member.getUserid());
			return "redirect:/customLogin";
		} else {
			// 불일치
			log.info("불일치");
		}
		return "redirect:/member/member_d_01";
	}

	public String formatPhoneNumber(String phoneNumber) {
		String formattedPhone;
		if (phoneNumber.length() == 10) {
			String areaCode = phoneNumber.substring(0, 3);
			String firstPart = phoneNumber.substring(3, 6);
			String secondPart = phoneNumber.substring(6);
			formattedPhone = areaCode + "-" + firstPart + "-" + secondPart;
		} else if (phoneNumber.length() == 11) {
			String areaCode = phoneNumber.substring(0, 3);
			String firstPart = phoneNumber.substring(3, 7);
			String secondPart = phoneNumber.substring(7);
			formattedPhone = areaCode + "-" + firstPart + "-" + secondPart;
		} else {
			// 전화번호 길이가 10자리 또는 11자리가 아닌 경우에 대한 예외 처리
			formattedPhone = phoneNumber;
		}
		return formattedPhone;
	}
}
