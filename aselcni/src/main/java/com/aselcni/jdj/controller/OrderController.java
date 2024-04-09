package com.aselcni.jdj.controller;

import static org.hamcrest.CoreMatchers.nullValue;

import java.io.IOException;
import java.math.BigInteger;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.ItemMst;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.jdj.model.UserMst;
import com.aselcni.jdj.service.OrderService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {
	
	private final OrderService os;
	
	
//	조회
	@GetMapping("/order")
	public String order(Model model) {
		System.out.println("[Order_Controller] start..");
		List<CustMst> custMsts = null;
		List<Order> orders = null;		
		List<UserMst>  userMsts = null;
		int comm_code = 10030;
		try {
			orders = os.getOrders();
			custMsts = os.getCustLi();
			userMsts = os.getUserLi(10030);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

		model.addAttribute("orders", orders);
		model.addAttribute("custMsts", custMsts);
		model.addAttribute("userMsts", userMsts);

		return "jdj/orderMain";
	}
	
//	등록
	@GetMapping("/orderReg")
	public String orderReg(Model model) {
		
		List<CustMst> custMsts = null;
		List<ItemMst> itemMsts = null;
		
		try {
			custMsts = os.getCustLi();
			itemMsts = os.getItemLi();
			System.out.println("controller -> " + custMsts);
				
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		model.addAttribute("custMsts", custMsts);
		model.addAttribute("itemMsts", itemMsts);
		
		
		return "jdj/orderReg";
	}
		
	@GetMapping("/orderSpec")
	public String orderSpecString(@RequestParam(value = "detailView") String order_sec_num, Model model) {
		Order orderSpec = null;
		List<OrderItem> orderItems = null;
		try {
			System.out.println("controller, spec value ->  " + order_sec_num);
			
			orderSpec = os.getOrdSpec(order_sec_num);
			orderItems = os.getOrdItems(orderSpec.getOrder_no());
	
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		model.addAttribute("orderSpec", orderSpec);
		model.addAttribute("orderItems", orderItems);
		
		return "jdj/orderSpec";
	}
}
