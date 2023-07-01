package com.todocalendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todocalendar.mapper.ScheduleMapper;
import com.todocalendar.model.ScheduleVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleMapper scheduleMapper;

	@Override
	public void insertSchedule(ScheduleVO schedule) {
		log.info("insertSchedule.........");
		scheduleMapper.insertSchedule(schedule);
	}

	@Override
	public List<ScheduleVO> selectScheduleList(ScheduleVO schedule) {
		log.info("Service :: selectScheduleList...................");
		return scheduleMapper.selectScheduleList(schedule);
	}
	
	@Override
	public List<ScheduleVO> selectScheduleListAll(int member_no) {
		log.info("Service :: selectScheduleListAll..................");
		return scheduleMapper.selectScheduleListAll(member_no);
	}
	
	@Override
	public void changeComplete(int member_no, String complete, int schedule_no) {
		log.info("Service :: changeComplete...............");
		scheduleMapper.changeComplete(member_no, complete, schedule_no);
	}

}
