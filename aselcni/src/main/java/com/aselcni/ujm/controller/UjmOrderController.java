package com.aselcni.ujm.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderItem;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.service.UjmOrderService;
import com.aselcni.ujm.service.UjmOutitemService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class UjmOrderController {
	
	private final UjmOrderService uor;
	
	//등록버튼 눌렀을 때 주문번호 가져오기
	@RequestMapping(value = "ujmGetOrderNo")
	@ResponseBody
    public List<UjmOrderNoDto> ujmGetOrderNo() {
		System.out.println("ujmOrder 컨트롤러 ujmGetOrderNo 시작");
		List<UjmOrderNoDto> ujmListOrderNo=uor.ujmGetOrderNo();
		System.out.println(ujmListOrderNo);
        return ujmListOrderNo;
    }
		
	//가져온 주문번호 중 하나 선택했을 때, 주문번호를 토대로 
	//출고등록 페이지에 조회용으로 뿌릴 order 정보들
	@RequestMapping(value = "ujmGetOrderInfoFromOrderNo")
	@ResponseBody
	public UjmOrderInfoToInsertDto ujmGetOrderInfoFromOrderNo(@RequestParam("order_no") String order_no, Model model) {
		System.out.println("ujmOrder 컨트롤러 ujmGetOrderNo 시작");
		UjmOrderInfoToInsertDto orderInfo=new UjmOrderInfoToInsertDto();
		orderInfo=uor.ujmGetOrderInfoFromOrderNo(order_no);
		model.addAttribute("orderInfo", orderInfo);
		return orderInfo;
	}
	
	//가져온 주문번호 중 하나 선택했을 때, 주문번호를 토대로 
	//출고등록 페이지에 조회용으로 뿌릴 주문품목 OrderItem 정보들
	@RequestMapping(value = "ujmGetOrderItem")
	@ResponseBody
	public List<UjmOrderItem> ujmGetOrderItem(@RequestParam("order_no") String order_no) {
		System.out.println("ujmOrder 컨트롤러 ujmGetOrderItem 시작");
		List<UjmOrderItem> ujmListOrderItem=uor.ujmGetOrderItem(order_no);
		System.out.println(ujmListOrderItem);
		return ujmListOrderItem;
	}
	
	@RequestMapping(value = "ujmCheckOrderDeleteChk")
	@ResponseBody
	public int ujmCheckOrderDeleteChk(@RequestParam("order_no") String order_no) {
		System.out.println("ujmOrder 컨트롤러 ujmCheckOrderDeleteChk 시작");
		int ujmCheckOrderDeleteChk=uor.ujmCheckOrderDeleteChk(order_no);
		System.out.println("ujmOrder 컨트롤러 ujmCheckOrderDeleteChk:"+ujmCheckOrderDeleteChk);
		return ujmCheckOrderDeleteChk;
	}
	
	@RequestMapping(value = "ujmCheckOrderCancelChk")
	@ResponseBody
	public int ujmCheckOrderCancelChk(@RequestParam("order_no") String order_no) {
		System.out.println("ujmOrder 컨트롤러 ujmCheckOrderCancelChk 시작");
		int ujmCheckOrderCancelChk=uor.ujmCheckOrderCancelChk(order_no);
		System.out.println("ujmOrder 컨트롤러 ujmCheckOrderCancelChk:"+ujmCheckOrderCancelChk);
		return ujmCheckOrderCancelChk;
	}
	
	
		
}
