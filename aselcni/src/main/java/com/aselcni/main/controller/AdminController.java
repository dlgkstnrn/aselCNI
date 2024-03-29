package com.aselcni.main.controller;

import java.util.List;

import org.springframework.stereotype.Controller;

import com.aselcni.main.model.Common;
import com.aselcni.main.model.UserMst;
import com.aselcni.main.service.AdminService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
@RequiredArgsConstructor
public class AdminController {

	private final AdminService adminService;
	
	@GetMapping("/userManagement")
	public String userManagement(HttpSession session) {
		System.out.println("AdminController userManagement start...");
		
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(session.getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)session.getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10010) {
			resultPage = "kph/userManagement"; 
		}
		
		return resultPage;
	}
	
	@GetMapping("/userAddForm")
	public String userAddForm(HttpServletRequest request) {
		System.out.println("AdminController userAddForm start...");
		
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(request.getSession().getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)request.getSession().getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10010) {
			resultPage = "kph/userAddForm"; 
			List<Common> authorityList = adminService.getAuthorityList();
			request.setAttribute("authorityList", authorityList);
		}
		
		return resultPage;
	}
	
	@PostMapping("/userAdd")
	public String userAdd(UserMst user, HttpServletRequest request) {
		
		System.out.println("AdminController userAdd start...");
		
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(request.getSession().getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)request.getSession().getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10010) {
			int result = adminService.userAdd(user);
			if(result == 1) {
				resultPage = "kph/userManagement";
			}
		}
		
		return resultPage;
	}
	
}
