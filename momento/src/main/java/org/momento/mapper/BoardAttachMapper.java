package org.momento.mapper;

import java.util.List;

import org.momento.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	
	public void delete(Long Bno);
	
	public BoardAttachVO findByBno(Long bno);
	
	// 잘못 업로드된 파일 삭제
	public List<BoardAttachVO> getOldFiles();
	
}
