package com.aselcni.jdj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.service.OrderService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {
	
	private final OrderService os;
	
	
	@GetMapping("/order")
	public String order(Model model) {
		Order order = new Order();
		
		// service에게 order테이블 요청
		order = os.getOrderLi();
		
	
		
		return "jdj/orderList"; 
	}
	
	@GetMapping("/ord")
	public String ord() {
		return "jdj/orderList";
	}
	
	@GetMapping("/orderReg")
	public String orderList() {
		return "jdj/orderSpec";
	}
	
	@GetMapping("/orderSpec")
	public String order2() {
		return "jdj/orderRegistration";
	}
}
