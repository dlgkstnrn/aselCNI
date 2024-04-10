package com.aselcni.lhs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.aselcni.lhs.service.LhsPaging;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ItemmstController {
	
	private final CustMstService custMstService;
	private final ItemMstService itemMstService;
	
	@GetMapping("itemmst")
	public String itemMstList(ItemMst itemMst,Model model) {
		if(itemMst.getItem_flag() == 0) {
			itemMst.setItem_flag(1);
		}
		int itemmstCnt = itemMstService.selectItemCnt(itemMst);
		LhsPaging page = new LhsPaging(itemmstCnt, itemMst.getCurrentPage());
		itemMst.setStart(page.getStart());
		itemMst.setEnd(page.getEnd());
		List<ItemMst> itemList = itemMstService.selectItemList(itemMst);
		List<TypeBig> bigList = itemMstService.selectTypeBig();
		model.addAttribute("itemList", itemList);
		model.addAttribute("itemMst", itemMst);
		model.addAttribute("page", page);
		model.addAttribute("bigList", bigList);
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
		int resultCnt = itemMstService.selectItemCntByitemCd(itemMst);
		return resultCnt;
	}
	
	@PostMapping("itemmstAdd")
	public String itemmstAdd(ItemMst itemMst,HttpServletRequest request) {
		itemMst.setItem_emp_id(request.getSession().getAttribute("user_id").toString());
		int result = itemMstService.insertItem(itemMst);
		return "redirect:/itemmst";
	}
	
	@PostMapping("itemmstSelectByitemCd")
	@ResponseBody
	public Map<String, Object> itemMidSmlSelectByitemCd(ItemMst itemMst){
		ItemMst itemOne = itemMstService.selectItemByitemCd(itemMst);
		TypeMid mid = new TypeMid();
		mid.setBig_no(itemOne.getBig_no());
		TypeSml sml = new TypeSml();
		sml.setBig_no(itemOne.getBig_no());
		sml.setMid_no(itemOne.getMid_no());
		List<TypeMid> midList = itemMstService.selectTypeMid(mid);
		List<TypeSml> smlList = itemMstService.selectTypeSml(sml);
		List<CustMst> custList = custMstService.selectListCustByFlag(itemOne.getItem_flag());
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("item", itemOne);
		resultMap.put("midList", midList);
		resultMap.put("smlList", smlList);
		resultMap.put("custList", custList);
		return resultMap;
	}
	
	@PostMapping("itemmstUpdate")
	public String itemmstUpdate(ItemMst itemMst) {
		System.out.println("test : " + itemMst);
		if(itemMst.getCust_cd() == null || itemMst.getCust_cd().equals("")) {
			itemMst.setCust_cd(null);
		}
		int result = itemMstService.updateItem(itemMst);
		return "redirect:/itemmst";
	}
	
	@GetMapping("itemDelete")
	public String itemmstDelete(ItemMst itemMst) {
		int result = itemMstService.deleteItem(itemMst);
		return "redirect:/itemmst";
	}
	
}
