package com.todocalendar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todocalendar.model.MemberVO;
import com.todocalendar.service.MemberService;
import com.todocalendar.service.MemberServiceImpl;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/pages")
@Controller
public class MemberController {

	@Autowired
	MemberServiceImpl memberService;
	
	@GetMapping("/login")
	public void loginPage() {
	}
	
	@GetMapping("/sign_up")
	public void signUpPage() {
		log.info("sign up.........");
	}
	
	//회원가입 성공 후 성공 페이지 이동
	@RequestMapping(value = "sign_up_success/{id}")
	public String signUpSuccess(String id, Model model) {
		MemberVO member = memberService.readById(id);
		model.addAttribute("member", member);
		return "/sign_up_success";
	}
	
}
