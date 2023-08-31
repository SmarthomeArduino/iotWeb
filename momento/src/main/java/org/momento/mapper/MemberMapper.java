package org.momento.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.momento.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);

	public void insert(MemberVO member);

	public void authinsert(String userid);

	public void updatePw(@Param("userid") String userid, @Param("userPw") String userPw);

	public List<String> findId(String userName, String phone);
	
	public void deleteUser(String userid);

}
