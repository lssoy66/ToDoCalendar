package com.todocalendar.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.todocalendar.model.MemberVO;

public interface MemberMapper {
	
	public void insertMember(MemberVO member); 		//회원가입
	public MemberVO readById(String id); 			//id로 회원정보 가져오기
	public MemberVO loginCheck(MemberVO member); 	//로그인
	
	public void updatePassword(MemberVO member); 		//비밀번호 수정
	public void withdrawMember(String id); 			//회원 탈퇴
	public MemberVO memberCheck(MemberVO member);	//회원정보 확인
	
	public void changeDelayAuto(@Param("id") String id, @Param("delay_auto") String delay_auto); 	//자동미루기 on/off
	
	public List<MemberVO> selectMemberList(MemberVO member);
	
}