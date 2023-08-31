package org.momento.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.momento.domain.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {	
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testDeletedList() {
		mapper.getDeletedList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("TestTitle3");
		board.setContent("TestContent3");
		board.setReferrals(3L);
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test
	public void testRead() {
		mapper.read(1L);
		mapper.views(1L);
	}
	
	@Test
	public void testDelete() {
		mapper.delete(3L);
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = mapper.read(2L);
		board.setContent("UpdateTest1");
		
		mapper.update(board);
	}
}
