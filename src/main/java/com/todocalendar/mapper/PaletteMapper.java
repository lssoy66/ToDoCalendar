package com.todocalendar.mapper;

import java.util.List;

import com.todocalendar.model.MemberVO;
import com.todocalendar.model.PaletteVO;

public interface PaletteMapper {

	/*
	 * 팔레트 저장
	 */
	//public void insertPalette(PaletteVO palette);

	/**
	 * 팔레트 목록
	 */
	public List<MemberVO> selectMemberList(PaletteVO palette);

}