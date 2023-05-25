package com.todocalendar.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todocalendar.model.MemberVO;
import com.todocalendar.service.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/pages/*")
@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	
	//로그인 페이지 이동
	@GetMapping("/login")
	public void loginPage() {
		log.info("login page.........");
	}
	
	//로그인 체크
	@PostMapping("/loginCheck")
	public String loginCheck(MemberVO member, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberVO res = memberService.loginCheck(member);
		
		if(res != null) {
			log.info("로그인 성공");
			session.setAttribute("member", res);
			return "redirect:../home";
		} else {
			log.info("로그인 실패");
			return "redirect:/pages/login";
		}
		
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		log.info("logout.........");
		HttpSession session = request.getSession();
		session.invalidate();
		return "/login";
	}
	
	//회원가입
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
