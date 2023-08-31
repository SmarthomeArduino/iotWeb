package org.momento.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private Date regDate;
	private Date updateDate;
	private Long referrals;
	private Long views;
	private char fixed;
	private char deleted;
	private Date delDate;
	
	private BoardAttachVO attachVO;
	
}