package org.momento.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userid;
	private String userName;
	private String userpw;
	private String addr;
	private int question_code;
	private String question_answer;
	private Date regDate;
	private Date updateDate;
	private String phone;
	private List<AuthVO> authList;

}
