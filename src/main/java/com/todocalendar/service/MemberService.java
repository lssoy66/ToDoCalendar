
package com.todocalendar.service;

import com.todocalendar.model.MemberVO;

public interface MemberService {
	
	public void insertMember(MemberVO member); //회원가입
	public MemberVO readById(String id); //회원정보 가져오기
	public MemberVO loginCheck(MemberVO member); //로그인
  public List<MemberVO> selectMemberList(MemberVO member);

}