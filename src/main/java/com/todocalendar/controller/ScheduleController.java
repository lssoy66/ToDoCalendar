package com.todocalendar.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.todocalendar.model.ScheduleVO;
import com.todocalendar.service.CategoryService;
import com.todocalendar.service.MemberService;
import com.todocalendar.service.ScheduleService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/pages/*")
@Controller
@AllArgsConstructor
public class ScheduleController {

	MemberService memberService;
	ScheduleService scheduleService;
	CategoryService categoryService;

	/*
	@PostMapping("/testScheduleMonth")
	public List<ScheduleVO> selectScheduleList(ScheduleVO schedule) {
		log.info("Service :: selectMemberList...................");
		return scheduleService.selectScheduleListByMonth(schedule);
	}
	*/

	@PostMapping("/scheduleListByMonth")
	@ResponseBody
	public List<ScheduleVO> selectScheduleList(@RequestBody ScheduleVO schedule) {
		log.info("parameter month :: " + schedule.getMonth());
//		ScheduleVO schedule = new ScheduleVO();
//		schedule.setMonth(month);
		return scheduleService.selectScheduleListByMonth(schedule);
	}

	/*
	@PostMapping("/addSchedule")
	public String addSchedule(ScheduleVO schedule, RedirectAttributes rttr) {
		log.info("addSchedule.............. :: " + schedule);
		scheduleService.insertSchedule(schedule);
		rttr.addFlashAttribute("result", schedule.getPlan_date());
		return "redirect:../home";
	}
	*/

	@RequestMapping(value = "/addSchedule", method = RequestMethod.POST)
	public String addSchedule(ScheduleVO schedule) {
		log.info("addSchedule.............. :: " + schedule);
		try {
			scheduleService.insertSchedule(schedule);
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}

		return "redirect:../home";
	}


}
