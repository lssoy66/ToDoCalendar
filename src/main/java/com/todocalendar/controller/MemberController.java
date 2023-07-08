package com.todocalendar.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.todocalendar.mapper.MemberMapper;
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
	@RequestMapping(value = "/logout", method = RequestMethod.GET, produces = "application/text; charset = UTF-8")
	public String logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		log.info("logout.........");

		request.setAttribute("msg", "로그아웃 되셨습니다.");
		request.setAttribute("url", "./login");

		return "alert";
	}

	//회원가입 페이지 이동
	@GetMapping("/sign_up")
	public void signUpPage() {
		log.info("sign up.........");
	}

	//회원가입
	@PostMapping("/signUpMember")
	public String signUp(MemberVO member) {
		memberService.insertMember(member);
		log.info("회원가입 성공 id : " + member.getId());
		return "redirect:/pages/sign_up_success/" + member.getId();
	}

	//회원가입 성공 후 성공 페이지 이동
	@RequestMapping("/sign_up_success/{id}")
	public String signUpSuccess(@PathVariable String id, Model model) {
		MemberVO member = memberService.readById(id);
		log.info("회원 정보 : " + member);
		model.addAttribute("member", member);
		return "/pages/sign_up_success";
	}

	//마이페이지
	@RequestMapping("/mypage")
	public void mypage() {
		log.info("mypage.........");
	}

	//자동미루기 Ajax
	@PostMapping("/ChangeDelayAuto")
	@ResponseBody
	public ResponseEntity<MemberVO> onDelayAuto(String delay_auto, HttpSession session) {
		log.info("delay_auto : " + delay_auto);

		MemberVO member = (MemberVO)session.getAttribute("member");
		String id = member.getId();
		log.info("member id : " + id);
		memberService.changeDelayAuto(id, delay_auto);

		return new ResponseEntity<>(memberService.readById(id), HttpStatus.OK);
	}

	//비밀번호 변경 1 페이지 진입
	@RequestMapping(value = "/password1", method = RequestMethod.GET)
	public String updatePassword1() {
		log.info("password check 1.........");
		return "/pages/password1";
	}

	//비밀번호 변경 2 기존 비밀번호 입력
	@PostMapping("/password2")
	public String updatePassword2(MemberVO member) {
		log.info("password check 2........." + member);
		//id에 해당하는 password가 일치하면 memberInfo에 담긴다.
		MemberVO memberInfo = memberService.memberCheck(member);
		log.info(memberInfo);
		if(memberInfo != null) {
			return "pages/password3";
		}
		return "redirect:/pages/password6";
	}

	//비밀번호 변경 3 비밀번호가 일치하지 않을때의 alert 페이지로 이동
	@PostMapping("/password3")
	public String updatePassword3() {
		log.info("password check 3.........");
		return "redirect:/pages/password6";
	}

	//비밀번호 변경 4 비밀번호가 일치할때의 alert 페이지로 이동
	@PostMapping("/password4")
	public String updatePassword4(MemberVO member) {
		log.info("password check 4.........");

		memberService.updatePassword(member);

		return "redirect:/pages/password5";
	}

	//비밀번호 변경 5
	@RequestMapping(value = "/password5", method = RequestMethod.GET, produces = "application/text; charset = UTF-8")
	public String updatePassword5(HttpServletRequest request) throws Exception {
		log.info("password check 5.........");

		request.setAttribute("msg", "비밀번호가 변경되었습니다.");
		request.setAttribute("url", "./mypage");

		return "alert";
	}

	//비밀번호 변경 6 3에서 비밀번호가 일치하지 않을시 alert페이지에서 alert를 띄운 후 다시 비밀번호 입력 페이지로 이동
	@RequestMapping(value = "/password6", method = RequestMethod.GET, produces = "application/text; charset = UTF-8")
	public String updatePassword6(HttpServletRequest request) throws Exception {
		log.info("password check 6.........");

		request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
		request.setAttribute("url", "./password1");

		return "alert";
	}


}
