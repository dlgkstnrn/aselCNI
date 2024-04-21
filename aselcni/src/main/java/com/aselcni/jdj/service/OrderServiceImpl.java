package com.aselcni.jdj.service;


import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.boot.model.naming.ImplicitNameSource;
import org.springframework.stereotype.Service;

import com.aselcni.jdj.dao.OrderDao;
import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.FindOrd;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.jdj.model.UserMst;
import com.aselcni.jdj.model.ItemMst;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	
	private final OrderDao od;
	public String ord_code  = "ORD"; 
	
	// Main 페이지 //
	@Override											// 주문 전체 조회
	public List<Order> getOrderLi() {
		System.out.println("[Service - getOrderLi :주문조회 리스트 전체");
		List<Order> orderLi = null;
		
		try {
			orderLi = od.getOrderLi();
			System.out.println("[Service - getOrderLi :주문조회 리스트 결과" + orderLi);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return orderLi;
	}

	@Override
	public List<Order> getOrderLi(int offset, int limit) {
		System.out.println("[Service - getOrderLi :주문조회 리스트 전체");
		List<Order> orderLi = null;
		
		try {
			orderLi = od.getOrderLi(offset, limit);
			System.out.println("[Service - getOrderLi :주문조회 결과 사이즈" + orderLi.size());
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return orderLi;
	}
	@Override
	public List<CustMst> getCustMstLi() {		// 고객사 전체 조회
		System.out.println("[Service - getCustMstLi Start");
		List<CustMst> custMstLi = null;
		
		try {
			custMstLi = od.getCustMstLi();
			System.out.println("[Service - getCustMstLi Fin");
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return custMstLi;
	}

	@Override
	public List<UserMst> getUserMstLi(int user_comm_code) {	// 영업 사원 코드
		System.out.println("[Service - getCustMstLi Start");
		List<UserMst> userMstLi = null;
		
		try {
			userMstLi = od.getUserMstLi(user_comm_code);
			System.out.println("[Service - getCustMstLi Fin");
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return userMstLi;
	}
	//-----------------------------------------------------
	// 주문 등록
	
	@Override		// 아이템 목록 출력
	public List<ItemMst> getItemMstLi() {
		List<ItemMst> itemMstLi = null;
		System.out.println("[Service - getitemMstLi Start");
		try {
			itemMstLi = od.getItemMstLi();
			System.out.println("[Service - getitemMstLi Fin");
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		return itemMstLi;
	}
	
	// order Table 저장
	@Override
	public int regOrder(Order savingOrd) {
		System.out.println("[Service - regOrder Start");
//		ord번호 먼저 받고
		String order_no;
		String sec_no;
//		객체를 insert용 xml과 매핑
		int result = 0;
		try {
			order_no = od.createOrdNo(savingOrd.getOrder_dt());
			sec_no = strTo16(order_no); 	// 16진수 변환후 객체 저장
			savingOrd.setOrder_no(order_no);
			savingOrd.setOrder_sec_no(sec_no);
			
			result = od.regOrder(savingOrd);
			
			// savingOrd속 리스트객체 저장용으로 보내야함
			regOrderItems(savingOrd.getOrder_items(), order_no);
			System.out.println("[Service - regOrder Fin");
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return result;
	}
	// order_item table 저장
	public void regOrderItems(List<HashMap<String, OrderItem>> order_items, String order_no) {
//		리스트 길이 만큼 반복해서 orderItem을 set해주고 od호출해서 저장
	    for (HashMap<String, OrderItem> map : order_items) {	// 리스트를 반복
	    	int result = 0;
	        for (Map.Entry<String, OrderItem> entry : map.entrySet()) {	// 각 해시맵 객체에 접근
	            String key = entry.getKey(); // 키 값 가져오기
	            OrderItem orderItem = entry.getValue(); // 값 가져오기
	            orderItem.setOrder_no(order_no);
	            result = od.regOrderItems(orderItem);
	            System.out.println("order item 입력 결과 -> " + result);
	        }
		  }	
	}
	
	//-----------------------------------------------------
	// 주문 상세 //
	@Override
	public Order getOrdSpec(String order_sec_num) {
		Order order = null;
		try {
			System.out.println("[Order Service ] + " + order_sec_num);
			order = od.getOrdSpec(order_sec_num);
			
			System.out.println(order + "-----------ord");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		
		return order;
	}
	
	
	@Override
	public List<OrderItem> getOrdItems(String order_no){
		List<OrderItem> items = null;
		
		try {
			System.out.println("[service] getOrdItem List order_no -> " + order_no);
			items = od.getOrdItems(order_no);	
		} catch (Exception e) {
			 System.err.println(e.getMessage());
		}
		return items;
	}
	

	
	
	
//	seq_no 만드는거
	public String strTo16(String order_no) {
		// ORD이후의 문자열
		String ord_dtCodeString = order_no.substring(3);
		
		// 16진수로 변환
		BigInteger bigInt = new BigInteger(ord_dtCodeString);
		String dtTo16 = bigInt.toString(16);
	
		return dtTo16;
	}
	
	public String ordTo16(String strOrd) {
		char[] cha_ord_code = ord_code.toCharArray();
		String rt_ord_code = "";
		
		for(char chOrd : cha_ord_code) {
			int ascii = (int)chOrd;
			rt_ord_code += String.valueOf(ascii);
		}
		
		return rt_ord_code;
	}





	@Override
	public ItemMst getItemInfo(String item_cd) {
		System.out.println("[OS_getItemInfo Start...");
		ItemMst itemMst = null;
		try {
			itemMst = od.getItemInfo(item_cd);
			System.out.println("OS_getItemInfo -> " + itemMst);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return itemMst;
	}

	@Override
	public int delOrd(String order_no) {
		System.out.println("[Service delOrd _ Start ");
		
		try {
			od.delOrd(order_no);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());	
		}
		return 0;
	}

	@Override
	public void editOrd(Order editOrd) {
		System.out.println("Service editOrd _ Start");
	
		try {
			od.editOrd(editOrd);
			editOrdItems(editOrd.getOrder_items(), editOrd.getOrder_no());
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		System.out.println("Service editOrd _ Fin");
		
	}
	
	// order_item table 저장
	public void editOrdItems(List<HashMap<String, OrderItem>> order_items, String order_no) {
		System.out.println("[Dao => Strat");
		//		리스트 길이 만큼 반복해서 orderItem을 set해주고 od호출해서 저장
	    for (HashMap<String, OrderItem> map : order_items) {	// 리스트를 반복
	    	int result = 0;
	        for (Map.Entry<String, OrderItem> entry : map.entrySet()) {	// 각 해시맵 객체에 접근
	            String key = entry.getKey(); // 키 값 가져오기
	            System.out.println("-------editOrdItems kdy -> " + key);
	            OrderItem orderItem = entry.getValue(); // 값 가져오기
	            orderItem.setOrder_no(order_no);
	            orderItem.setItem_cd(key);
	            result = od.editOrdItems(orderItem);
	            System.out.println("order item 입력 결과 -> " + result);
	        }
		  }	
	    System.out.println("[Dao => Fin");
	}
	
	// 주문번호로 검색
	@Override
	public Order findOrdByNum(String order_no) {
		System.out.println("[Service - findOrdByNum start---");
		Order findOrder = null;
		try {
			findOrder = od.findOrdByNum(order_no);

		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return findOrder;
	}

	@Override
//	public List<Order> findOrd(FindOrd findOrd) {
	public List<Order> findOrd(FindOrd findOrd, int offset, int limit) {
		System.out.println("[Service - findOrd Start...");
		List<Order> findOrders = null;
		try {
			findOrders = od.findOrd(findOrd, offset, limit);
//			findOrders = od.findOrd(findOrd);
			System.out.println("[Service -findOrd Fin... " + findOrders.size() + "findOrder size -----여기다!@#!#@#!3");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return findOrders;
	}

	@Override
	public UserMst getUserInfo(String user_id) {
		System.out.println("[Service - getUserInfo Start...");
		UserMst regUserInfo = null;
		try {
			regUserInfo = od.getUserInfo(user_id);
			System.out.println("[Service -findOrd Fin... " + regUserInfo);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return regUserInfo;
	}

	@Override
	public int getOrdersLen() {
		try {
			return od.getOrdersLen();
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		return 0;
	}







}
                                     