package com.todocalendar.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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
	
	public List<ScheduleVO> selectScheduleListAll(int member_no);
	
	public void changeComplete(@Param("member_no") int member_no, @Param("complete") String complete, @Param("schedule_no") int schedule_no); //체크박스 on/off

}