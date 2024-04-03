package com.aselcni.kph.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import com.aselcni.kph.model.KphCustMst;
import com.aselcni.kph.model.KphItemMst;
import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphTypeBig;
import com.aselcni.kph.model.KphTypeMid;
import com.aselcni.kph.model.KphTypeSml;
import com.aselcni.kph.service.KphPaging;
import com.aselcni.kph.service.KphReturnService;
import com.aselcni.main.model.UserMst;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


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
	public List<KphOutItem> outItemList(KphOutItem kphOutItem) {
		System.out.println("KphReturnController outItemList start...");
		List<KphOutItem> outItemList = kphReturnService.outItemList(kphOutItem);
		return outItemList;
	}
	
	
}