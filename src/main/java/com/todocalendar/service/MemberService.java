package com.todocalendar.service;

import java.util.List;

import com.todocalendar.domain.MemberVO;

public interface MemberService {

	public List<MemberVO> selectMemberList(MemberVO member);

}
