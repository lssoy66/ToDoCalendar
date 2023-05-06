package com.todocalendar.mapper;

import java.util.List;

import com.todocalendar.domain.MemberVO;

public interface MemberMapper {

	public List<MemberVO> selectMemberList(MemberVO member);

}
