package org.momento.service;

import java.util.List;

import org.momento.domain.BoardAttachVO;
import org.momento.domain.BoardVO;
import org.momento.domain.Criteria;

public interface BoardService {

	public void register(BoardVO board);

	public BoardVO get(Long bno);

	public boolean modify(BoardVO board);

	public boolean remove(Long bno);
	
	public boolean removeMulti(Long[] bnos, String del_res);

	public List<BoardVO> getList(Criteria cri);
	
	public List<BoardVO> getDeletedList(Criteria cri);
	
	public List<BoardVO> getFixedPosts();
	
	public List<BoardVO> getHotPosts();

	public int getTotal(Criteria cri);
	
	public int getDeleted(Criteria cri);
	
	public BoardAttachVO getAttachVO(Long bno);

}
