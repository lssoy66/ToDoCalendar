package com.todocalendar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.todocalendar.domain.MemberVO;
import com.todocalendar.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	private MemberMapper memberMapper;

	@Override
	public List<MemberVO> selectMemberList(MemberVO member) {
		log.info("Service :: selectMemberList...................");
		return memberMapper.selectMemberList(member);
	}

}
