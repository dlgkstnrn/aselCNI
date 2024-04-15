package com.aselcni.jdj.service;


import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.boot.model.naming.ImplicitNameSource;
import org.springframework.stereotype.Service;

import com.aselcni.jdj.dao.OrderDao;
import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.jdj.model.SavingOrd;
import com.aselcni.jdj.model.SavingOrdItem;
import com.aselcni.jdj.model.UserMst;
import com.aselcni.jdj.model.ItemMst;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	
	private final OrderDao od;
	public String ord_code  = "ORD"; 
	
	@Override
	public List<Order> getOrders(){
		System.out.println("[OS_getOrdLi Start...");
		List<Order> orders = null;
		try {
			orders = od.getOrders();
			System.out.println("os_getOrdLi -> " + orders);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return orders;
	}
	
	@Override
	public Order getOrdSpec(String order_sec_num) {
		Order order = null;
		try {
			System.out.println("[Order Service ] + " + order_sec_num);
			order = od.getOrdSpec(order_sec_num);
			
			System.out.println(ordTo16(ord_code) + "--ord");
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
	
	@Override
	public List<CustMst> getCustLi() {
		List<CustMst> custMsts = null;
		
		try {
			System.out.println("servcie getCustLi");
			custMsts = od.getCustLi();
			System.out.println("service_gtCustLi -> " + custMsts);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return custMsts;
	}
	
	
//	seq_no 만드는거
	public String strTo16(String order_no) {
		// seq_no 반환할 문자열
		String seq_no;
		
		// ORD이후의 문자열
		String ord_dtCodeString = order_no.substring(3);
		
		
		// 16진수로 변환
		BigInteger bigInt = new BigInteger(ord_dtCodeString);
		String dtTo16 = bigInt.toString(16);
		
		System.out.println("date to 16 -> " + dtTo16);
		
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
	public List<ItemMst> getItemLi() {
		List<ItemMst> itemMsts = null;
		try {
			itemMsts = od.getItemLi();
			System.out.println("service - itemMsts -> " + itemMsts);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return itemMsts;
	}

	@Override
	public List<UserMst> getUserLi(int i) {
		System.out.println("[OS_getUserLi Start...");
		List<UserMst> userMsts = null;
		try {
			userMsts = od.getUserLi(i);
			System.out.println("OS_getUserLi -> " + userMsts);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return userMsts;
	}

	@Override
	public ItemMst getItemInfo(String item_cd) {
		System.out.println("[OS_getItemInfo Start...");
		ItemMst itemMst = null;
		try {
			itemMst = od.getItemInfo(item_cd);
			System.out.println("OS_getItemInfo -> " + itemMst);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return itemMst;
	}
	
	// order Table 저장
	@Override
	public int regOrder(Order savingOrd) {
		System.out.println("[Service : savingOrd]");
//		ord번호 먼저 받고
		String order_no;
		String sec_no;
//		객체를 insert용 xml과 매핑
		int result;
		try {
			// 
			order_no = od.createOrdNo(savingOrd.getOrder_dt());
//		16진수 변환후 객체 저장
			sec_no = strTo16(order_no);
			System.out.println("new order_no 여기 있음 ---!!!!");
			savingOrd.setOrder_no(order_no);
			savingOrd.setOrder_sec_no(sec_no);
			
			result = od.regOrder(savingOrd);
			
			// savingOrd속 리스트객체 저장용으로 보내야함
			regOrderItem(savingOrd.getOrder_items(), order_no);
			
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return 0;
	}
	
	public void regOrderItem(List<HashMap<String, OrderItem>> order_items, String order_no) {
//		리스트 길이 만큼 반복해서 orderItem을 set해주고 od호출해서 저장
	    for (HashMap<String, OrderItem> map : order_items) {	// 리스트를 반복
	    	int result = 0;
	        for (Map.Entry<String, OrderItem> entry : map.entrySet()) {	// 각 해시맵 객체에 접근
	            String key = entry.getKey(); // 키 값 가져오기
	            OrderItem orderItem = entry.getValue(); // 값 가져오기
	            orderItem.setOrder_no(order_no);
	            
	            
	            
	            System.out.println("----------order_item setting 중--------");
	            System.out.println("regOrderItem : " + orderItem.getItem_cd());
	            System.out.println("regOrderItem : " + orderItem.getItem_nm());
	            System.out.println("regOrderItem : " + orderItem.getItem_cost());
	            
	            result = od.regOrderItem(orderItem);
	            
	            System.out.println("order item 입력 결과 -> " + result);
	            // 예를 들어, od.RegOrderItem(key, orderItem)와 같이 사용할 수 있습니다.
	        }
		  }
		
		
	}


}
                                     