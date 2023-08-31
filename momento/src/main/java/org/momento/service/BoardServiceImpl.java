package org.momento.service;

import java.util.List;

import org.momento.domain.BoardAttachVO;
import org.momento.domain.BoardVO;
import org.momento.domain.Criteria;
import org.momento.mapper.BoardAttachMapper;
import org.momento.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	@Transactional
	@Override
	public void register(BoardVO board) {

		log.info("register......" + board);
		mapper.insertSelectKey(board);
		
		if (board.getAttachVO() == null) {
			return;
		}
		
		BoardAttachVO attach = board.getAttachVO();
		log.info(attach);
		attach.setBno(board.getBno());
		attachMapper.insert(attach);

	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get......" + bno);
		mapper.views(bno);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {

		attachMapper.delete(board.getBno());
		boolean modifyResult = mapper.update(board) == 1;
		BoardAttachVO attach = board.getAttachVO();
		
		if (modifyResult && board.getAttachVO() != null) {
			attach = board.getAttachVO();
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		}

		return modifyResult;
		
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		
		attachMapper.delete(bno);
		return mapper.delete(bno) == 1;
		
	}
	
	@Override
	public boolean removeMulti(Long[] bnos, String del_res) {
		
		boolean removedAll = false;
		
		if (del_res.equals("delete")) {
			for (int bno=0 ; bno<bnos.length ; bno++) {
				removedAll = mapper.delete(bnos[bno]) == 1;
			}
		} else {
			for (int bno=0 ; bno<bnos.length ; bno++) {
				removedAll = mapper.restore(bnos[bno]) == 1;
			}
		}
		
		return removedAll;
		
	}


	@Override
	public List<BoardVO> getList(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
		
	}
	
	@Override
	public List<BoardVO> getDeletedList(Criteria cri) {
		
		return mapper.getDeletedListWithPaging(cri);
		
	}
	
	@Override
	public List<BoardVO> getFixedPosts() {
		
		return mapper.getFixedList();
		
	}
	
	@Override
	public List<BoardVO> getHotPosts() {
		
		return mapper.getHotList();
		
	}

	@Override
	public int getTotal(Criteria cri) {

		return mapper.getTotalCount(cri);
		
	}
	
	@Override
	public int getDeleted(Criteria cri) {
		
		return mapper.getDeletedCount(cri);
		
	}
	
	@Override
	public BoardAttachVO getAttachVO(Long bno) {

		return attachMapper.findByBno(bno);
		
	}

}
