package org.momento.mapper;

import org.momento.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);
	public void insert(MemberVO member);
}
