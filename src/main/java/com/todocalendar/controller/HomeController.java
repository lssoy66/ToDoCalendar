package com.todocalendar.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.todocalendar.model.CategoryVO;
import com.todocalendar.model.CountVO;
import com.todocalendar.model.DdayVO;
import com.todocalendar.model.MemberVO;
import com.todocalendar.model.ScheduleVO;
import com.todocalendar.service.CategoryServiceImpl;
import com.todocalendar.service.DdayServiceImpl;
import com.todocalendar.service.MemberServiceImpl;
import com.todocalendar.service.ScheduleServiceImpl;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
@AllArgsConstructor
public class HomeController {

	@Autowired
	MemberServiceImpl memberService;

	@Autowired
	CategoryServiceImpl categoryService;

	@Autowired
	ScheduleServiceImpl scheduleService;

	@Autowired
	DdayServiceImpl ddayService;

	@GetMapping("/home")
	public void mainPage(Model model, HttpServletRequest request, HttpSession session) {
		log.info("main page.........");

		MemberVO member = (MemberVO)session.getAttribute("member");

		List<CategoryVO> categoryList = categoryService.selectCategoryList(member.getMember_no());
		List<ScheduleVO> scheduleList = scheduleService.selectScheduleListAll(member.getMember_no());

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("scheduleList", scheduleList);
		
		
		List<DdayVO> ddayList = ddayService.selectDdayList(member.getMember_no());
		log.info("member_no : " + member.getMember_no() + ", ddayList : " + ddayList);
		
		model.addAttribute("ddayList", ddayList);
		
		CountVO scheduleCount = scheduleService.selectScheduleListByCount(member.getMember_no());
		log.info("count : " + scheduleCount);
		model.addAttribute("y_count", scheduleCount.getY_count());
		model.addAttribute("n_count", scheduleCount.getN_count());
		model.addAttribute("all_count", scheduleCount.getAll_count());
		
	}

	//Complete Ajax
	@PostMapping("/ChangeComplete")
	@ResponseBody
	//public ResponseEntity<List<ScheduleVO>> changeComplete(Model model, String complete, int schedule_no, HttpSession session) {
	public ResponseEntity<Map<String, Object>> changeComplete(Model model, String complete, int schedule_no, HttpSession session) {
		log.info("ChangeComplete.........");

		log.info("complete : " + complete);

		MemberVO member = (MemberVO)session.getAttribute("member");
		int member_no = member.getMember_no();
		log.info("member_no : " + member_no + ", schedule_no : " + schedule_no);

		scheduleService.changeComplete(member_no, complete, schedule_no);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("scheduleAll", scheduleService.selectScheduleListAll(member_no));
		result.put("scheduleCount", scheduleService.selectScheduleListByCount(member_no));

		return new ResponseEntity<>(result, HttpStatus.OK);
	}

}
