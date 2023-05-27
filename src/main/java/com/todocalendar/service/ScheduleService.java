package com.todocalendar.service;

import java.util.List;

import com.todocalendar.model.CategoryVO;
import com.todocalendar.model.PaletteVO;
import com.todocalendar.model.RepeatVO;
import com.todocalendar.model.ScheduleVO;

public interface ScheduleService {

	/**
	 * 스케줄(일정) 저장
	 */
	public void insertSchedule(ScheduleVO schedule);

	/**
	 * 스케줄(일정) 목록
	 */
	public List<ScheduleVO> selectScheduleList(ScheduleVO schedule);

}