package org.momento.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.momento.domain.MemberVO;
import org.momento.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@Log4j
public class MemberMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Test
	public void testRead() {
		MemberVO vo = mapper.read("admin5");
		log.info(vo);

		vo.getAuthList().forEach(authVO -> log.info(authVO));
	}
}
