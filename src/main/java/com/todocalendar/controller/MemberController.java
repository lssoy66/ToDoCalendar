package com.todocalendar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	
	@Autowired
	JavaMailSenderImpl mailSender;

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
			request.setAttribute("msg", "로그인에 실패했습니다.");
			request.setAttribute("url", "./login");

			return "alert";
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
	
	//Id 중복 확인
	@PostMapping("/ConfirmId")
	@ResponseBody
	public ResponseEntity<Boolean> confirmId(String id) {
		log.info("ConfirmId.........");
		log.info("id : " + id);
		boolean result = true;
		
		if(id.trim().isEmpty()) {
			log.info("id : " + id);
			result = false;
		} else {
			if (memberService.selectId(id)) {
				result = false;
			} else {
				result = true;
			}
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//이메일 인증
	@PostMapping("/EmailAuth")
	@ResponseBody
	public int emailAuth(String email) {
		
		log.info("전달 받은 이메일 주소 : " + email);
		
		// 난수의 범위 111111 ~ 999999 (6자리 난수)
		Random random = new Random();
		int checkNum = random.nextInt(888888)+111111;
		
		//이메일 보낼 양식
		String setFrom = "12ecember_@naver.com"; //2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
		String toMail = email;
		String title = "ToDoCalender 인증 이메일 입니다.";
		String content = "인증 코드는 " + checkNum + " 입니다." +
						 "<br>" +
						 "해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";
		
		try {
			MimeMessage message = mailSender.createMimeMessage(); //Spring에서 제공하는 mail API
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		log.info("랜덤숫자 : " + checkNum);
		return checkNum;
	}

	//회원가입
	@PostMapping("/signUpMember")
	public String signUp(MemberVO member, HttpServletRequest request) {
		
//		if(hiddenValue.equals("false")) {
//			request.setAttribute("msg", "잘못된 정보를 입력했습니다.");
//			request.setAttribute("url", "./sign_up");
//			
//			return "alert";
//		} else {
//			memberService.insertMember(member);
//			log.info("회원가입 성공 id : " + member.getId());
//			return "redirect:/pages/sign_up_success/" + member.getId();
//		}
		
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
	
	//ID찾기 페이지 진입
	@GetMapping("/ForgetId")
	public String forgetId() {
		log.info("forget Id.........");
		return "/pages/forgetId";
	}
	
	//ID찾기 페이지 진입-2
	@PostMapping("/ForgetIdCheck")
	public String forgetIdCheck(Model model, String name, String email, HttpServletRequest request) {
		log.info("forget Id check.........");
		
		String id = memberService.findId(name, email);
		//Form으로부터 전달 받은 이름과 인증된 이메일이 일치하면 해당 사용자의 id를 반환해야한다.
		if(id != null) {
			model.addAttribute("id", id);
			model.addAttribute("name", name);
			return "/pages/findId";
		}
		request.setAttribute("msg", "존재하지 않는 계정 정보입니다.");
		request.setAttribute("url", "./ForgetId");
		
		return "alert";
	}
	
	//비밀번호 찾기 페이지 진입
	@GetMapping("/ForgetPassword")
	public String forgetPassword() {
		log.info("forget Password.........");
		return "/pages/forgetPassword";
	}
	
	//비밀번호 찾기 페이지 진입-2
	@PostMapping("/ForgetPwCheck")
	public String forgetPasswordCheck(Model model, String id, HttpServletRequest request) {
		log.info("forget Password check.........");
		
		String findAccount = memberService.findAccount(id);
		
		if(findAccount != null) {
			model.addAttribute("id", id);
			return "/pages/findPassword";
		}
		request.setAttribute("msg", "존재하지 않는 계정 정보입니다.");
		request.setAttribute("url", "./ForgetPassword");
		
		return "alert";
	}
	
	//비밀번호 찾기 페이지 진입-3
	@PostMapping("/SendTempPassword")
	public String sendTempPassword(Model model, String id, String name, String email, HttpServletRequest request) {
		log.info("forget Password check.........");

		char[] charSet = new char[] {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                '!', '@', '#', '$', '%', '^', '&' };
		
		StringBuffer sb = new StringBuffer();
		int tempPassword = 0;
		int len = charSet.length;
		SecureRandom random = new SecureRandom();
		
		for (int i=0; i<12; i++) {
			tempPassword = random.nextInt(len);
			sb.append(charSet[tempPassword]);
		}
		
		//이메일 보낼 양식
		String setFrom = "12ecember_@naver.com"; //2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
		String toMail = email;
		String title = "ToDoCalender 임시 비밀번호가 발급되었습니다.";
		String content = "임시 비밀번호는 " + sb.toString() + " 입니다." + 
		"<br>" + "임시 비밀번호로 로그인 후 반드시 비밀번호를 변경해주시기 바랍니다.";
				
		try {
			MimeMessage message = mailSender.createMimeMessage(); //Spring에서 제공하는 mail API
		    MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
		    helper.setFrom(setFrom);
		    helper.setTo(toMail);
		    helper.setSubject(title);
		    helper.setText(content, true);
		    mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		memberService.updateTempPassword(id, name, email, sb.toString());
		return "/pages/resultSendTempPassword";
	}
	
	@PostMapping("/resultSendTempPassword")
	public void resultSendTempPassword() {
		log.info("result temp password.........");
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
