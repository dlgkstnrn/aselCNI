package com.aselcni.pjh.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.main.model.MenuMst;
import com.aselcni.pjh.model.PJHInitem;
import com.aselcni.pjh.model.PJHPurchase;
import com.aselcni.pjh.model.PJHPurchaseItem;
import com.aselcni.pjh.model.PJHWhmst;
import com.aselcni.pjh.service.PJHServiceInterface;
import com.aselcni.pjh.service.Paging;
import com.oracle.wls.shaded.org.apache.xpath.operations.Mod;

import jakarta.mail.Session;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class PJHController {
	
	private final PJHServiceInterface service; 
	
	@RequestMapping("initem")
	public String initemView(HttpServletRequest request, Model model) {
		if(request.getSession().getAttribute("user_id") == null) {
			return "redirect:/";
		}
		
		System.out.println(request.getSession().getAttribute("menuListGroupByMenu"));
		List<List<MenuMst>> menuListGroupByMenu = (List<List<MenuMst>>)request.getSession().getAttribute("menuListGroupByMenu");
		List<MenuMst> menus = menuListGroupByMenu.stream().flatMap(List<MenuMst>::stream).collect(Collectors.toList());
		
		if(menus.size()>0) {
			byte flag = 0;
			for(MenuMst menu : menus) {
				System.out.println(menu.getUrl());
				if("initem".equals(menu.getUrl()))
						flag++;
			}
			if(flag == 0)
				return "redirect:main";
		}
		
		
		PJHInitem initem = new PJHInitem();
		Paging page = pagination(initem);
		
		model.addAttribute("initems",getInItemList(initem, page));
		model.addAttribute("page",page);
		
		return "pjh/initemView";
	}
	
	
	@ResponseBody
	@GetMapping("searchInitems")
	public Map<String, Object> searchInitems(PJHInitem initem){
		System.out.println("PJHController searchInitems start...");
		System.out.println("PJHController searchInitems param->"+ initem);
		
		Map<String, Object> response = new HashMap<String, Object>();
		Paging page = pagination(initem);
		response.put("page", page);
		response.put("initems", getInItemList(initem, page));
		
		System.out.println("PJHController searchInitems response->"+ response);
		return response;
	}
	
	private Paging pagination(PJHInitem initem) {
		System.out.println("PJHController pagination start...");
		System.out.println("PJHController pagination param->"+ initem);
		
		int total = service.getTotalInitemNum(initem);
		System.out.println("PJHController pagination total->"+ total);
		
		Paging page = new Paging(total, initem.getCurrentPage());
		
		System.out.println("PJHController pagination page->"+ page);
		initem.setStart(page.getStart());
		initem.setRowPage(page.getRowPage());
		initem.setStartPage(page.getStartPage());
		initem.setEndPage(page.getEndPage());
		System.out.println("PJHController pagination initem->"+ initem);
		
		return page;
	}
	
	private List<PJHInitem> getInItemList(PJHInitem initem, Paging page){
		System.out.println("PJHController getInItemList start...");
		List<PJHInitem> initems = new ArrayList<PJHInitem>();
		if(page.getTotal() != 0)
			initems = service.getInitemList(initem);
		System.out.println("PJHController getInItemList initems->"+ initems);
		return initems;
	}
	
	@ResponseBody
	@GetMapping("/detailInitem")
	public PJHInitem detailInitem(PJHInitem initem) {
		System.out.println("PJHController detailInitem start...");
		System.out.println("PJHController detailInitem param->"+ initem);
		PJHInitem resultInitem = service.detailInitem(initem);
		System.out.println("PJHController detailInitem result->"+ resultInitem);
		System.out.println("PJHController detailInitem items.size->"+ resultInitem.getInItems().size());
		return resultInitem;
	}
	
	
	@RequestMapping("/initemWrite")
	public String initemWriteView(HttpServletRequest request, Model model) {
		if(request.getSession().getAttribute("user_id") == null) {
			return "redirect:/";
		}
		
		List<PJHWhmst> whmsts = service.getWhList();
		System.out.println("PJHController initemWriteView whmsts.size()->"+ whmsts.size());
		model.addAttribute("whs", whmsts);
		return "pjh/initemWriteView";
	}

	@ResponseBody
	@GetMapping("/searchPurc")
	public Object searchPurc(PJHPurchase purchase) {
		System.out.println("PJHController searchPurc start...");
		System.out.println("PJHController searchPurc purchase->"+ purchase);
		List<PJHPurchase> purchases = service.searchPurc(purchase);
		System.out.println("PJHController searchPurc purchases->"+ purchases);
		return purchases;
	}
	
	@ResponseBody
	@GetMapping("/purcItemList")
	public List<PJHPurchaseItem> getItemsByPurc(PJHPurchaseItem purchaseItem){
		System.out.println("PJHController getItemsByPurc start...");
		System.out.println("PJHController getItemsByPurc purchaseItem->"+ purchaseItem);
		
		List<PJHPurchaseItem> purchaseItems = service.getItemsByPurc(purchaseItem.getPurc_no());
		
		System.out.println("PJHController getItemsByPurc purchaseItems->"+ purchaseItems);
		
		return purchaseItems;
	}
	
	@ResponseBody
	@PostMapping("/regInitem")
	public Map<String, String> registInitem(HttpServletRequest request,@RequestBody PJHInitem initem){
		System.out.println("PJHController registInitem start...");
		System.out.println("PJHController registInitem param->"+ initem);
		String user_id = (String) request.getSession().getAttribute("user_id");
		
		Map<String, String> response = new HashMap<String, String>();
		if(user_id == null || user_id == "") {
			response.put("success", "false");
			response.put("errCode", "login");
			response.put("errMsg","로그인 후 시도해주세요");
			return response;
		}
		
		initem.setInitem_emp_id(user_id);
		
		int result = service.registInitem(initem);
		System.out.println("PJHController registInitem result->"+ result);
		
		response.put("success", "true");
		return response;
	}
	
	
	@ResponseBody
	@PostMapping("/updateInitem")
	public String updateInitem(@RequestBody PJHInitem initem,HttpServletRequest request) {
		System.out.println("PJHController updateInitem start...");
		initem.setInitem_emp_id((String)request.getSession().getAttribute("user_id"));
		System.out.println("PJHController updateInitem param->"+ initem);
		
		int result = service.updateInitem(initem);
		
		if(result <= 0) {
			return "fail";
		}
		return "success";
	}
	
	@ResponseBody
	@DeleteMapping("deleteInitem")
	public String deleteInitem(HttpServletRequest request,PJHInitem initem) {
		System.out.println("PJHController deleteInitem start...");
		initem.setInitem_emp_id((String)request.getSession().getAttribute("user_id"));
		System.out.println("PJHController deleteInitem param->"+ initem);
		
		int result = service.deleteInitem(initem);
		
		if(result <= 0) {
			return "fail";
		}
		return "success";
	}
	
}

