package com.todocalendar.mapper;

import java.util.List;

import com.todocalendar.model.MemberVO;

public interface MemberMapper {
	
	public void insertMember(MemberVO member); //회원가입
	public MemberVO readById(String id); //회원정보 가져오기
	public MemberVO loginCheck(MemberVO member); //로그인
	public List<MemberVO> selectMemberList(MemberVO member);
	
}