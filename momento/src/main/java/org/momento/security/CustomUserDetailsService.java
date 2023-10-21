package org.momento.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.servlet.ModelAndView;
import org.momento.domain.AuthVO;
import org.momento.domain.MemberVO;
import org.momento.mapper.MemberMapper;
import org.momento.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

		log.warn("Load User By UserName : " + userName);

		// userName means userid
		MemberVO vo = memberMapper.read(userName);

		// 사용자 정보 존재하지 않을시
		if (vo == null) {
			throw new UsernameNotFoundException("User not found with username: " + userName);
		}

		AuthVO auth = new AuthVO();

		auth.setUserid(vo.getUserid());
		vo.getAuthList().forEach(authVO -> {
			auth.setAuth(authVO.getAuth());

		});

		List<AuthVO> authList = new ArrayList<>();
		authList.add(auth);

		vo.setAuthList(authList);

		log.warn(vo);

		return vo == null ? null : new CustomUser(vo);
	}

}
