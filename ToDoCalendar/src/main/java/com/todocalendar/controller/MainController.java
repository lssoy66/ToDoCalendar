package com.todocalendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/")
@AllArgsConstructor
public class MainController {
	
	// http://localhost/todocalendar.com :: 메인 페이지로 이동
	@RequestMapping("todocalendar.com")
	public String mainPage() {
		return "main";
	}
	
}
