package com.aselcni.jdj.service;

import java.util.List;

import com.aselcni.jdj.model.Order;

public interface OrderService {

	// 주문 테이블 모두 가져오기	
	 List<Order> getOrderLi();

	String getCust_nm();
	
}
