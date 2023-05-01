package com.todocalendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/pages")
@Controller
public class TestController {
	
	@GetMapping("/login")
	public void loginPage() {
	}
	
	@GetMapping("/sign_up")
	public void signUpPage() {
		
	}

}
