package com.aselcni.jdj.model;

import lombok.Data;

@Data
public class OrderItem {
	
	String order_no;
	String item_cd;	// 제품코드
	int qty;		// 수량
	int cost;		// 가격
	
	// itemMst 일부 -> for 주문상세
	String item_nm;
	String item_unit;
	
}
