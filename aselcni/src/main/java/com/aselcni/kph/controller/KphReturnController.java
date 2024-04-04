package com.aselcni.kph.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphOutItemItem;
import com.aselcni.kph.model.KphReturn;
import com.aselcni.kph.service.KphReturnService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class KphReturnController {

	private final KphReturnService kphReturnService;
	
	@GetMapping("/return")
	public String returnForm(HttpSession session) {
		System.out.println("KphReturnController returnForm start...");
		
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(session.getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)session.getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10030) {
			resultPage = "kph/return"; 
		}
		
		return resultPage;
	}
	
	@GetMapping("/returnAddForm")
	public String returnAddForm(HttpSession session, Model model) {
		System.out.println("KphReturnController returnAddForm start...");
		
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(session.getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)session.getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10030) {
			resultPage = "kph/returnAddForm"; 
		}
		
		return resultPage;
	}
	
	@GetMapping("/outItemList")
	@ResponseBody
	public List<KphOutItem> outItemList(KphOutItem kphOutItem) {
		System.out.println("KphReturnController outItemList start...");
		List<KphOutItem> outItemList = kphReturnService.outItemList(kphOutItem);
		return outItemList;
	}
	
	@GetMapping("/outItemItemList")
	@ResponseBody
	public List<KphOutItemItem> outItemItemList(KphOutItem outItem) {
		System.out.println("KphReturnController outItemItemList start...");
		List<KphOutItemItem> itemList = kphReturnService.outItemItemList(outItem);
		System.out.println(itemList);
		return itemList;
	}
	
	@PostMapping("/returnAdd")
	public String returnAdd(HttpSession session, KphReturn kphReturn) {
		System.out.println("KphReturnController returnAdd start...");
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(session.getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)session.getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10030) {
			kphReturn.setReturn_emp_id((String)session.getAttribute("user_id"));
			kphReturnService.returnAdd(kphReturn);
			resultPage = "redirect:/return"; 
		}
		
		return resultPage;
	}
	
}
