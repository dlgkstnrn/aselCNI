package com.aselcni.jdj.controller;



import static org.hamcrest.CoreMatchers.nullValue;

import java.io.Console;
import java.io.IOException;
import java.math.BigInteger;
import java.util.List;

import org.hibernate.Length;
import org.hibernate.query.spi.Limit;
import org.springframework.boot.autoconfigure.condition.ConditionMessage.ItemsBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.FindOrd;
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
import jakarta.servlet.jsp.jstl.sql.Result;
import lombok.RequiredArgsConstructor;
import net.bytebuddy.implementation.bind.annotation.Pipe;
import jakarta.servlet.http.HttpSession;


@Controller
@RequiredArgsConstructor
public class OrderController {
	
	private final OrderService os;
	
	
//	조회
	@GetMapping("/order")
	public String order(Model model, @RequestParam(value="page", defaultValue = "1") int currPage) {
		System.out.println("[curr페이지는 이거아아ㅏㅇ아ㅏㅇ아 " + currPage);
		List<CustMst> custMstLi = null;	// 매입처 리스트
		List<Order> orderLi = null;		// 주문 조회
		List<UserMst>  userMstLi = null;	// 매입처 리스트
		int comm_code = 10030;			// 영업사원 코드
		int totalPage = 0;
		int limit = 10;
		int offset = (currPage -1) * limit;
		try {
			orderLi = os.getOrderLi(offset, limit);	
			
			custMstLi = os.getCustMstLi();
			userMstLi = os.getUserMstLi(comm_code); 
			totalPage = (int)Math.ceil((double)os.getOrdersLen() /  limit);
			System.err.println("토탈이 이거다ㅏ아앙 -> " + totalPage);
			
			System.out.println("--------------------------------");
			System.out.println("list 길이는 ->>>>>>> " + totalPage);
			System.out.println("[order_ orderLi]" + orderLi);
			System.out.println("[order_ custMstLi]" + custMstLi);
			System.out.println("[order_ userMstLi]" + userMstLi);
			System.out.println("---------------------------------");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

		model.addAttribute("orders", orderLi);
		model.addAttribute("custMsts", custMstLi);
		model.addAttribute("userMsts", userMstLi);
		model.addAttribute("totalPage", totalPage);
//		model.addAttribute()

		return "jdj/orderMain";
	}
	@PostMapping("/order")
	@ResponseBody
	public List<Order> findOrd(Model model, @RequestBody FindOrd findOrd) {
		System.out.println("[Controller - findOrdByNum Start :" + findOrd);
//		int offset = 1;
		int limit = 10;
		int offset = ((findOrd.getCurrPage()-1) * limit);
		int totalPage;
		List<Order> findOrder = null;
		try {
			findOrder = os.findOrd(findOrd, offset, limit);
//			findOrder = os.findOrd(findOrd);
//			findOrder = os.findOrdByNum(order_no);
		}catch(Exception e){
			System.err.println(e.getMessage());
		}
		totalPage = (int)Math.ceil((double)findOrder.size() /  limit);
		System.out.println("findOrder ->>> " + totalPage);
		model.addAttribute("totalPage", totalPage);
		
		return findOrder;
	}
	
	
// -----------------------------------------------
//	등록
	@GetMapping("/orderReg")
	public String orderReg(Model model, HttpSession session) {
		
		System.out.println("[Controller - orderReg.jsp / orderReg @GetMapping Start");
		List<CustMst> custMstLi = null;	// 고객사 리스트
		List<ItemMst> itemMstLi = null;	// 제품 모달용 리스트;
		UserMst regUserInfo = null;
		String user_id = "";
		
		if(session.getAttribute("user_id") != null) {
			user_id = (String)session.getAttribute("user_id");
		}
		System.out.println("user_id : " + user_id);
		try {
			// user_comm_code로 user 정보 가져와야함
			regUserInfo = os.getUserInfo(user_id);
			custMstLi = os.getCustMstLi();
			itemMstLi = os.getItemMstLi();
			
			
			System.out.println("[orderReg_ custMstLi]" + custMstLi);
			System.out.println("[orderReg_ itemMstLi]" + itemMstLi);
			System.out.println("---------------------------------");
		}catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		model.addAttribute("regUserInfo", regUserInfo);
		model.addAttribute("custMsts", custMstLi);
		model.addAttribute("itemMsts", itemMstLi);
		
		return "jdj/orderReg";
	}
	
	// 제품 등록 모달
	@PostMapping("/orderReg")
	@ResponseBody
	public ItemMst itemAdd(@RequestParam("order_item_cd") String order_item_cd) {
		ItemMst itemMst = null;
		System.out.println("[Controller - orderReg.jsp / 모달  @PostMapping Start");
		
		try {

			itemMst = os.getItemInfo(order_item_cd);
			System.out.println("[orderReg_ itemMst]" + itemMst);
			System.out.println("---------------------------------");
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}		
		
		return itemMst;
	}
	
	// 주문 등록 버튼, 저장
	@PostMapping("/saveOrd")
	public String saveOrd(@RequestBody Order savingOrd) {
		System.out.println("[Controller - orderReg.jsp / 주문 저장 버튼  @PostMapping Start");
		int result;
		try {
			// oder table 저장하는 서비스 호출
			result = os.regOrder(savingOrd);
			System.out.println("[orderReg_ saveOrd]" + result);
			System.out.println("---------------------------------");
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		return "redirect:order";
	}
	
	
	
//	-----------------------------------------------
//	제품 상세
	
	@GetMapping("/orderSpec")
	public String orderSpec(@RequestParam(value = "detailView") String order_sec_num, Model model) {
		Order orderSpec = null;
		List<OrderItem> orderItems = null;
		List<ItemMst> itemMstLi = null;
		try {
			System.out.println("controller, spec value ->  " + order_sec_num);
			
			orderSpec = os.getOrdSpec(order_sec_num);
			orderItems = os.getOrdItems(orderSpec.getOrder_no());
			itemMstLi = os.getItemMstLi();
			
			System.out.println(" -- orderSpec [cnotroller]" + orderSpec.getOrder_no());
		}catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		model.addAttribute("orderSpec", orderSpec);
		model.addAttribute("orderItems", orderItems);
		model.addAttribute("itemMsts", itemMstLi);
		
		return "jdj/orderSpec";
	}

	@PostMapping("/orderSpec")
	@ResponseBody
	public List<OrderItem> orderSpecItems(Order order){
		List<OrderItem> orderItems = null;
		try {
			orderItems = os.getOrdItems(order.getOrder_no());
			System.out.println("[ Controller ] - orderSpecItmes" + orderItems);
		} catch (Exception e) {
			System.err.println(e.getMessage());
			
		}
		return orderItems;
	}
	
	@PostMapping("/delOrd")
	public String delOrd(@RequestBody Order delOrd) {
		String order_no = delOrd.getOrder_no();
		int result = 0;
		try {
			result = os.delOrd(order_no);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		System.out.println("order_no : " + order_no);
		return "redirect:order";
	}
	
	@PostMapping("/editOrd")
	public String editOrd(@RequestBody Order editOrd) {
		String order_no = editOrd.getOrder_no();	
		System.out.println("[Controller - editOrd]" + editOrd.getRemark());
		System.out.println("[Controller - editOrd]" + editOrd.getOrder_end_dt());
		System.out.println("[Controller - editOrd]" + editOrd.getCust_nm());
		System.out.println("[Controller - editOrd]" + editOrd.getOrder_items());
		System.out.println("===================================");
	
		
//		int result = 0;
		try {
			
			os.editOrd(editOrd);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		return "redirect:order";
	}
}