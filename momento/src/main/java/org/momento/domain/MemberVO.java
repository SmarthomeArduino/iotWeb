package org.momento.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Data;


@Data
public class MemberVO implements Serializable{

	private static final long serialVersionUID = 1L;
	private transient SomeField field;

	private String userid;
	private String userName;
	private String userpw;
	private String addr;
	private int question_code;
	private String question_answer;
	private String phone;
	private List<AuthVO> authList;

}
