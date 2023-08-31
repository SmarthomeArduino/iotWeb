package org.momento.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.momento.domain.BoardVO;
import org.momento.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getList();
	
	public List<BoardVO> getDeletedList();

	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public List<BoardVO> getDeletedListWithPaging(Criteria cri);
	
	public List<BoardVO> getFixedList();
	
	public List<BoardVO> getHotList();

	public void insert(BoardVO board);

	public Integer insertSelectKey(BoardVO board);

	public BoardVO read(Long bno);
	
	public void views(Long bno);

	public int delete(Long bno);
	
	public int restore(Long bno);

	public int update(BoardVO board);

	public int getTotalCount(Criteria cri);
	
	public int getDeletedCount(Criteria cri);
	
}
