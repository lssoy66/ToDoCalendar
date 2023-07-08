package com.todocalendar.mapper;

import java.util.List;

import com.todocalendar.model.ScheduleVO;

public interface ScheduleMapper {

	/**
	 * 스케줄(일정) 저장
	 */
	public void insertSchedule(ScheduleVO schedule);

	/**
	 * 스케줄(일정) 목록
	 */
	public List<ScheduleVO> selectScheduleList(ScheduleVO schedule);

	/**
	 * 스케줄(일정) 목록 - 해당하는 달의 목록 가져오기
	 */
	public List<ScheduleVO> selectScheduleListByMonth(ScheduleVO schedule);

}