package com.todocalendar.service;

import java.util.List;

import com.todocalendar.model.CategoryVO;
import com.todocalendar.model.PaletteVO;
import com.todocalendar.model.RepeatVO;

public interface RepeatService {

	/**
	 * 반복설정 저장
	 */
	public void insertRepeat(RepeatVO repeat);

	/**
	 * 반복설정 목록
	 */
	public List<RepeatVO> selectRepeatList(RepeatVO repeat);
	
	public List<RepeatVO> selectDdayList(int member_no);

}