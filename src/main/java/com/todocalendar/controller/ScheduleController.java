package com.todocalendar.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.todocalendar.model.ScheduleVO;
import com.todocalendar.service.CategoryService;
import com.todocalendar.service.MemberService;
import com.todocalendar.service.ScheduleService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/pages/*")
@Controller
public class ScheduleController {

	@Autowired
	MemberService memberService;

	@Autowired
	ScheduleService scheduleService;

	@Autowired
	CategoryService categoryService;

	/*
	@PostMapping("/testScheduleMonth")
	public List<ScheduleVO> selectScheduleList(ScheduleVO schedule) {
		log.info("Service :: selectMemberList...................");
		return scheduleService.selectScheduleListByMonth(schedule);
	}
	*/

	@PostMapping("/testScheduleMonth")
	@ResponseBody
	public List<ScheduleVO> selectScheduleList(@RequestBody ScheduleVO schedule) {
		log.info("Service :: selectMemberListTest!!!...................");
//		ScheduleVO schedule = scheduleList.get(0);
		log.info("parameter month :: " + schedule.getMonth());
		//ScheduleVO schedule = new ScheduleVO();
		//schedule.setMonth(month);
		return scheduleService.selectScheduleListByMonth(schedule);
	}

}
