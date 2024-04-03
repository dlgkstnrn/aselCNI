package com.aselcni.jdj.service;

import java.util.List;

import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;

public interface OrderService {

	// 주문 테이블 모두 가져오기	
	 List<Order> getOrderLi();

	String getCust_nm();

	Order getOrdSpec(String order_sec_num);
	
	List<OrderItem> getOrdItems(String order_no);
	
}
