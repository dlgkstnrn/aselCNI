package com.aselcni.jdj.service;

import static org.hamcrest.CoreMatchers.nullValue;

import java.math.BigInteger;
import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.jdj.dao.OrderDao;
import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.lhs.model.ItemMst;

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

}
                                     