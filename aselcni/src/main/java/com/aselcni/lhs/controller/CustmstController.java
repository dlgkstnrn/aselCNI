package com.aselcni.lhs.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.lhs.model.CustMst;
import com.aselcni.lhs.service.CustMstService;
import com.aselcni.lhs.service.LhsPaging;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CustmstController {
	
	private final CustMstService mstService;
	
	@GetMapping("custmstAddForm")
	public String custAddForm(CustMst custMst,Model model) {
		model.addAttribute("biz_flag", custMst.getBiz_flag());
		return "lhs/custmstaddForm";
	}
	
	@GetMapping("custmst")
	public String custmstList(CustMst custMst,Model model) {
		if(custMst.getBiz_flag() == 0) {
			custMst.setBiz_flag(2);
		}
		int cnt = mstService.selectCntCust(custMst);
		LhsPaging page = new LhsPaging(cnt, custMst.getCurrentPage());
		custMst.setStart(page.getStart());
		custMst.setEnd(page.getEnd());
		List<CustMst> custList = mstService.selectListCust(custMst);
		model.addAttribute("custMst", custMst);
		model.addAttribute("custList", custList);
		model.addAttribute("page", page);
		return "lhs/custmstList";
	}
	
	@PostMapping("custmstAdd")
	public String custAdd(CustMst custmst,HttpServletRequest request) {
		custmst.setEmp_id(request.getSession().getAttribute("user_id").toString());
		int cnt = mstService.selectCntCustAll(custmst.getBiz_flag());
		System.out.println("test : " + cnt);
		String custCd = String.format("%04d", ++cnt);
		if(custmst.getBiz_flag() == 1) {
			custmst.setCust_cd("BUY"+custCd);
		}else {
			custmst.setCust_cd("SEL"+custCd);
		}
		int result = mstService.insertCust(custmst);
		return "redirect:/custmst";
	}
	
	@PostMapping("custmstSelectOne")
	@ResponseBody
	public CustMst custSelectOne(CustMst custmst) {
		CustMst custSelectOne = mstService.selectOneCust(custmst);
		return custSelectOne;
	}
	
	@GetMapping("custmstDelete")
	public String custDelete(CustMst custMst) {
		int result = mstService.deleteOneCust(custMst);
		return "redirect:/custmst";
	}
	
	@PostMapping("custmstUpdate")
	public String custUpdate(CustMst custMst) {
		int result = mstService.updateOneCust(custMst);
		return "redirect:/custmst";
	}
	
}
