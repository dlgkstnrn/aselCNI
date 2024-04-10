package com.aselcni.kph.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphOutItemItem;
import com.aselcni.kph.model.KphReturn;
import com.aselcni.kph.service.KphPaging;
import com.aselcni.kph.service.KphReturnService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;




@Controller
@RequiredArgsConstructor
public class KphReturnController {

	private final KphReturnService kphReturnService;
	
	@GetMapping("/return")
	public String returnForm(KphReturn kphReturn, HttpSession session, Model model) {
		System.out.println("KphReturnController returnForm start...");
		
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(session.getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)session.getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10030) {
			System.out.println(kphReturn);
//			int totalReturnCount = kphReturnService.totalReturnCount(kphReturn);
//			KphPaging paging = new KphPaging(totalReturnCount, kphReturn.getCurrentPage());
//			
//			kphReturn.setStart(paging.getStart());
//			kphReturn.setEnd(paging.getEnd());
//			
//			if(kphReturn.getStart_day() == null && kphReturn.getEnd_day() == null) {
//				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//				String today = LocalDate.now().format(formatter);
//				String oneMonthAgo = LocalDate.now().minusMonths(1).format(formatter); 
//				
//				kphReturn.setStart_day(oneMonthAgo);
//				kphReturn.setEnd_day(today);
//			}
//			
//			List<KphReturn> returnList = kphReturnService.returnList(kphReturn);
//			model.addAttribute("returnList", returnList);
//			model.addAttribute("paging", paging);
//			model.addAttribute("start_day", kphReturn.getStart_day());
//			model.addAttribute("end_day", kphReturn.getEnd_day());
//			model.addAttribute("return_no", kphReturn.getReturn_no());
//			model.addAttribute("outitem_no", kphReturn.getOutitem_no());
//			model.addAttribute("cust_nm", kphReturn.getCust_nm());
//			model.addAttribute("item_nm", kphReturn.getItem_nm());
//			model.addAttribute("user_nm", kphReturn.getUser_nm());
			resultPage = "kph/return"; 
		}
		
		return resultPage;
	}
	
	@GetMapping("/returnSearch")
	@ResponseBody
	public Map<String, Object> returnSearch(KphReturn kphReturn) {
		System.out.println("KphReturnController returnSearch start...");
		
		int totalReturnCount = kphReturnService.totalReturnCount(kphReturn);
		KphPaging paging = new KphPaging(totalReturnCount, kphReturn.getCurrentPage());
		
		kphReturn.setStart(paging.getStart());
		kphReturn.setEnd(paging.getEnd());
		
		if(kphReturn.getStart_day() == null && kphReturn.getEnd_day() == null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String today = LocalDate.now().format(formatter);
			String oneMonthAgo = LocalDate.now().minusMonths(1).format(formatter); 
			
			kphReturn.setStart_day(oneMonthAgo);
			kphReturn.setEnd_day(today);
		}
		
		List<KphReturn> returnList = kphReturnService.returnList(kphReturn);
		System.out.println(returnList);
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("paging", paging);
		response.put("returnList", returnList);
		return response;
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
	
	@GetMapping("/getReturn")
	@ResponseBody
	public KphReturn getReturn(KphReturn kphReturn) {
		System.out.println("KphReturnController getReturn start...");
		return kphReturnService.getReturn(kphReturn);
	}
	
	@PostMapping("/returnDelete")
	@ResponseBody
	public void returnDelete(KphReturn kphReturn) {
		System.out.println("KphReturnController returnDelete start...");
		kphReturnService.returnDelete(kphReturn);
	}
	
	@GetMapping("/returnUpdateForm")
	public String returnUpdateForm(KphReturn kphReturn, HttpSession session, Model model) {
		System.out.println("KphReturnController returnUpdateForm start...");
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(session.getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)session.getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10030) {
			KphReturn returnObj = kphReturnService.getReturn(kphReturn);
			model.addAttribute("returnObj", returnObj);
			model.addAttribute("url", "returnUpdateForm");
			resultPage = "kph/returnUpdateForm"; 
		}
		
		return resultPage;
	}
	
	@PostMapping("/returnUpdate")
	public String returnUpdate(KphReturn kphReturn, HttpSession session) {
		System.out.println("KphReturnController returnUpdate start...");
		int user_comm_code = 0;
		String resultPage = "redirect:/";
		
		if(session.getAttribute("user_comm_code") != null) {
			user_comm_code = (Integer)session.getAttribute("user_comm_code");
			resultPage = "redirect:/main";
		}
		
		if(user_comm_code == 10030) {
			System.out.println(kphReturn);
			kphReturn.setReturn_emp_id((String)session.getAttribute("user_id"));
			kphReturnService.returnUpdate(kphReturn);
			resultPage = "redirect:/return"; 
		}
		
		return resultPage;
	}
	
}