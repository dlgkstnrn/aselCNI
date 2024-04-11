package com.aselcni.ujm.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.ujm.model.UjmOrder;
import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitem;
import com.aselcni.ujm.service.UjmOrderService;
import com.aselcni.ujm.service.UjmOutitemService;
import com.aselcni.ujm.service.UjmPaging;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
public class UjmOutitemController { 

	private final UjmOutitemService uos;
	
	@RequestMapping(value = "ujmExample") 
	public String ujmLoginForm(HttpServletRequest request) {
		return "ujm/example"; 
	}
	
	@RequestMapping(value = "outitem") 
	public String ujmOutitemForm(UjmOutitem outitem, HttpServletRequest request, Model model, HttpSession session) {
		System.out.println("출고페이지 접근");
		if(outitem.getCurrentPage()==null) {
			outitem.setCurrentPage("1");
		}
		
		int ujmTotalOutitemCnt=uos.ujmTotalOutitemCnt();
		System.out.println("가져온 출고 개수:"+ujmTotalOutitemCnt);
		model.addAttribute("totalOutitemCnt", ujmTotalOutitemCnt);
		
		UjmPaging page=new UjmPaging(ujmTotalOutitemCnt, outitem.getCurrentPage());
		
		outitem.setStart(page.getStart());
		outitem.setEnd(page.getEnd());
		
		model.addAttribute("page", page);
		
		
		List<UjmOutitem> ujmListOutitems=uos.ujmListOutitem(outitem);
		model.addAttribute("listOutitem", ujmListOutitems);
		//리스트 조회용
		
		//맨처음 리스트에 표시되는 outitemList
//		model.addAttribute("outitemList",outitemList); 
		
		return "ujm/ujmOutitem"; 
	}
	
	//출고 상세
//	@RequestMapping(value = "ujmGetAllOrderList")
//	public List<UjmOrder> ujmGetAllOrderList() {
//		System.out.println("ujmOutItem 컨트롤러 ujmGetAllOrderList 시작");
//		List<UjmOrder> ujmGetAllOrderList=uos.ujmGetAllOrderList();
//		return ujmGetAllOrderList;
//	}
	
	

	
	//출고 등록
	@RequestMapping(value = "insertOutitem") 
	public ResponseEntity<String> ujmInsertOutitem(@RequestBody List<OrderItemDTO>
			HttpServletRequest request, UjmOutitem outitem, Model model, HttpSession session) {
		System.out.println("ujmOutItem 컨트롤러 insertOutitem 시작");
		
//		outitem=new UjmOutitem();
		System.out.println(order_no);
		System.out.println(outitem);
		
		//맨처음 리스트에 표시되는 outitemList
//		model.addAttribute("outitemList",outitemList); 
		
		//outitemView
		
		return ResponseEntity.ok("주문이 성공적으로 처리되었습니다.");
		 
		
	}
	/*
	 * @RequestMapping(value = "insertOutitem") public String
	 * ujmInsertOutitem(@RequestParam() HttpServletRequest request, UjmOutitem
	 * outitem, Model model, HttpSession session) {
	 * System.out.println("ujmOutItem 컨트롤러 insertOutitem 시작");
	 * return "forward:outitem";
	 */
	
	
	
	
	
	//출고 수정
	@RequestMapping(value = "updateOutitem") 
	public String ujmUpdateOutitem(HttpServletRequest request, Model model, HttpSession session) {
		UjmOutitem outitem=new UjmOutitem();
		
		
		return "ujm/ujmOutitem"; 
	}
	
	//출고 삭제
	@RequestMapping(value = "deleteOutitem") 
	public String ujmDeleteOutitem(HttpServletRequest request, Model model, HttpSession session) {
		UjmOutitem outitem=new UjmOutitem();
		
		//맨처음 리스트에 표시되는 outitemList
//		model.addAttribute("outitemList",outitemList); 
		
		return "ujm/ujmOutitem"; 
	}
}
