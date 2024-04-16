package com.aselcni.ujm.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.ujm.model.UjmOrder;
import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderItem;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitem;
import com.aselcni.ujm.model.UjmOutitemParent;
import com.aselcni.ujm.service.UjmOrderService;
import com.aselcni.ujm.service.UjmOutitemService;
import com.aselcni.ujm.service.UjmPaging;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class UjmOutitemController { 

	private final UjmOutitemService uos;
	
	private final UjmOrderService uor;

	
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
		
		return "ujm/ujmOutitem"; 
	}
	
	

	
	//출고 등록
	@RequestMapping(value = "insertOutitem") 
	public String ujmInsertOutitem(@RequestBody UjmOutitemParent insertData, HttpSession session) {
		System.out.println("ujmOutItem 컨트롤러 insertOutitem 시작");
		if(session.getAttribute("user_id")!=null) {
			String userId=(String)session.getAttribute("user_id");
			// service, dao, mapper명(insertEmp)까지->insert
			
			insertData.getOutitemData().setOutitem_no(uos.ujmSetOutitemNo(insertData.getOutitemData().getOutitem_no())); 
			//가져온 날짜형태의 출고번호(2024-04-13)을 제대로 만들기
	        System.out.println(insertData.getOutitemData().getOutitem_no());
			
			int insertOutitemResult = uos.ujmInsertOutitem(insertData, userId); //출고테이블 등록, 정상등록시 1 비정상 -1 리턴
			System.out.println("컨트롤러 insertOutitemResult:"+insertOutitemResult);
			
			
			int insertOutitemItemResult=uos.ujmInsertOutitemItem(insertData); //출고품목을 등록, 품목개수 리턴
			System.out.println("insertOutitemItemResult"+insertOutitemItemResult);
			
			int ujmChangeOrderStatusChk=uor.ujmChangeOrderStatusChk(insertData.getOutitemData().getOrder_no()); 
			//주문의 상태 변경하기
			
			System.out.println("ujmChangeOrderStatusChk"+ujmChangeOrderStatusChk);
			
		
		return "ujm/ujmOutitem";
		 
		} else {
			System.out.println("로그인 안됨");
			return "redirect:/";
			}
	}

	//각 테이블 행 눌렀을 때 조회 : 출고 관련 정보들 가져오기
	@RequestMapping(value = "ujmGetOutitemDetail")
	@ResponseBody
    public List<UjmOutitem> ujmGetOutitemDetail(
    		@RequestParam("outitem_no") String outitem_no,
    		@RequestParam("order_no") String order_no) {
		System.out.println("UjmOutitem 컨트롤러 ujmGetOutitemDetail 시작");
		List<UjmOutitem> ujmListOutItemDetail=uos.ujmGetOutitemDetail(outitem_no, order_no);
		System.out.println(ujmListOutItemDetail);
		return ujmListOutItemDetail;
	}
	
	//주문 상세 조회에서, 수정버튼 눌렀을 때 정보 가져오기
	@RequestMapping(value = "ujmGetOutitemToUpdate")
	@ResponseBody
	public List<UjmOutitem> ujmGetOutitemToUpdate(@RequestParam("order_no") String order_no, 
			@RequestParam("outitem_no") String outitem_no) {
		System.out.println("컨트롤러UjmOutitem : ujmGetOutitemToUpdate 시작");
		List<UjmOutitem> ujmListOutitem=uos.ujmGetOutitemToUpdate(order_no, outitem_no);
		System.out.println(ujmListOutitem);
		return ujmListOutitem;
	}
		
	
	
	
	
	//출고 수정
	@RequestMapping(value = "updateOutitem") 
	public String ujmUpdateOutitem(HttpSession session) {
		System.out.println("컨트롤러UjmOutitem : updateOutitem 시작");
		
		return "ujm/ujmOutitem"; 
	}
	
	

	
	//출고 삭제
	@RequestMapping(value = "deleteOutitem") 
	public String ujmDeleteOutitem(HttpServletRequest request, Model model, HttpSession session) {
		UjmOutitem outitem=new UjmOutitem();
		
		
		return "ujm/ujmOutitem"; 
	}
}
