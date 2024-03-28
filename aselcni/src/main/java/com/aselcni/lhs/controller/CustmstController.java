package com.aselcni.lhs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.aselcni.lhs.model.CustMst;
import com.aselcni.lhs.service.CustMstService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CustmstController {
	
	private final CustMstService mstService;
	
	@GetMapping("custmstAddForm")
	public String custAddForm() {
		return "lhs/custmstaddForm";
	}
	
	@GetMapping("custmst")
	public String custmstList() {
		return "lhs/custmstList";
	}
	
	@PostMapping("custmstAdd")
	public String custAdd(CustMst custmst) {
		System.out.println("test : " + custmst);
		custmst.setEmp_id("admin");
		int todayCnt = mstService.selectCntTodayCust(custmst.getBiz_flag());
		String custCd = String.format("%04d", todayCnt);
		if(custmst.getBiz_flag() == 1) {
			custmst.setCust_cd("BUY"+custCd);
		}else {
			custmst.setCust_cd("SEL"+custCd);
		}
		int result = mstService.insertCust(custmst);
		return "redirect:/";
	}
	
}
