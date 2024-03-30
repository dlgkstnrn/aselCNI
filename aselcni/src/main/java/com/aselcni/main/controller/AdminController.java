package com.aselcni.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.kph.service.KphPaging;
import com.aselcni.main.model.Common;
import com.aselcni.main.model.UserMst;
import com.aselcni.main.service.AdminService;
import com.aselcni.main.service.MainService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequiredArgsConstructor
public class AdminController {

	private final AdminService adminService;
	private final MainService mainService;
	
	@GetMapping("/userManagement")
	public String userManagement(UserMst user, HttpSession session, Model model) {
		System.out.println("AdminController userManagement start...");
		
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(session.getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)session.getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10010) {
			int totaUserCount = adminService.totalUserCountByKeyword(user);
			KphPaging paging = new KphPaging(totaUserCount, user.getCurrentPage());
			
			user.setStart(paging.getStart());
			user.setEnd(paging.getEnd());
			
			List<UserMst> userList = adminService.userListByKeyword(user);
			model.addAttribute("userList", userList);
			model.addAttribute("paging", paging);
			resultPage = "kph/userManagement"; 
		}
		
		return resultPage;
	}
	
	@GetMapping("/userSearch")
	@ResponseBody
	public Map<String, Object> userSearch(UserMst user) {
		System.out.println("AdminController userSearch start...");
		
		System.out.println(user);
		
		int totaUserCount = adminService.totalUserCountByKeyword(user);
		KphPaging paging = new KphPaging(totaUserCount, user.getCurrentPage());
		
		user.setStart(paging.getStart());
		user.setEnd(paging.getEnd());
		
		List<UserMst> userList = adminService.userListByKeyword(user);
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("paging", paging);
		response.put("userList", userList);
		
		return response;
	}
	
	@GetMapping("/userDuplicationChk")
	@ResponseBody
	public String userDuplicationChk(UserMst user) {
		String result = "성공";
		int isUserExist = adminService.isUserExist(user);
		if(isUserExist > 0) {
			result = "중복";
		}
		return result;
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
				resultPage = "redirect:/userManagement";
			}
		}
		
		return resultPage;
	}
	
	@PostMapping("/userDelete")
	@ResponseBody
	public void userDelete(UserMst user) {
		System.out.println("AdminController userDelete start...");
		adminService.userDelete(user);
	}
	
	@GetMapping("/userUpdateForm")
	public String userUpdateForm(UserMst user, HttpServletRequest request, Model model) {
		
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(request.getSession().getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)request.getSession().getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10010) {
			UserMst resultUser = mainService.getUser(user);
			resultUser.setUser_pw((String)request.getSession().getAttribute("user_pw"));
			List<Common> authorityList = adminService.getAuthorityList();
			model.addAttribute("user", resultUser);
			model.addAttribute("authorityList", authorityList);
			resultPage = "kph/userUpdateForm";
		}
		
		return resultPage;
	}
	
	@PostMapping("/userUpdate")
	public String userUpdate(UserMst user, HttpServletRequest request, Model model) {
		
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(request.getSession().getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)request.getSession().getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10010) {
			adminService.userUpdate(user);
			resultPage = "redirect:/userManagement";
		}
		
		return resultPage;
	}
	
}
