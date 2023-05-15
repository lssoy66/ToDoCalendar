package com.todocalendar.persistence;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.todocalendar.domain.TestVO;
import com.todocalendar.mapper.TestMapper;
import com.todocalendar.model.MemberVO;
import com.todocalendar.service.MemberService;
import com.todocalendar.service.TestMapperService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTest {

	@Setter(onMethod_ = @Autowired)
	private DataSource dataSource; 		// HikariDataSource는 DataSource를 구현

	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;

	@Test
	public void testMemberSelect() {
		MemberVO member = new MemberVO();

//		member.setMemberNo(1);		// 카멜 표기법 사용 시(파라미터는 정상 인식함)
		member.setMember_no(1);

		List<MemberVO> memberList = memberService.selectMemberList(member);

		if(memberList != null) {
			log.info("..................................................jUnit Test :: Member Select Success!!");
		}

	}

}
