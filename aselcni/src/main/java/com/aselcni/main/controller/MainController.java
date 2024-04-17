package com.aselcni.main.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.main.model.MenuMst;
import com.aselcni.main.model.UserMst;
import com.aselcni.main.service.MainService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestParam;


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
				session.setAttribute("user_id", resultUser.getUser_id());
				session.setAttribute("user_pw", user.getUser_pw());
				session.setAttribute("user_nm", resultUser.getUser_nm());
				session.setAttribute("user_comm_code", resultUser.getUser_comm_code());
				session.setAttribute("comm_content", resultUser.getComm_content());
				List<List<MenuMst>> menuListGroupByMenu = mainService.menuListGroupByMenu(resultUser.getUser_comm_code());
				session.setAttribute("menuListGroupByMenu", menuListGroupByMenu);
				result = "성공";
			}
		}
		
		return result;
	}
	
	@GetMapping("/userLogout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	@GetMapping("/main")
	public String main(HttpSession session) {
		
		String resultPage = "redirect:/";
		
		if(session.getAttribute("user_id") != null) {
			resultPage = "main";
		}
		
		return resultPage;
	}


	
	public boolean authorityChk(HttpSession session ,String url){
		List<List<MenuMst>> menuListGroupByMenu = (List<List<MenuMst>>)session.getAttribute("menuListGroupByMenu");
		List<MenuMst> menus = menuListGroupByMenu.stream().flatMap(List<MenuMst>::stream).collect(Collectors.toList());
		
		if(menus.size()>0) {
			for(MenuMst menu : menus) {
				if("initem".equals(menu.getUrl()))
						return true;
			}
			
		}
		return false;
	}
	
}
