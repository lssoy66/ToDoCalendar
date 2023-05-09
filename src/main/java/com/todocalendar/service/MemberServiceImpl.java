package com.todocalendar.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todocalendar.mapper.MemberMapper;
import com.todocalendar.model.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public void insertMember(MemberVO member) {
		log.info("insertMember.........");
		memberMapper.insertMember(member);
	}
	
	@Override
	public MemberVO readById(String id) {
		log.info("readById........." + id);
		return memberMapper.readById(id);
	}
	
	@Override
	public MemberVO loginCheck(MemberVO member) {
		log.info("loginCheck........." + member);
		return memberMapper.loginCheck(member);
	}

}
