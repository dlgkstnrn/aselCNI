package com.aselcni.lhs.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.lhs.model.CustMst;
import com.aselcni.lhs.model.ItemMst;
import com.aselcni.lhs.model.TypeBig;
import com.aselcni.lhs.model.TypeMid;
import com.aselcni.lhs.model.TypeSml;
import com.aselcni.lhs.service.CustMstService;
import com.aselcni.lhs.service.ItemMstService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ItemmstController {
	
	private final CustMstService custMstService;
	private final ItemMstService itemMstService;
	
	@GetMapping("itemmst")
	public String itemMstList() {
		return "lhs/itemmstList";
	}
	
	@GetMapping("itemmstAddForm")
	public String itemmstAddForm(ItemMst itemMst,Model model) {
		List<CustMst> custList = custMstService.selectListCustByFlag(itemMst.getItem_flag());
		List<TypeBig> bigList = itemMstService.selectTypeBig();
		model.addAttribute("custList", custList);
		model.addAttribute("bigList", bigList);
		model.addAttribute("item_flag", itemMst.getItem_flag());
		return "lhs/itemmstaddForm";
	}
	
	@PostMapping("selectMid")
	@ResponseBody
	public List<TypeMid> selectMidList(TypeMid typeMid){
		List<TypeMid> midList = itemMstService.selectTypeMid(typeMid);
		return midList;
	}
	
	@PostMapping("selectSml")
	@ResponseBody
	public List<TypeSml> selectSmlList(TypeSml typeSml){
		List<TypeSml> smlList = itemMstService.selectTypeSml(typeSml);
		return smlList;
	}
	
	@PostMapping("itemCdChk")
	@ResponseBody
	public int itemCdChk(ItemMst itemMst) {
		int resultCnt = itemMstService.selectItemCnt(itemMst);
		return resultCnt;
	}
	
	@PostMapping("itemmstAdd")
	public String itemmstAdd(ItemMst itemMst,HttpServletRequest request) {
		itemMst.setItem_emp_id(request.getSession().getAttribute("user_id").toString());
		int result = itemMstService.insertItem(itemMst);
		return "redirect:/itemmst";
	}
	
}
