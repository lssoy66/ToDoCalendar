package com.todocalendar.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todocalendar.mapper.ScheduleMapper;
import com.todocalendar.model.CountVO;
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
	public int insertSchedule(ScheduleVO schedule) throws Exception {
		log.info("insertSchedule.........");

		String dateStr = schedule.getPlan_date2();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date strToDate = null;
		strToDate = formatter.parse(dateStr);
		schedule.setPlan_date(strToDate);

		int result = scheduleMapper.insertSchedule(schedule);
		return result;
	}

	@Override
	public int updateSchedule(ScheduleVO schedule) throws Exception {
		log.info("updateSchedule.........");

		String dateStr = schedule.getPlan_date2();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date strToDate = null;
		strToDate = formatter.parse(dateStr);
		schedule.setPlan_date(strToDate);

		int result = scheduleMapper.updateSchedule(schedule);
		return result;
	}

	@Override
	public int deleteSchedule(ScheduleVO schedule) throws Exception {
		log.info("deleteSchedule.........");

		String dateStr = schedule.getPlan_date2();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date strToDate = null;
		strToDate = formatter.parse(dateStr);
		schedule.setPlan_date(strToDate);

		int result = scheduleMapper.deleteSchedule(schedule);
		return result;
	}

	@Override
	public List<ScheduleVO> selectScheduleList(ScheduleVO schedule) {
		log.info("Service :: selectScheduleList...................");
		return scheduleMapper.selectScheduleList(schedule);
	}

	@Override
	public List<ScheduleVO> selectScheduleListByMonth(ScheduleVO schedule) {
		log.info("Service :: selectScheduleListByMonth...................");
		return scheduleMapper.selectScheduleListByMonth(schedule);
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

	@Override
	public CountVO selectScheduleListByCount(int member_no) {
		log.info("Service :: selectScheduleListByCount..................");
		return scheduleMapper.selectScheduleListByCount(member_no);
	}

}
