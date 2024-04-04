package com.aselcni.jdj.service;

import java.util.List;

import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;

public interface OrderService {

//	주문 조회
	List<Order> getOrders();
	
//	주문 내역 상세
	Order getOrdSpec(String order_sec_num);
//	해당 주문의 품목들
	List<OrderItem> getOrdItems(String order_no);

//	거래처 리스트 가져오기
}
