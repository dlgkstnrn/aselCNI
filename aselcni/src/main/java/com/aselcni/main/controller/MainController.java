package com.aselcni.main.controller;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.main.model.UserMst;
import com.aselcni.main.service.MainService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	
	private final MainService mainService;
	private final BCryptPasswordEncoder bCryptPasswordEncoder; 
	
	@GetMapping("/")
	public String login() {
		return "kph/loginForm";
	}
	
	@GetMapping("/loginChk")
	@ResponseBody
	public String loginChk(UserMst user, HttpSession session) {
		System.out.println("MainController loginChk start...");
		String result = "실패";
		
		UserMst resultUser = mainService.getUser(user);
		
		if(resultUser != null) {
			if(bCryptPasswordEncoder.matches(user.getUser_pw(), resultUser.getUser_pw())) {
				System.out.println(resultUser);
				session.setAttribute("user_id", resultUser.getUser_id());
				session.setAttribute("user_nm", resultUser.getUser_nm());
				session.setAttribute("user_comm_code", resultUser.getUser_comm_code());
				result = "성공";
			}
		}
		
		return result;
	}
	
	@GetMapping("/main")
	public String main(HttpSession session) {
		return "main";
	}
	
}
