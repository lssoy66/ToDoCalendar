package com.todocalendar.service;

import java.util.List;

import com.todocalendar.model.CategoryVO;
import com.todocalendar.model.PaletteVO;

public interface PaletteService {

	/**
	 * 팔레트 목록
	 */
	public List<PaletteVO> selectPaletteList(PaletteVO palette);
	
	/**
	 * 전체 팔레트 목록
	 */
	public List<PaletteVO> selectPaletteListAll();

}