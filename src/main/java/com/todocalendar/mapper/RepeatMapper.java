package com.todocalendar.mapper;

import java.util.List;

import com.todocalendar.model.RepeatVO;

public interface RepeatMapper {

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